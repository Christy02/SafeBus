import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AttendancePage extends StatefulWidget {
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  List<String> _studentIds = [
    'student1',
    'student2',
    'student3'
  ]; // Replace with your own student IDs
  Map<String, bool> _attendanceMap = {};

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    // Initialize the attendance map with all students marked absent
    for (String studentId in _studentIds) {
      _attendanceMap[studentId] = false;
    }
    // Configure the notification plugin
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void _markAttendance() async {
    // Save attendance data to Firebase Firestore
    for (String studentId in _studentIds) {
      bool isPresent = _attendanceMap[studentId]!;
      FirebaseFirestore.instance
          .collection('attendance')
          .doc(studentId)
          .set({'isPresent': isPresent});
    }

    // Send push notification to teacher
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channel_id', 'channel_name', 'channel_description',
        importance: Importance.max, priority: Priority.high, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(0, 'Attendance marked!',
        'Student entered the bus', platformChannelSpecifics,
        payload: 'attendance');

    // Show success dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Attendance Marked'),
          content: Text('Student entered the bus'),
          actions: [
            FlatButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Page'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _studentIds.length,
              itemBuilder: (BuildContext context, int index) {
                String studentId = _studentIds[index];
                bool isPresent = _attendanceMap[studentId]!;
                return ListTile(
                  title: Text(studentId),
                  trailing: Checkbox(
                    value: isPresent,
                    onChanged: (value) {
                      setState(() {
                        _attendanceMap[studentId] = value!;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          RaisedButton(
            child: Text(
              'Mark Attendance',
              style: TextStyle(fontSize: 20),
            ),
            onPressed: _markAttendance,
          ),
        ],
      ),
    );
  }
}
