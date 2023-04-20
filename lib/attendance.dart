import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class AttendancePage extends StatefulWidget {
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  List<String> userIds = [];

  @override
  void initState() {
    super.initState();
  }

  sendNotification(String title, String token) async {
    final data = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': '1',
      'status': 'done',
      'message': 'Student attendance status marked',
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
                  'body': "Your ward's attendance status marked"
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
        backgroundColor: Color.fromARGB(255, 117, 154, 255),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          final users = snapshot.data!.docs;
          userIds = users.map((doc) => doc.id).toList();

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              bool isChecked = user['attendance'] ?? false;

              return ListTile(
                title: Text(user.id),
                trailing: Checkbox(
                  value:
                      isChecked, // You can set the initial value of the checkbox here
                  onChanged: (bool? value) async {
                    final emailId = user.id;

                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(emailId)
                        .update({'attendance': value});
                    String deviceToken = user['deviceToken'];
                    print('Token: $deviceToken');
                    //Future deviceToken = getFieldInDocument(emailId);
                    setState(() {
                      isChecked =
                          value ?? false; // Handle checkbox changes here
                    });
                    if (deviceToken != null && value == true) {
                      sendNotification('Student entered', deviceToken);
                    } else if (deviceToken != null && value == false) {
                      sendNotification('Student exited', deviceToken);
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
