import 'package:flutter/material.dart';

import '../screens/chating_screen.dart';
class ChatLabel extends StatelessWidget {
  const ChatLabel({
    super.key,
    required this.senderEmail,
    required this.receiverName,
    required this.receiverEmail,
    // required this.lastMessage,
    // required this.lastMessageTime,
  });
  final String senderEmail;
  final String receiverName ;
  final String receiverEmail ;
  // final String lastMessage ;
  // final String lastMessageTime ;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 20.0,),
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            const CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhPQvjluL29Y2c7GasJOZRWKIk3pFSC1h1uQ&usqp=CAU',
              ),
            ),
            CircleAvatar(
              radius: 11.0,
              backgroundColor: Colors.white.withOpacity(0.8),
            ),
            const CircleAvatar(
              radius: 10.0,
              backgroundColor: Colors.green,
            ),
          ],
        ),
        const SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, ChatingScreen.id,arguments: {'senderEmail':senderEmail , 'receiverEmail':receiverEmail});
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 SizedBox(
                  width: 215.0,
                  child: Text(
                    receiverName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                     const SizedBox(
                      width: 100.0,
                      child: Expanded(
                        child: Text(
                          'lastMessage',
                          // lastMessage,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:10.0),
                      child: Container(
                        width: 5.0,
                        height: 5.0,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape:BoxShape.circle,
                        ),
                      ),
                    ),
                     Text("lastMessageTime"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}