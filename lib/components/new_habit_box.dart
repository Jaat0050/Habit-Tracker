import 'package:flutter/material.dart';

class NewHabitbox extends StatelessWidget {

  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final VoidCallback onSaved;
  final VoidCallback onCancel;
  final String hintText;

  const NewHabitbox({
    super.key,
    required this.controller,
    required this.onSaved,
    required this.onCancel,
    required this.hintText,
    });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(),
          iconColor: Colors.pink,
        ),
        
      ),
      actions: [

        //button for save
        MaterialButton(onPressed: onSaved,color: Colors.pink,
        child: const Text("SAVE",style: TextStyle(fontSize: 20,color: Colors.white),),
        ),

        //button for cancel
        MaterialButton(onPressed: onCancel,
        color: Colors.pink,
        child: const Text("CANCEL",style: TextStyle(fontSize: 20,color: Colors.white),),
        
        )
      ],
    );
  }
}