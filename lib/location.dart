import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class DirectionsService {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json';

  final String apiKey;

  DirectionsService({required this.apiKey});

  Future<int> getTravelTimeWithTrafficAndWaypoints(
      String origin, String destination, List<String> waypoints) async {
    // Validate each waypoint using the Geocoding API
    for (String waypoint in waypoints) {
      final url =
          'https://maps.googleapis.com/maps/api/geocode/json?address=$waypoint&key=$apiKey';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        throw Exception('Error geocoding waypoint $waypoint');
      }
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['status'] != 'OK') {
        throw Exception('Invalid waypoint address: $waypoint');
      }
    }

    final url =
        '$_baseUrl?units=imperial&origin=$origin&destination=$destination&key=$apiKey&waypoints=${waypoints.join('|')}&departure_time=now&traffic_model=best_guess';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (jsonResponse['status'] == 'OK') {
        final routes = jsonResponse['routes'] as List<dynamic>;
        final legs = routes[0]['legs'] as List<dynamic>;
        final waypointsLegs = legs.sublist(0, legs.length - 1);
        final totalDurationInSeconds = waypointsLegs.fold<int>(
            0,
            (prev, leg) =>
                prev +
                (leg['duration_in_traffic'] != null
                    ? leg['duration_in_traffic']['value'] as int
                    : leg['duration']['value'] as int));
        return totalDurationInSeconds;
      } else {
        final errorMessage = jsonResponse['error_message'];
        throw Exception('Error calculating ETA: $errorMessage');
      }
    } else {
      throw Exception('Error fetching directions');
    }
  }
}

class _LocationPageState extends State<LocationPage> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(8.4705, 76.9794);

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  Set<Marker> _createMarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId('myMarker'),
        position: LatLng(8.4705, 76.9794),
        infoWindow: InfoWindow(
          title: 'SCTCE',
          snippet: 'college',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ),
    ].toSet();
  }

  final directionsService =
      DirectionsService(apiKey: 'AIzaSyAQxdcZ2D1qtmlekqxBM-G5nBv1hxtB73k');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BusA'),
        backgroundColor: Color.fromARGB(255, 117, 154, 255),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/top2.png"),
                      scale: 100,
                      fit: BoxFit.cover)),
              child: Text('SCHEDULE',
                  style: TextStyle(
                      fontSize: 25, color: Color.fromARGB(255, 95, 138, 255))),
            ),
            ListTile(
              tileColor: Color.fromARGB(255, 117, 154, 255),
              textColor: Colors.white,
              title: Text('PLACE',
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Rubik')),
              trailing: Text('TIME',
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('College',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('7:45 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Karamana',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('7:50 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Poojapura',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('7:55 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Pangode',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('8:00 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Vettamukku',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('8:05 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('PTP Nagar',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('8:08 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Arapura',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('8:10 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Saraswathy Vidyalaya',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('8:15 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Vatiyoorkavu',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('8:18 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Manjadimukku',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('8:20 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Thozhuvancode',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('8:22 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Kanjirampara',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('8:25 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Maruthankuzhy',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('8:30 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Sasthamangalam',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('8:32 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Pipinmoodu',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('8:35 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Oolampara',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('8:40 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Peroorkada',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('8:43 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Ambalamukku',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('8:45 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Muttada',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('8:47 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Paruthippara',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('8:50 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Kesavadasapuram',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('8:55 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Ulloor',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('9:00 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Medical College',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('9:05 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Kumarapuram',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('9:07 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Kannamoola',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('9:10 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Pallimukku',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('9:13 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Pattoor',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('9:15 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Bakery Junction',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('9:18 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Thampanoor',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('9:20 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('College',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('9:25 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 100.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () async {
                  try {
                    final currentUser = FirebaseAuth.instance.currentUser;
                    final String? uid = currentUser!.email;
                    final DocumentSnapshot doc = await FirebaseFirestore
                        .instance
                        .collection('users')
                        .doc(uid)
                        .get();

                    final DocumentSnapshot doc2 = await FirebaseFirestore
                        .instance
                        .collection('current_loc')
                        .doc('v6DWAYpFW1SJhUPCK3Lk')
                        .get();

                    final String origin = doc2['last_stop'];
                    final String destination = doc['busStop'];
                    List<String> valuesBetween = [origin, destination];

                    print("Origin is $origin");
                    print("Destination is $destination");

                    // Get a reference to the document
                    DocumentReference docRef = FirebaseFirestore.instance
                        .collection('bus_schedule')
                        .doc('kYPgYcdkRLFfPRmw2Qci');
                    // Get the document data
                    DocumentSnapshot snapshot = await docRef.get();
                    List<dynamic> fieldOrder = snapshot.get('fieldOrder');
                    Map<String, dynamic> fields =
                        snapshot.data()! as Map<String, dynamic>;
                    List<String> sortedFields = fieldOrder
                        .map((field) => fields[field].toString())
                        .toList();
                    print('Schedule: $sortedFields');
                    int startIndex = sortedFields.indexOf(origin);
                    int endIndex = sortedFields.indexOf(destination);
                    if (startIndex != -1 && endIndex != -1) {
                      valuesBetween =
                          sortedFields.sublist(startIndex + 1, endIndex + 1);
                      print(
                          'Field values between origin and destination: $valuesBetween');
                    } else {
                      print('Origin and/or destination not found in fields.');
                    }

                    //LatLng originStr = LatLng(8.5186, 76.9875);
                    final travelTime = await directionsService
                        .getTravelTimeWithTrafficAndWaypoints(
                            origin, // origin
                            destination, // destination
                            valuesBetween);
                    print('Travel time: ${travelTime ~/ 60} minutes');
                    showReview(context, travelTime);
                  } catch (e) {
                    print("Error calculating ETA: $e");
                    throw Exception("Error calculating ETA: $e");
                  }
                },
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 117, 154, 255),
                    padding: EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    )),
                child: Text('Estimated Time of Arrival'),
              ),
            ],
          ),
        ),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 15,
        ),
        mapType: MapType.normal,
        markers: _createMarker(),
      ),
    );
  }
}

showReview(context, review) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
                height: 320.0,
                width: 200.0,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(height: 150.0),
                        Container(
                          height: 100.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              ),
                              color: Color.fromARGB(255, 117, 154, 255)),
                        ),
                        Positioned(
                            top: 50.0,
                            left: 94.0,
                            child: Container(
                              height: 90.0,
                              width: 90.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(45.0),
                                  border: Border.all(
                                      color: Colors.white,
                                      style: BorderStyle.solid,
                                      width: 2.0),
                                  image: DecorationImage(
                                      image: AssetImage('assets/main.png'),
                                      fit: BoxFit.contain)),
                            ))
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          '${review ~/ 60} minutes',
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    SizedBox(height: 15.0),
                    MaterialButton(
                      child: Center(
                        child: Text(
                          'OKAY',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 14.0,
                              color: Color.fromARGB(255, 117, 154, 255)),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      //color: Colors.white
                    )
                  ],
                )));
      });
}
