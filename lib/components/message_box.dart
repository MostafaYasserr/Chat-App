import 'package:flutter/material.dart';
import '../constants.dart';

class MessageBox extends StatelessWidget {
   MessageBox({
    super.key,
    required this.onSubmitted,
    required this.controller
  });
  final Function(String) onSubmitted;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: controller,
            onSubmitted: onSubmitted,
            decoration: InputDecoration(
              hintText: 'Type a message...',
              hintStyle: const TextStyle(
                color: Colors.grey,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(style: BorderStyle.none),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(style: BorderStyle.none),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              fillColor: Colors.white,
              filled: true,
            ),
          ),
        ),
      ),
      CircleAvatar(
        radius: 25,
        backgroundColor: Colors.white,
        child: IconButton(
          onPressed: () {
            onSubmitted(controller.text);
            controller.clear();
          },
          icon: const Icon(
            Icons.send,
            color: kSecondaryColor,
          ),
        ),
      ),
    ]);
  }
}
