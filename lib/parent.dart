import 'package:flutter/material.dart';
import 'package:safebus/location.dart';
import 'package:safebus/notice.dart';

class ParentPage extends StatefulWidget {
  const ParentPage({Key? key}) : super(key: key);

  @override
  State<ParentPage> createState() => _ParentPageState();
}

class _ParentPageState extends State<ParentPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Parent'),
        backgroundColor: Color.fromARGB(255, 117, 154, 255),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            width: 25,
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LocationPage()),
              );
            },
            icon: Icon(Icons.location_pin),
            label: Text(
              'View live-location',
              style: TextStyle(fontSize: 18),
            ),
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 116, 154, 255),
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 60),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NoticePage()),
              );
            },
            icon: Icon(Icons.message),
            label: Text(
              'Notice',
              style: TextStyle(fontSize: 18),
            ),
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 116, 154, 255),
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 100),
            ),
          ),
        ]
            .map((widget) => Padding(
                  padding: const EdgeInsets.only(
                    left: 35,
                    right: 35,
                    top: 50,
                  ),
                  child: widget,
                ))
            .toList(),
      ),
    );
  }
}// TODO Implement this library.