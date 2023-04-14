import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _textController = TextEditingController();
  late String _currentTime;

  @override
  void initState() {
    super.initState();
    _getCurrentTime();
  }

  void _getCurrentTime() {
    final now = DateTime.now();
    final time = TimeOfDay.fromDateTime(now);
    setState(() {
      _currentTime = '${time.hour}:${time.minute}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Chat'),
        backgroundColor: Color.fromARGB(255, 116, 154, 255),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await _auth.signOut();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('chats')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  reverse: true,
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot document =
                        snapshot.data?.docs[index] as DocumentSnapshot<Object?>;
                    return _buildMessage(document['message'],
                        document['user'] == _auth.currentUser?.email);
                  },
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                SizedBox(width: 5.0),
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async {
                    String message = _textController.text.trim();
                    _textController.clear();
                    if (message.isNotEmpty) {
                      await _firestore.collection('chats').add({
                        'user': _auth.currentUser?.email,
                        'message': message,
                        'timestamp': FieldValue.serverTimestamp(),
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(String message, bool isMe) {
    final radius = Radius.circular(20.0);
    final borderRadius = BorderRadius.only(
      topLeft: radius,
      topRight: radius,
      bottomLeft: isMe ? radius : Radius.zero,
      bottomRight: isMe ? Radius.zero : radius,
    );
    final alignment = isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final textStyle = TextStyle(color: Colors.white);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Column(
        crossAxisAlignment: alignment,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: isMe
                  ? Theme.of(context).accentColor
                  : Color.fromARGB(255, 127, 124, 124),
              borderRadius: borderRadius,
            ),
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: Text(
              message,
              style: textStyle,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            '$_currentTime',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
