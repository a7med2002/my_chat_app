import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final String text;
  final String sender;
  const MessageWidget({super.key, required this.text, required this.sender});

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: _auth.currentUser!.email == sender
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 0, top: 12, left: 12, right: 12),
          child: Text(
            sender,
            style: TextStyle(
              color: _auth.currentUser!.email == sender
                  ? Colors.greenAccent
                  : Colors.lightBlueAccent,
              fontSize: 12,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 12, top: 12, left: 12, right: 12),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.only(
              topLeft: _auth.currentUser!.email == sender
                  ? Radius.circular(16)
                  : Radius.circular(0),
              topRight: _auth.currentUser!.email == sender
                  ? Radius.circular(0)
                  : Radius.circular(16),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            border: Border.all(
              color: _auth.currentUser!.email == sender
                  ? Colors.greenAccent
                  : Colors.lightBlueAccent,
            ),
          ),
          child: Text(text, style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }
}
