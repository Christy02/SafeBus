import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:safebus/components/background.dart';
import 'package:safebus/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  get margin => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: const Text(
                "SafeBus",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 117, 154, 255),
                    fontSize: 50),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 40),
              child: TextButton(
                style: TextButton.styleFrom(
                  minimumSize: const Size(300, 30),
                  backgroundColor: Color.fromARGB(255, 117, 154, 255),
                  primary: Colors.white,
                ),
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const Text(
                  'Parent',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 25),
              child: TextButton(
                style: TextButton.styleFrom(
                  minimumSize: const Size(300, 50),
                  backgroundColor: Color.fromARGB(255, 117, 154, 255),
                  primary: Colors.white,
                ),
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const Text(
                  'Driver',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 25),
              child: TextButton(
                style: TextButton.styleFrom(
                  minimumSize: const Size(300, 50),
                  backgroundColor: Color.fromARGB(255, 117, 154, 255),
                  primary: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const Text(
                  'Admin',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
