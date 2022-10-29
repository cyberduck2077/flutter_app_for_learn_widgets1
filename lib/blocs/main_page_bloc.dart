import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_for_learn_widgets1/model/MyModel.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

class MainPageBloc {
  final BehaviorSubject<String> statePageSubjects = BehaviorSubject<
          String>.seeded(
      "current value: 0"); // объект типа String, на который можно подписаться в Стриме
  final BehaviorSubject<String> stateDataFromServerSubject = BehaviorSubject<
          String>.seeded(
      "no data"); // объект типа String, на который можно подписаться в Стриме

  // BoxDecor d = BoxDecor(Colors.blue, ,"s" )

  Stream<String> observeStatePage() => statePageSubjects;

  Stream<String> observeDataFromServer() => stateDataFromServerSubject;

  // String textFromServer = "Data from Server: ";

  final url = Uri.parse('https://jsonplaceholder.typicode.com/todos/1');

  Future<MyModel> fetchData() async {
    final response = await http.get(url);

    try {
      return MyModel.fromJson(jsonDecode(response.body));
    } catch (_) {
      throw Exception("Failed to load data");
    }
  }

  void getTextFromServer() {
    fetchData().then((value) {
      stateDataFromServerSubject.sink.add("Data from Server: ${value.title}");
    });
  }

  int count = 0;

  void changeState() {
    count++;
    statePageSubjects.sink.add("new value: $count");
  }

  void resetState() {
    count = 0;
    statePageSubjects.sink.add("new value: 0");
  }

  void dispose() {
    statePageSubjects.close();
    stateDataFromServerSubject.close();
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
