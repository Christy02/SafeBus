import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safebus/bus.dart';
import 'package:safebus/chat.dart';
import 'package:safebus/gps.dart';
import 'package:safebus/stream.dart';

import 'attendance.dart';
import 'notice.dart';
import 'package:http/http.dart' as http;

class DriverPage extends StatefulWidget {
  const DriverPage({Key? key}) : super(key: key);

  @override
  State<DriverPage> createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> {
  sendNotification(String title, String token) async {
    final data = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': '1',
      'status': 'done',
      'message': title,
    };

    try {
      http.Response response =
          await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
              headers: <String, String>{
                'Content-Type': 'application/json',
                'Authorization':
                    'key=AAAAhkfrH3g:APA91bF5Q4L0Ixha0d_6gpPclFAsFByNqHVrsVFd_vIKrHjmqXG1oMZIA_74t-ElAvn5c0LQw8XxBsbRGnz3BrZboymDCv94qBwBV-GGjzb-q4BqcSbpmEUK00Rsw4DwXy8ojEZgoZmm'
              },
              body: jsonEncode(<String, dynamic>{
                'notification': <String, dynamic>{
                  'title': title,
                  'body': 'Emergency Situation Alert'
                },
                'priority': 'high',
                'data': data,
                'to': '$token'
              }));

      if (response.statusCode == 200) {
        print("Yeh notificatin is sended");
      } else {
        print("Error");
      }
    } catch (e) {}
  }

  int _tapCount = 0;
  void _handleTap() {
    setState(() {
      _tapCount++;
      if (_tapCount > 2) {
        print('Sending alert');
        Fluttertoast.showToast(
            msg: 'Sending alert', backgroundColor: Colors.red);
        sendNotification('ALERT!!!',
            'ffqhfLsZRm-RszIyJI3QBY:APA91bFDtPaYGfiiNUlYDnPLMZLYV5Xn6MZONqVTE60-NSjdpFb9WdPAbrWHj2PQdaie2ibrjl281GBpoZnronGzFJt7PmvoQyrpF4iCFjZMlimb3i8ekk-65YzZfH4PwQgBX4rr9PYI');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Driver'),
          backgroundColor: Color.fromARGB(255, 117, 154, 255),
          actions: <Widget>[
            IconButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GPSPage()),
                  );
                },
                icon: const Icon(
                  Icons.add_location_alt_sharp,
                  size: 30,
                )),
            IconButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BusPage()),
                  );
                },
                icon: const Icon(
                  Icons.directions_bus_filled_sharp,
                  size: 30,
                ))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _handleTap,
          backgroundColor:
              _tapCount > 2 ? Color.fromARGB(255, 221, 10, 10) : Colors.green,
          child: const Icon(Icons.bus_alert_rounded, size: 30),
        ),
        body: Stack(children: <Widget>[
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset("assets/bottom2.png", width: size.width),
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 100,
                  left: 25,
                  right: 25,
                ),
                child: Row(
                  children: <Widget>[
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white70,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 50,
                              horizontal: 40,
                            )),
                        onPressed: () {
                          Route route = MaterialPageRoute(
                              builder: (context) => NoticePage());
                          Navigator.push(context, route);
                        },
                        child: const Text(
                          'Notices',
                          style: TextStyle(
                            letterSpacing: 1.5,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                            color: Color.fromARGB(255, 117, 154, 255),
                          ),
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white70,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 50,
                              horizontal: 50,
                            )),
                        onPressed: () {
                          Route route = MaterialPageRoute(
                              builder: (context) => ChatScreen());
                          Navigator.push(context, route);
                        },
                        child: const Text(
                          'Chat',
                          style: TextStyle(
                            letterSpacing: 1.5,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                            color: Color.fromARGB(255, 117, 154, 255),
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 25,
                  right: 25,
                ),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white70,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 30,
                          horizontal: 75,
                        )),
                    onPressed: () {
                      Route route = MaterialPageRoute(
                          builder: (context) => AttendancePage());
                      Navigator.push(context, route);
                    },
                    child: const Text(
                      'Mark Attendance',
                      style: TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                        color: Color.fromARGB(255, 117, 154, 255),
                      ),
                    )),
              ),
              const SizedBox(
                height: 70,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 25,
                  right: 25,
                ),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white70,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 30,
                          horizontal: 75,
                        )),
                    onPressed: () {
                      Route route = MaterialPageRoute(
                          builder: (context) => StreamPage(
                                user: 'Conductor',
                                isHost: true,
                              ));
                      Navigator.push(context, route);
                    },
                    child: const Text(
                      'Live-streaming',
                      style: TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                        color: Color.fromARGB(255, 117, 154, 255),
                      ),
                    )),
              ),
            ],
          ),
        ]));
  }
}
