import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WriteNotice extends StatefulWidget {
  const WriteNotice({Key? key}) : super(key: key);

  @override
  State<WriteNotice> createState() => _WriteNoticeState();
}

class _WriteNoticeState extends State<WriteNotice> {
  final msgController = TextEditingController();

  Widget _buildUserTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Message',
          style: TextStyle(
            color: Color.fromARGB(255, 88, 88, 88),
            fontFamily: 'OpenSans',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          height: 100.0,
          child: TextField(
            autofocus: true,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            controller: msgController,
            onSubmitted: (value) {
              msgController.text = value;
            },
            textInputAction: TextInputAction.newline,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromARGB(255, 117, 154, 255), width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromARGB(255, 88, 88, 88), width: 1.0),
              ),
              contentPadding: EdgeInsets.only(top: 5.0, bottom: 5),
              prefixIcon: Icon(
                Icons.notifications_none,
                color: Color.fromARGB(255, 117, 154, 255),
              ),
              hintText: 'Enter notice',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSendBtn() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 25.0),
        //width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            print("Notice sent");
            sendMsg(msgController.text.trim(),
                DateTime.now().millisecondsSinceEpoch);
            msgController.clear();
          },
          style: ElevatedButton.styleFrom(
              primary: const Color.fromARGB(255, 117, 154, 255),
              padding: const EdgeInsets.only(
                  top: 15, bottom: 15, left: 50, right: 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              )),
          child: const Text(
            'Send',
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ));
  }

  void sendMsg(String msg, int tstamp) async {
    await FirebaseFirestore.instance
        .collection('notice')
        .doc('$tstamp')
        .set({'timestamp': FieldValue.serverTimestamp(), 'message': msg});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Notice"),
          backgroundColor: const Color.fromARGB(255, 117, 154, 255),
        ),
        body: Container(
            padding: new EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                const SizedBox(height: 100.0),
                _buildUserTF(),
                _buildSendBtn(),
              ],
            )));
  }
}
