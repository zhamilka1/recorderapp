import 'package:cloud_firestore/cloud_firestore.dart';

class Description {
  final String uId;
  final String text;
  final String title;
  final String keywords;
  final String audioUrl;
  final Timestamp timestamp;

  Description(
      {required this.uId,
      required this.text,
      required this.title,
      required this.keywords,
      required this.audioUrl,
      required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'text': text,
      'title': title,
      'keywords': keywords,
      'timestamp': timestamp,
      'audioUrl': audioUrl,
    };
  }
}
