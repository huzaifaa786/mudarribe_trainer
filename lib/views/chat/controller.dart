import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mudarribe_trainer/models/models.dart';
import 'package:mudarribe_trainer/views/chat/constants.dart';

class ChatProvider {
  UploadTask uploadFile(File image, String fileName) {
    Reference reference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = reference.putFile(image);
    return uploadTask;
  }

  UploadTask uploadPdf(File pdfFile, String fileName) {
    Reference reference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = reference.putFile(pdfFile);
    return uploadTask;
  }

  UploadTask uploadVideo(File videoFile, String fileName) {
    Reference reference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = reference.putFile(videoFile);
    return uploadTask;
  }

  Future<void> updateDataFirestore(String collectionPath, String docPath,
      Map<String, dynamic> dataNeedUpdate) {
    return FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(docPath)
        .update(dataNeedUpdate);
  }

  Stream<QuerySnapshot> getChatStream(String groupChatId, int limit) {
    return FirebaseFirestore.instance
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(groupChatId)
        .collection(groupChatId)
        .orderBy(FirestoreConstants.timestamp, descending: true)
        .limit(limit)
        .snapshots();
  }

  void sendMessage(String content, int type, String groupChatId,
      String currentUserId, String peerId) async {
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    await FirebaseFirestore.instance
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(groupChatId)
        .set({
      'userId': peerId,
      'trainerId': currentUserId,
      'timestamp': timestamp,
      'userSeen': false,
      'trainerSeen': true,
    });
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(groupChatId)
        .collection(groupChatId)
        .doc(timestamp);

    MessageChat messageChat = MessageChat(
      idFrom: currentUserId,
      idTo: peerId,
      timestamp: timestamp,
      content: content,
      type: type,
      seen: false
    );

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(
        documentReference,
        messageChat.toJson(),
      );
    });
  }
}

class TypeMessage {
  static const text = 0;
  static const image = 1;
  static const document = 2;
  static const myplan = 3;
  static const rating = 4;
  static const video = 5;
}
