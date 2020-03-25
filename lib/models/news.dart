import 'package:flutter/cupertino.dart';

class News {
  String id;
  String title;
  String text;
  String pictureUrl;
  DateTime date;

  News({
    @required this.id,
    @required this.title,
    @required this.text,
    @required this.pictureUrl,
    @required this.date,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['_id'],
      title: json['title'],
      text: json['text'],
      pictureUrl: json['pictureUrl'],
      date: DateTime.parse(json['date']),
    );
  }
}
