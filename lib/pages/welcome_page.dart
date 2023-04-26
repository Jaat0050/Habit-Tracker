import 'package:flutter/material.dart';

import 'home_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Color.fromARGB(255, 244, 143, 177), BlendMode.color),
            image: AssetImage("images/1.jpg"),
            fit: BoxFit.fill),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 80),
            child: Text(
              "HABIT TRACKER",
              style: TextStyle(
                  color: Color.fromARGB(255, 240, 98, 146),
                  fontWeight: FontWeight.bold,
                  fontSize: 45,
                  decoration: TextDecoration.none,
                  fontStyle: FontStyle.italic),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
              style: TextButton.styleFrom(
                shape: const BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                side: const BorderSide(width: 2.0, color: Colors.pink),
              ),
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
