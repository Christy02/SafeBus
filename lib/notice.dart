import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class NoticePage extends StatefulWidget {
  const NoticePage({Key? key}) : super(key: key);

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  Widget _buildMessage(QuerySnapshot<Object?>? snapshot) {
    return ListView.builder(
        itemCount: snapshot?.docs.length,
        itemBuilder: (context, index) {
          final doc = snapshot?.docs[index];
          DateTime date = doc!["timestamp"].toDate();
          final DateFormat formatter = DateFormat("\nyyyy-MM-dd     HH:mm");
          final String formatted = formatter.format(date);
          return Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: ListTile(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25))),
                title: Text(doc["message"]),
                subtitle: Text(formatted),
                tileColor: Color(0xFFE8E8EE),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
              ));
        });
  }

  Widget buildListMessage() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('notice')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(255, 117, 154, 255))));
          }
          return Expanded(child: _buildMessage(snapshot.data));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notice'),
        backgroundColor: Color.fromARGB(255, 117, 154, 255),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              //const SizedBox(height: 20),
              buildListMessage(),
              //buildInput(),
            ],
          ),
        ],
      ),
    );
  }
}
