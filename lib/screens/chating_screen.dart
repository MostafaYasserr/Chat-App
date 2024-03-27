import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../components/chat_bubble.dart';
import '../components/message_box.dart';
import '../constants.dart';

class ChatingScreen extends StatelessWidget {
  ChatingScreen({super.key,});

  static const String id = 'ChatingScreen';

  final dbMessages = FirebaseFirestore.instance.collection(kMessagesCollections);
  final textEditingController = TextEditingController();
  final scrollController = ScrollController();
  final Stream<QuerySnapshot> stream = FirebaseFirestore.instance
      .collection(kMessagesCollections)
      .orderBy(
        kTime,
        descending: true,
      )
      .snapshots();

  @override
  Widget build(BuildContext context) {

    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    final String senderEmail =arg['senderEmail'];
    final String receiverEmail = arg['receiverEmail'];




    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MessageModel> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(MessageModel.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            backgroundColor: kPrimaryColor,
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              automaticallyImplyLeading: false,
              title: const Text(
                'Chat App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: 'pacifico',
                ),
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: scrollController,
                    itemBuilder: (context, index) {
                      if (messagesList[index].sender == senderEmail && messagesList[index].receiver == receiverEmail || messagesList[index].sender == receiverEmail && messagesList[index].receiver == senderEmail) {
                        if (messagesList[index].sender == senderEmail) {
                          return SenderChatBubble(
                            message: messagesList[index],
                          );
                        }else{
                          return ReceiverChatBubble(
                            message: messagesList[index],
                          );
                        }
                      }
                    },
                    itemCount: messagesList.length,
                  ),
                ),
                MessageBox(
                  controller: textEditingController,
                  onSubmitted: (String value) {
                    if (value.isNotEmpty) {
                      dbMessages.add({
                        kMessage: value,
                        kTime: DateTime.now(),
                        kSender: senderEmail,
                        kReceiver: receiverEmail ,
                      });
                      scrollController.animateTo(
                        scrollController.position.minScrollExtent,
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.easeOut,
                      );
                      textEditingController.clear();
                    }
                  },
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        return const Text('Loading');
      },
    );
  }
}
