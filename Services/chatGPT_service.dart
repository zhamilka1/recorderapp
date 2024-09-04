import "dart:convert";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:recorderapp/env.dart';
// ignore: depend_on_referenced_packages
import "package:http/http.dart" as http;
import "package:recorderapp/models/report.dart";

class ChatGPTService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> tryRequest(String promtString) async {
    final Constants env = Constants();
    String requestBody = jsonEncode({
      "model": "meta-llama/Meta-Llama-3-70B-Instruct",
      "messages": [
        {"role": "user", "content": promtString}
      ]
    });

    var url = Uri.https(env.llamaApiUrl, env.llamaApiVersion);
    var response = await http.post(url, body: requestBody, headers: {
      "Authorization": env.llamaApiKey,
      "Content-Type": " application/json"
    });
    var result =
        jsonDecode(utf8.decode(response.bodyBytes, allowMalformed: true));
    return result["choices"][0]["message"]["content"];
  }

  Future<String> getKeywords(String baseText) async {
    String result = await tryRequest(
        "На русском языке определи мне 5 ключевых слов для данного текста $baseText");
    return result;
  }

  Future getPushParseReport(String style, String title, String keywords,
      String size, String additional, String basetext) async {
    String content = await tryRequest(
        "На русском языке сформируй мне доклад в $style в докладе выдерживай ключевые слова keywords и $additional на основе текста $basetext количество символов доклада $size");

    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();

    Report report = Report(
        uId: currentUserId,
        text: content,
        title: title,
        keywords: keywords,
        timestamp: timestamp);

    await _firestore
        .collection('reports')
        .doc(currentUserId)
        .collection('userReports')
        .add(report.toMap());
  }

  Stream<QuerySnapshot> getReports(String userId) {
    // Возвращаем поток сообщений упорядоченных по временной метке
    return _firestore
        .collection('reports') // Обращаемся к коллекции чат-комнат
        .doc(userId) // Документ конкретной чат-комнаты
        .collection('userReports')
        .orderBy('timestamp', descending: false)
        .snapshots(); // Получаем поток данных для обновления сообщений
  }
}
