import 'package:flutter/foundation.dart';
import 'package:habit_tracker/timing/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';

// reference our box
final _myBox = Hive.box("Habit_Database");

class HabitDatabase {
  List todayHabitList = [];
  Map<DateTime, int> heatMapDataSet = {};

  //3 operation

  //create initial default data
  void createDefaultData() {
    todayHabitList = [
      ["hy", false],
      ["bye", false],
    ];

    _myBox.put("START_DATE", todayDateFormatted());
  }

  //load data if it already exists
  void loadData() {
    //if its anew day, get habit list from database
    if (_myBox.get(todayDateFormatted()) == null) {
      todayHabitList = _myBox.get("CURRENT_HABIT_LIST");

      //we set all the new habit to false , since its new day
      for (int i = 0; i < todayHabitList.length; i++) {
        todayHabitList[i][1] = false;
      }
    }

    //if ts not new day ,load data from database
    else {
      todayHabitList = _myBox.get(todayDateFormatted());
    }
  }

  //update the database
  void updateDatabase() {
    //update today entry
    _myBox.put(todayDateFormatted(), todayHabitList);

    //update universal habit list in case it changed(new habit,edit habit,habit delete)
    _myBox.put("CURRENT_HABIT_LIST", todayHabitList);

    //Calculate habit complete percentage for each day
    calculateHabitPercentage();

    //load heat map
    loadheatMap();
  }

  void calculateHabitPercentage() {
    int countComplete = 0;
    for (int i = 0; i < todayHabitList.length; i++) {
      if (todayHabitList[i][1] == true) {
        countComplete++;
      }
    }

    String percent = todayHabitList.isEmpty
        ? '0.0'
        : (countComplete / todayHabitList.length).toStringAsFixed(1);

    //key - "percentage summary yyyymmdd"
    //value - string of 1dp number between 0.0 - 1.0 inclusion
    _myBox.put("PERCENTAGE_SUMMARY_${todayDateFormatted()}", percent);
  }

  void loadheatMap() {
    DateTime startDate = createDateTimeObject(_myBox.get("START_DATE"));

    //count the number of days as load
    int dayInBetween = DateTime.now().difference(startDate).inDays;

    //go from start date date to today and add each percentage to the datasets
    //"percentage_summary_yyyymmdd" will be key in the database
    for (int i = 0; i < dayInBetween + 1; i++) {
      String yyyymmdd = convertDateTimeToString(
        startDate.add(Duration(days: i)),
      );

      double strengthAsPercent = double.parse(
        _myBox.get("PERCENTAGE_SUMMARY_$yyyymmdd") ?? "0.0",
      );

      //split the date time up like below so it does not worry about h/min/sec etc

      //year
      int year = startDate.add(Duration(days: i)).year;

      //month
      int month = startDate.add(Duration(days: i)).month;

      //day
      int day = startDate.add(Duration(days: i)).day;

      final percentForEachDay = <DateTime, int>{
        DateTime(year, month, day): (5 * strengthAsPercent).toInt(),
      };

      heatMapDataSet.addEntries(percentForEachDay.entries);
      if (kDebugMode) {
        print(heatMapDataSet);
      }
    }
  }
}
