import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
    required this.alignment,
    required this.color,
    required this.borderRadius,

  });

  final MessageModel message;
  final Alignment alignment;
  final Color color ;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        padding: const EdgeInsets.only(
          left: 15,
          right: 20,
          top: 15,
          bottom: 15,
        ),
        margin: const EdgeInsets.all(10),
        decoration:  BoxDecoration(
          color: color,
          borderRadius: borderRadius,
        ),
        child: Text(
          message.message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontFamily: 'pacifico',
          ),
        ),
      ),
    );
  }
}

class SenderChatBubble extends StatelessWidget {
  const SenderChatBubble({super.key, required this.message});

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return ChatBubble(message: message, alignment: Alignment.centerLeft, color: kSecondaryColor, borderRadius: const BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30),bottomRight: Radius.circular(30),),);
  }
}

class ReceiverChatBubble extends StatelessWidget {
  const ReceiverChatBubble({super.key, required this.message});

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return ChatBubble(message: message, alignment: Alignment.centerRight, color: kThirdColor,borderRadius: const BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30),bottomLeft: Radius.circular(30),),);
  }
}

