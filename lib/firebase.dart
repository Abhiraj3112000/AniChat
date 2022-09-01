import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final fireStore = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;

late User loggedInUser;
late String message;

void getCurrentUser() {
  final user = auth.currentUser;
  try {
    if (user != null) {
      loggedInUser = user;
      print(loggedInUser.email);
    }
  } catch (e) {
    print(e);
  }
}

void getMessages() async {
  // getting data using strings (does not notify updates automatically unlike streams)
  // final messages = await _fireStore.collection('messages').get();
  // for (var message in messages.docs) {
  //   print(message.data());
  // }

  // getting data using stream (updates whenever data changes automatically) -
  await for (var snapshot in fireStore.collection('messages').snapshots()) {
    for (var message in snapshot.docs) {
      print(message.data());
    }
  }
}
