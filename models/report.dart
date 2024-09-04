import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  final String uId;
  final String text;
  final String title;
  final String keywords;
  final Timestamp timestamp;

  Report(
      {required this.uId,
      required this.text,
      required this.title,
      required this.keywords,
      required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'text': text,
      'title': title,
      'keywords': keywords,
      'timestamp': timestamp,
    };
  }
}
