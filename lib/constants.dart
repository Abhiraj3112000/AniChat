import 'package:flutter/material.dart';
import 'components/reaction_button.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  hintStyle: TextStyle(color: Colors.black38),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const String angry = '__jyh23__angry_27hyg___emo__328jhg__';
const String sad = '__jyh23__sad_27hyg___emo__328jhg__';
const String confused = '__jyh23__confused_27hyg___emo__328jhg__';
const String happy = '__jyh23__happy_27hyg___emo__328jhg__';
const String nervous = '__jyh23__nervous_27hyg___emo__328jhg__';
const String stunned = '__jyh23__stunned_27hyg___emo__328jhg__';

List<Widget> reaction_tray = [
  ReactionButton(text: nervous, reaction: '😖'),
  ReactionButton(text: angry, reaction: '😡'),
  ReactionButton(text: stunned, reaction: '😮'),
  ReactionButton(text: happy, reaction: '😊'),
  ReactionButton(text: sad, reaction: '😭'),
  ReactionButton(text: confused, reaction: '😵'),
];

var reactions = {
  angry: 'anime-angry.gif',
  sad: 'anime-sad.gif',
  confused: 'anime-confused.gif',
  happy: 'anime-happy.gif',
  nervous: 'anime-nervous.gif',
  stunned: 'anime-stunned.gif',
};
