import 'package:flutter/material.dart';
import 'login.dart';
import 'notice.dart';

class DriverPage extends StatefulWidget {
  const DriverPage({Key? key}) : super(key: key);

  @override
  State<DriverPage> createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> {
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
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              icon: const Icon(
                Icons.directions_bus_filled_sharp,
                size: 30,
              ))
        ],
      ),
      body: Column(
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
                      Route route =
                          MaterialPageRoute(builder: (context) => NoticePage());
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
                      Route route =
                          MaterialPageRoute(builder: (context) => NoticePage());
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
            height: 50,
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
                      horizontal: 130,
                    )),
                onPressed: () {
                  Route route =
                      MaterialPageRoute(builder: (context) => NoticePage());
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
          ),
          const SizedBox(
            height: 50,
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
                  Route route =
                      MaterialPageRoute(builder: (context) => NoticePage());
                  Navigator.push(context, route);
                },
                child: const Text(
                  'Mark Attendence',
                  style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                    color: Color.fromARGB(255, 117, 154, 255),
                  ),
                )),
          ),
          SizedBox(
            height: 91,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset("assets/bottom2.png", width: size.width),
          ),
        ],
      ),
    );
  }
}
