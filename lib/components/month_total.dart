import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:habit_tracker/timing/date_time.dart';

class MonthTotal extends StatelessWidget {
  final Map<DateTime, int>? datasets;
  final String startDate;

  const MonthTotal({
    super.key,
    required this.datasets,
    required this.startDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 25, bottom: 25),
        child: HeatMap(

          startDate: createDateTimeObject(startDate),
          endDate: DateTime.now().add(const Duration(days: 0)),
          datasets: datasets,

          colorMode: ColorMode.color,
          defaultColor: Colors.white,
          textColor: Colors.black,

          fontSize: 25,

          showColorTip: true,
          colorTipSize: 15,
          colorTipCount: 10,
          showText: true,
          scrollable: true,
          size: 50,

          colorsets: const {
            1: Color.fromARGB(70, 229, 43, 80),
            2: Color.fromARGB(120, 229, 43, 80),
            3: Color.fromARGB(170, 229, 43, 80),
            4: Color.fromARGB(220, 229, 43, 80),
            5: Color.fromARGB(255, 229, 43, 80),
          },
          // onClick: (value) {
          //   ScaffoldMessenger.of(context)
          //       .showSnackBar(SnackBar(content: Text(value.toString())));
          // },
        ));
  }
}
