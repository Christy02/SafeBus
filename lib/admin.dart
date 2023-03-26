import 'package:flutter/material.dart';
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
    );
  }
}
