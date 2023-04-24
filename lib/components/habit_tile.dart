

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final bool? habitCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? settingtapped;
  final Function(BuildContext)? deletetapped;

  const HabitTile({
    super.key,
    required this.habitName,
    required this.habitCompleted,
    required this.onChanged,
    required this.settingtapped,
    required this.deletetapped,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          // setting option
          SlidableAction(
            onPressed: settingtapped,
            borderRadius: BorderRadius.circular(12),
            icon: Icons.settings,
            backgroundColor: Colors.grey,
            foregroundColor: Colors.white,
          ),

          //delete option
          SlidableAction(
            onPressed: deletetapped,
            borderRadius: BorderRadius.circular(12),
            icon: Icons.delete,
            backgroundColor: Colors.black,
          )
        ]),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  //check box
                  Checkbox(
                      value: habitCompleted,
                      onChanged: onChanged,
                      activeColor: Colors.pink),

                  //habit name
                  Text(habitName, style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                ],
              ),

              Row(
                  children: const [
                    //arrow
                    Icon(Icons.keyboard_arrow_left_rounded, color: Colors.pink),

                    //swipe
                    Text("Swipe",style: TextStyle(color: Colors.black,fontSize: 20),)
                  ],
                ),
            ]
          ),
        ),
      ),
    );
  }
}
