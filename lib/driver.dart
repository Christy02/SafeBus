import 'package:flutter/material.dart';

import 'login.dart';

class DriverPage extends StatefulWidget {
  const DriverPage({Key? key}) : super(key: key);

  @override
  State<DriverPage> createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver'),
        backgroundColor: Color.fromARGB(255, 117, 154, 255),
        actions: <Widget>[
          IconButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              icon: const Icon(
                Icons.directions_bus_filled_sharp,
                size: 30,
              ))
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 100,
            left: 20,
            right: 20,
          ),
          child: Row(
            children: <Widget>[
              RaisedButton(
                  padding: EdgeInsets.all(50),
                  onPressed: () {
                    Route route =
                        MaterialPageRoute(builder: (context) => LoginPage());
                    Navigator.push(context, route);
                  },
                  child: const Text('Notices')),
              const SizedBox(
                width: 20,
              ),
              RaisedButton(
                  padding: EdgeInsets.all(50),
                  onPressed: () {
                    Route route =
                        MaterialPageRoute(builder: (context) => LoginPage());
                    Navigator.push(context, route);
                  },
                  child: const Text('  Chat   ')),
            ],
          ),
        ),
      ),
    );
  }
}
