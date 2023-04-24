import 'package:flutter/material.dart';
import 'package:habit_tracker/pages/home_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            colorFilter: ColorFilter.mode(Color.fromARGB(255, 244, 143, 177), BlendMode.color),
            image: AssetImage("images/1.jpg"),
            fit: BoxFit.fill),
      ),
      // padding: const EdgeInsets.only(top: 640,left: 120,right: 120,bottom: 100),
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 100,)),
          const Center(
            child: Text(
              "HABIT TRACKER",
              style: TextStyle(
                color: Color.fromARGB(255, 240, 98, 146),
                fontWeight: FontWeight.bold,
                fontSize: 45,
                decoration: TextDecoration.none,
                fontStyle: FontStyle.italic
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 460),
            child: TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomePage()));
              },
              style: TextButton.styleFrom(
                  shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  side: const BorderSide(width: 2.0, color: Colors.pink)),
              child: const Text(
                "<Enter>",
                style: TextStyle(
                    color: Colors.pinkAccent,
                    backgroundColor: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
