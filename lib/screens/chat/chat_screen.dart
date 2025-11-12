import 'package:chat_app/widgets/messages_stream.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static String id = "/chatScreen";
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  late User signedUser;
  final TextEditingController msgController = TextEditingController();
  final String collectionName = "messages";

  void getCred() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedUser = user;
        print(signedUser.email);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getCred();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Row(
          spacing: 12,
          children: [
            Image.asset("assets/images/chat.png", width: 32, height: 32),
            Text("Let's Chat", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
            icon: Icon(Icons.logout, color: Colors.red),
          ),
        ],
      ),
      body: Column(
        children: [
          // Spacer(),
          MessagesStream(),
          Divider(color: Colors.greenAccent, thickness: 2),
          TextField(
            controller: msgController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              enabledBorder: InputBorder.none,
              hintText: "Type your message here..",
              suffixIcon: IconButton(
                onPressed: () {
                  try {
                    _db.collection(collectionName).add({
                      "text": msgController.text,
                      "sender": signedUser.email,
                      "time" : FieldValue.serverTimestamp(),
                    });
                    msgController.clear();
                  } catch (e) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                },
                icon: Icon(Icons.send, color: Colors.lightBlueAccent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
