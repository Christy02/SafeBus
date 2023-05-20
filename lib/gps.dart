import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:app_settings/app_settings.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GPSPage extends StatelessWidget {
  const GPSPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: Scaffold(body: FireMap()));
  }
}

class FireMap extends StatefulWidget {
  const FireMap({Key? key}) : super(key: key);
  @override
  State<FireMap> createState() => _FireMapState();
}

class _FireMapState extends State<FireMap> {
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;

  @override
  Widget build(BuildContext context) {
    location.enableBackgroundMode(enable: true);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Driver GPS"),
          backgroundColor: Color.fromARGB(255, 117, 154, 255),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(children: [
            const SizedBox(height: 200),
            ElevatedButton(
                onPressed: () async {
                  _locationPermission();
                  bool ison = await location.serviceEnabled();
                  if (!ison) {
                    //if device is off
                    bool isturnedon = await location.requestService();
                    if (isturnedon) {
                      print("GPS device is turned ON");
                      Fluttertoast.showToast(msg: "Location turned ON");
                    } else {
                      print("GPS device is still OFF");
                    }
                  } else {
                    Fluttertoast.showToast(msg: "Location already ON");
                  }
                },
                style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 117, 154, 255),
                    padding:
                        EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
                child: Text("Turn On GPS", style: TextStyle(fontSize: 17))),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: () async {
                  bool isturnedon = await location.serviceEnabled();
                  if (isturnedon) {
                    Fluttertoast.showToast(msg: "Share location enabled");
                    _listenLocation();
                  } else {
                    Fluttertoast.showToast(
                        msg: "Turn On Location",
                        backgroundColor: Color.fromARGB(255, 255, 88, 88));
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 117, 154, 255),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text("Share Location",
                    style: TextStyle(fontSize: 17))),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: () async {
                  AppSettings.openLocationSettings();
                  _stopListening();
                },
                style: ElevatedButton.styleFrom(
                    primary: Color(0xFFFF4D4D),
                    padding:
                        EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
                child: Text("Turn Off GPS", style: TextStyle(fontSize: 17)))
          ]),
        ));
  }

  _locationPermission() async {
    loc.PermissionStatus _permissionGranted;

    _permissionGranted = (await location.hasPermission());
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }
  }

  //Cloud Firestore
  Future<void> _listenLocation() async {
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      print(onError);
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((loc.LocationData currentlocation) async {
      await FirebaseFirestore.instance
          .collection('current_loc')
          .doc('bus')
          .set({
        'latitude': currentlocation.latitude,
        'longitude': currentlocation.longitude,
        'speed': FieldValue.arrayUnion([currentlocation.speed]),
        'time': FieldValue.serverTimestamp()
      }, SetOptions(merge: true));
    });
  }

  _stopListening() {
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
  }
}
