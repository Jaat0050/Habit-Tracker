import 'package:flutter/material.dart';
import 'package:habit_tracker/components/button.dart';
import 'package:habit_tracker/components/habit_tile.dart';
import 'package:habit_tracker/components/month_total.dart';
import 'package:habit_tracker/components/new_habit_box.dart';
import 'package:habit_tracker/data/habit_database.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HabitDatabase db = HabitDatabase();
  final _myBox = Hive.box("Habit_database");

  @override
  void initState() {
    //checking of data if it exists or not
    if (_myBox.get("CURRENT_HABIT_LIST") == null) {
      db.createDefaultData();
    } else {
      db.loadData();
    }

    //update the database
    db.updateDatabase();

    super.initState();
  }

  //checkbox tapped
  void checkboxtapped(bool? value, int index) {
    setState(
      () {
        db.todayHabitList[index][1] = value;
      },
    );
    db.updateDatabase();
  }

  final _newHabitNameController = TextEditingController();

  //for creating new habit
  void createNewHabit() {
    // it show a dialog box for new habits
    showDialog(
      context: context,
      builder: (context) {
        return NewHabitbox(
          controller: _newHabitNameController,
          hintText: 'Type New Habit',
          onSaved: saveNewHabit,
          onCancel: cancelNewHabit,
        );
      },
    );
    db.updateDatabase();
  }

  //save new habit
  void saveNewHabit() {
    //add new habit today habit list
    setState(() {
      db.todayHabitList.add([_newHabitNameController.text, false]);
    });

    //clear the textfield
    _newHabitNameController.clear();
    //pop dialog box
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  // cancel new habit
  void cancelNewHabit() {
    //clear the textfield
    _newHabitNameController.clear();
    //pop dialog box
    Navigator.of(context).pop();
  }

  //open habbit settings to edit
  void openhabitSettings(int index) {
    showDialog(
      
      context: context,
      builder: (context) {
        return NewHabitbox(
          controller: _newHabitNameController,
          onSaved: () => saveExistingHabit(index),
          onCancel: cancelNewHabit,
          hintText: db.todayHabitList[index][0],
        );
      },
    );
  }

  //save existing habit with new name
  void saveExistingHabit(int index) {
    setState(() {
      db.todayHabitList[index][0] = _newHabitNameController.text;
    });
    _newHabitNameController.clear();
    Navigator.pop(context);
    db.updateDatabase();
  }

  //delete habit
  void deleteHabit(int index) {
    setState(() {
      db.todayHabitList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink[200],

        //floating button new habit
        floatingActionButton: MyButton(onPressed: createNewHabit),

        body: ListView(
          children: [
            //month total
            MonthTotal(datasets: db.heatMapDataSet, startDate: _myBox.get('START_DATE')),

            //list of habits
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: db.todayHabitList.length,
              itemBuilder: (context, index) {
                return HabitTile(
                  habitName: db.todayHabitList[index][0],
                  habitCompleted: db.todayHabitList[index][1],
                  onChanged: (value) => checkboxtapped(value, index),
                  settingtapped: (context) => openhabitSettings(index),
                  deletetapped: (context) => deleteHabit(index),
                );
              },
            ),
          ],
        ));
  }
}
