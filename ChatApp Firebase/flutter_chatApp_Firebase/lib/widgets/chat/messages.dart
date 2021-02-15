import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './message_bubble.dart';

class Messages extends StatelessWidget {
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = chatSnapshot.data.documents;
        return ListView.builder(
          reverse: true,
          itemBuilder: (ctx, index) => MessageBubble(
            message: chatDocs[index]['text'],
            username: chatDocs[index]['username'],
            userImage: chatDocs[index]['userImage'],
            isMe: chatDocs[index]['userId'] == currentUser.uid,
            key: ValueKey(chatDocs[index].documentID),
          ),
          itemCount: chatDocs.length,
        );
      },
    );
  }
}
