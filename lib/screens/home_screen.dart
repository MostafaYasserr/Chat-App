import 'package:chat_app/models/chat_label_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/chat_label.dart';
import '../constants.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  static const String id = 'HomeScreen';

  final Stream<QuerySnapshot> stream =
      FirebaseFirestore.instance.collection(kUsersCollections).snapshots();

  @override
  Widget build(BuildContext context) {
    var senderEmailAddress =
        ModalRoute.of(context)!.settings.arguments.toString();
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ChatLabelModel> chatLabelList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            chatLabelList.add(ChatLabelModel.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text(
                'Chat App',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 25,
                  fontFamily: 'pacifico',
                ),
              ),
              centerTitle: true,
            ),
            body: ListView.builder(
              itemCount: chatLabelList.length,
              itemBuilder: (context, index) {
                return ChatLabel(
                  senderEmail: senderEmailAddress,
                  receiverName: chatLabelList[index].userName!,
                  receiverEmail: chatLabelList[index].email!,
                  // lastMessage: lastMessage,
                  // lastMessageTime: lastMessageTime
                );
              },
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
