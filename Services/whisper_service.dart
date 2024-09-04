import "dart:convert";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
// ignore: depend_on_referenced_packages
import "package:http/http.dart" as http;
import "package:recorderapp/models/description.dart";

class WhisperService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final String urlToWhisper;
  final String replicateApiVersion;
  final String whisperModelVersion;
  final String whisperApiKey;

  WhisperService(
      {required this.urlToWhisper,
      required this.replicateApiVersion,
      required this.whisperModelVersion,
      required this.whisperApiKey});

  Future<String> startPredictionAndReturnUrl(String urlToAudio) async {
    String requestBody = jsonEncode({
      "version": whisperModelVersion,
      "input": {
        'audio': urlToAudio,
      }
    });
    var url = Uri.https(urlToWhisper, replicateApiVersion);
    var response = await http.post(url,
        body: requestBody, headers: {"Authorization": whisperApiKey});
    var result = jsonDecode(response.body);
    return result['urls']['get'];
  }

  Future<String> getPrediction(predictionUrl) async {
    await Future.delayed(const Duration(seconds: 60));
    var url = Uri.parse(predictionUrl);
    var response =
        await http.get(url, headers: {'Authorization': whisperApiKey});
    var result = jsonDecode(response.body);
    return result["output"]["transcription"].toString();
  }

  Future getPushParsePrediction(String urlToAudio, String title) async {
    String startPredictionResponse =
        await startPredictionAndReturnUrl(urlToAudio);
    String getPredictionResponse = await getPrediction(startPredictionResponse);
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();
    Description description = Description(
        uId: currentUserId,
        text: getPredictionResponse,
        title: title,
        keywords: "",
        audioUrl: urlToAudio,
        timestamp: timestamp);
    await _firestore
        .collection('descriptions')
        .doc(currentUserId)
        .collection('userDescriptions')
        .add(description.toMap());
  }

  Stream<QuerySnapshot> getDescriptions(String userId) {
    // Возвращаем поток сообщений упорядоченных по временной метке
    return _firestore
        .collection('descriptions') // Обращаемся к коллекции чат-комнат
        .doc(userId) // Документ конкретной чат-комнаты
        .collection('userDescriptions')
        .orderBy('timestamp', descending: false)
        .snapshots(); // Получаем поток данных для обновления сообщений
  }
}
