import 'package:flutter/material.dart';
import 'package:safebus/bus.dart';
import 'package:safebus/location.dart';
import 'package:safebus/report.dart';
import 'package:safebus/stream.dart';
import 'package:safebus/writenotice.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
        backgroundColor: Color.fromARGB(255, 117, 154, 255),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WriteNotice()),
          );
        },
        backgroundColor: Color.fromARGB(255, 117, 154, 255),
        child: const Icon(Icons.message, size: 30),
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
                MaterialPageRoute(
                    builder: (context) => const StreamPage(
                          user: '_auth.currentUser?.email',
                          isHost: false,
                        )),
              );
            },
            icon: Icon(Icons.videocam),
            label: Text(
              'View Streaming',
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
                MaterialPageRoute(builder: (context) => BusPage()),
              );
            },
            icon: Icon(Icons.edit_note_outlined),
            label: Text(
              'Bus Report        ',
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
                MaterialPageRoute(builder: (context) => const ReportPage()),
              );
            },
            icon: Icon(Icons.manage_accounts),
            label: Text(
              'Driver Report     ',
              style: TextStyle(fontSize: 18),
            ),
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 116, 154, 255),
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 60),
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
}
