import 'package:flutter/material.dart';

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
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset("assets/top1.png", width: size.width),
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
}// TODO Implement this library.