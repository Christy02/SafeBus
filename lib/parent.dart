import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:safebus/chat.dart';
import 'package:safebus/location.dart';
import 'package:safebus/notice.dart';
import 'package:safebus/stream.dart';

class ParentPage extends StatefulWidget {
  const ParentPage({Key? key}) : super(key: key);

  @override
  State<ParentPage> createState() => _ParentPageState();
}

class _ParentPageState extends State<ParentPage> {
  String? _deviceToken;
  String? _userId;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    // Obtain the user's device token and save it to Firestore
    _saveDeviceTokenToFirestore();
  }

  void _saveDeviceTokenToFirestore() async {
    // Obtain the current user's UID
    final currentUser = FirebaseAuth.instance.currentUser;
    final String? uid = currentUser!.email;
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission();

    // Obtain the user's device token
    String? token = await FirebaseMessaging.instance.getToken();

    // Save the device token to Firestore under the current user's document

    setState(() {
      _deviceToken = token;
      _userId = uid;
    });
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'deviceToken': token});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Parent'),
        backgroundColor: Color.fromARGB(255, 117, 154, 255),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final currentUser = FirebaseAuth.instance.currentUser;
          final String uid = currentUser!.email as String;
          String name = uid.split('@')[0];
          Route route = MaterialPageRoute(
              builder: (context) => StreamPage(
                    user: name,
                    isHost: false,
                  ));
          Navigator.push(context, route);
        },
        child: const Icon(Icons.videocam, size: 30),
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
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatScreen()),
              );
            },
            icon: Icon(Icons.people),
            label: Text(
              'Chat',
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