import 'package:chat_app/constants.dart';

class ChatModel {
  final String cid;
  final List<String> members;
  final String recentMessage;
  final String recentMessageSender;
  final String recentMessageTime;

  ChatModel({
    required this.cid,
    required this.members,
    required this.recentMessage,
    required this.recentMessageSender,
    required this.recentMessageTime,
  });
 factory ChatModel.fromJson(jsonData) {
    return ChatModel(
      cid: jsonData[kCid],
      members: List<String>.from(jsonData[kMembers]),
      recentMessage: jsonData[kRecentMessage],
      recentMessageSender: jsonData[kRecentMessageSender],
      recentMessageTime: jsonData[kRecentMessageTime],
    );
  }
}
