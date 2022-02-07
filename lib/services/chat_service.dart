

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_bar_gym/models/chat_model.dart';

class ChatService {
  late CollectionReference chatsRef;

  ChatService(String collectionPath) {
    chatsRef = FirebaseFirestore.instance.collection(collectionPath);
  }

  Future<void> sendMessage(Chat chat) async {
    await chatsRef.add(chat);
  }

  Stream<QuerySnapshot> getChatStream(String timestamp) {
    return chatsRef.snapshots();
  }

}