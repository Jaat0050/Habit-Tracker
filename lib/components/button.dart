import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  final Function()? onPressed;

  const MyButton({
    super.key,
    required this.onPressed,
    });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(

      onPressed: onPressed,

      child: const Icon(Icons.add),
    );
  }
}