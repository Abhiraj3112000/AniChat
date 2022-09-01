import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../firebase.dart';

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
