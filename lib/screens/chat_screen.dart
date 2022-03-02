import 'dart:convert';

import 'package:flash_chat_flutter/screens/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? email;
  Map<String, dynamic>? data;
  String? messageText;
  @override
  void initState() {
    super.initState();
    email = _auth.currentUser?.email;
    print(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: [
          IconButton(
            onPressed: () async {
              await _auth.signOut();
              Navigator.popAndPushNamed(context, WelcomeScreen.id);
            },
            icon: const Icon(Icons.close),
          ),
        ],
        title: const Text(' ⚡️ Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('messages').snapshots(),
              builder: (context, snapshot) {
                List<Text> messageWidgets = [];
                if (snapshot.hasError) {
                  print('Something went wrong');
                  const snackBar = SnackBar(
                    content: Text('Something went wrong, Refresh!'),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.redAccent,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  print('loading');
                  const snackBar = SnackBar(
                    content: Text('Contents are loading....!'),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.blueAccent,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                  );
                }

                final messages = snapshot.data?.docs;
                for (var message in messages!) {
                  Map<String, dynamic> document =
                      message.data() as Map<String, dynamic>;
                  final messageText = document['text'];
                  final messageSender = document['sender'];
                  final messageWidget =
                      Text('$messageText from $messageSender');
                  messageWidgets.add(messageWidget);
                }

                return Column(
                  children: messageWidgets,
                );
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _firestore
                          .collection('messages')
                          .add({'text': messageText, 'sender': email})
                          .then((value) => print('Data added'))
                          .catchError((error) => print(error));
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
