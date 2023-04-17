import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(8.4705, 76.9794);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
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
              trailing: Text('8:00 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Karamana',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('8:05 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Poojapura',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('8:07 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Pangode',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('8:10 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Vettamukku',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('8:13 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('PTP Nagar',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('8:18 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Arapura',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('8:20 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Saraswathy Vidyalaya',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('8:23 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Vatiyoorkavu',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('8:28 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Manjadimukku',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('8:30 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Thozhuvancode',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('8:33 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Kanjirampara',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('8:38 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Maruthankuzhy',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('8:43 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Sasthamangalam',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('8:45 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Pipinmoodu',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('8:48 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Oolampara',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('8:53 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Peroorkada',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('8:58 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Ambalamukku',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('9:03 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Muttada',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('9:05 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Paruthippara',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('9:07 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Kesavadasapuram',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('9:09 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('Pattom',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('9:11 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('PMG',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('9:13 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text('College',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
              trailing: Text('9:20 ',
                  style: TextStyle(fontSize: 17, fontFamily: 'Rubik')),
            ),
          ],
        ),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 15,
        ),
        markers: _createMarker(),
      ),
    );
  }
}
