import 'package:chat_app/widgets/message_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessagesStream extends StatefulWidget {
  const MessagesStream({super.key});

  @override
  State<MessagesStream> createState() => _MessagesStreamState();
}

class _MessagesStreamState extends State<MessagesStream> {
  final _db = FirebaseFirestore.instance;
  final String collectionName = "messages";
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _db
          .collection(collectionName)
          .orderBy("time", descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Text("no Data", style: TextStyle(color: Colors.grey)),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        final List<QueryDocumentSnapshot<Map<String, dynamic>>> messages =
            snapshot.data!.docs;
        _scrollToBottom();
        return Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return MessageWidget(
                text: messages[index].data()['text'],
                sender: messages[index].data()['sender'],
              );
            },
          ),
        );
      },
    );
  }
}
