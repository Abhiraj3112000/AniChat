import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                // _auth.signOut();
                // Navigator.pop(context);
                getMessages();
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const MessagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[...reaction_tray],
              ),
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        setState(() {
                          message = value;
                        });
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextController.clear();
                      fireStore
                          .collection('messages')
                          .doc(
                              "${DateTime.now().millisecondsSinceEpoch}${auth.currentUser!.uid}")
                          .set({
                        'sender': loggedInUser.email,
                        'text': message,
                      });
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReactionButton extends StatelessWidget {
  final String reaction;
  final String text;

  ReactionButton({
    Key? key,
    required this.reaction,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        fireStore
            .collection('messages')
            .doc(
                "${DateTime.now().millisecondsSinceEpoch}${auth.currentUser!.uid}")
            .set({
          'sender': loggedInUser.email,
          'text': text,
        });

        // print("EMOJI");
      },
      child: Text(
        reaction,
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  const MessagesStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: fireStore.collection('messages').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          final messages = snapshot.data!.docs.reversed;

          List<MessageBubble> messageWidgets = [];
          for (var message in messages) {
            final messageText = (message.data() as dynamic)['text'];
            final messageSender = (message.data() as dynamic)['sender'];

            messageWidgets.add(
              MessageBubble(
                  sender: messageSender,
                  text: messageText,
                  isMe: messageSender == loggedInUser.email),
            );
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              children: messageWidgets,
            ),
          );
        });
  }
}

class MessageBubble extends StatelessWidget {
  final String? sender;
  final String? text;
  final bool? isMe;

  const MessageBubble({Key? key, this.sender, this.text, this.isMe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment:
              isMe == true ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              '$sender',
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.white,
              ),
            ),
            text == angry ||
                    text == sad ||
                    text == happy ||
                    text == nervous ||
                    text == confused ||
                    text == stunned
                ? Image.asset(
                    'images/${reactions[text]}',
                    width: 150.0,
                    height: 150.0,
                    fit: BoxFit.cover,
                  )
                : Material(
                    borderRadius: isMe == true
                        ? const BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0),
                            bottomLeft: Radius.circular(30.0),
                          )
                        : const BorderRadius.only(
                            topRight: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0),
                            bottomLeft: Radius.circular(30.0),
                          ),
                    elevation: 5.0,
                    color: isMe == true ? Colors.lightBlueAccent : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Text(
                        '$text',
                        style: isMe == true
                            ? const TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              )
                            : const TextStyle(
                                color: Colors.black54,
                                fontSize: 15.0,
                              ),
                      ),
                    ),
                  ),
          ],
        ));
  }
}
