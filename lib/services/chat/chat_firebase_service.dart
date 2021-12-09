import 'dart:async';
import 'package:chat/models/chat_user.dart';
import 'package:chat/models/chat_message.dart';
import 'package:chat/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatFirebaseService implements ChatService {
  @override
  Stream<List<ChatMessage>> messagesStream() {
    final store = FirebaseFirestore.instance;
    final snapshots = store
        .collection('chat')
        .withConverter(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        )
        .snapshots();

    return snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }

  @override
  Future<ChatMessage?> save(String text, ChatUser user) async {
    final store = FirebaseFirestore.instance;

    final id = '';
    final createdAt = DateTime.now();
    final userId = user.id;
    final userName = user.name;
    final userImageURL = user.imageURL;

    final msg = ChatMessage(
      id,
      text,
      createdAt,
      userId,
      userName,
      userImageURL,
    );

    final docRef = await store
        .collection('chat')
        .withConverter(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        )
        .add(msg);

    final doc = await docRef.get();

    return doc.data()!;
  }

  ChatMessage _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    final id = doc.id;
    final text = doc['text'];
    final createdAt = DateTime.parse(doc['createdAt']);
    final userId = doc['userId'];
    final userName = doc['userName'];
    final userImageURL = doc['userImageURL'];

    return ChatMessage(
      id,
      text,
      createdAt,
      userId,
      userName,
      userImageURL,
    );
  }

  Map<String, dynamic> _toFirestore(
    ChatMessage msg,
    SetOptions? options,
  ) {
    return {
      'text': msg.text,
      'createdAt': msg.createdAt.toIso8601String(),
      'userId': msg.id,
      'userName': msg.userName,
      'userImageURL': msg.userImageURL,
    };
  }
}
