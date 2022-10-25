import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class MainPageBloc {
  final BehaviorSubject<String> statePageSubjects = BehaviorSubject<String>.seeded("current value: 0"); // объект типа String, на который можно подписаться в Стриме

  // BoxDecor d = BoxDecor(Colors.blue, ,"s" )

  Stream<String> observeStatePage() => statePageSubjects;

  int count = 0;

  void changeState() {
    count++;
    statePageSubjects.sink.add("new value: $count");

  }

  void resetState(){
    count=0;
    statePageSubjects.sink.add("new value: 0");
  }

  void dispose(){
    statePageSubjects.close();
  }
}



enum StateScreen { start, wait, stop }

class BoxDecor {
  const BoxDecor._(
    this.color,
    this.background,
    this.text,
  );

  final Color color;
  final Color background;
  final String text;

  @override
  String toString() {
    return 'boxDecor{color: $color, background: $background, text: $text}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BoxDecor &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          background == other.background &&
          text == other.text;

  @override
  int get hashCode => color.hashCode ^ background.hashCode ^ text.hashCode;
}
