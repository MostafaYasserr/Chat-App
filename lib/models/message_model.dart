import 'package:chat_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String message;
  final String sender;
  final String receiver;
  final Timestamp time;
  // final bool isRead;

  MessageModel({
    required this.message,
    required this.sender,
    required this.receiver,
    required this.time,
    // required this.isRead,
  });

  factory MessageModel.fromJson(jsonData) {
    return MessageModel(
      message: jsonData[kMessage],
      sender: jsonData[kSender],
      receiver: jsonData[kReceiver],
      time: jsonData[kTime],
      // isRead: jsonData['isRead'],
    );
  }
}