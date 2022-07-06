import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() => runApp(const FlashChat());

class FlashChat extends StatelessWidget {
  const FlashChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const SizedBox(
              child: Directionality(
            textDirection: TextDirection.ltr,
            child: Text('Firebase Error'),
          ));
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            theme: ThemeData.dark().copyWith(
              textTheme: const TextTheme(
                bodyText1: TextStyle(color: Colors.black54),
              ),
            ),
            // home: WelcomeScreen(),
            initialRoute: WelcomeScreen.id,
            routes: {
              // When navigating to the "/" route, build the FirstScreen widget.
              WelcomeScreen.id: (context) => WelcomeScreen(),
              // When navigating to the "/second" route, build the SecondScreen widget.
              LoginScreen.id: (context) => LoginScreen(),
              RegistrationScreen.id: (context) => RegistrationScreen(),
              ChatScreen.id: (context) => ChatScreen(),
            },
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const SizedBox(
            child: Directionality(
          textDirection: TextDirection.ltr,
          child: Text('Hello'),
        ));
      },
    );
  }
}
