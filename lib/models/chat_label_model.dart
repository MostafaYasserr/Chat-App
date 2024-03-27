import 'package:chat_app/constants.dart';

class ChatLabelModel {
  String? uid;
  String? userName;
  String? email;
  List<String>? userChats;

  ChatLabelModel({
    this.uid,
    this.userName,
    this.email,
    this.userChats,
  });

  factory ChatLabelModel.fromJson(jsonData) {
    return ChatLabelModel(
      uid: jsonData[kUid],
      userName: jsonData[kUserName],
      email: jsonData[kEmail],
      userChats: jsonData[kUserChats],
    );
  }

}