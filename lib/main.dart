import 'package:flutter/material.dart';
import 'package:habit_tracker/pages/welcome_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async  {

  //initialise hive
  await Hive.initFlutter();

  //open a box or name the hive box
  await Hive.openBox("Habit_Database");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WelcomePage(),
      theme: ThemeData(primarySwatch: Colors.pink),
    );
  }
}
