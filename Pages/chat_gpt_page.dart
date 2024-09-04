import 'package:flutter/material.dart';
import 'package:recorderapp/Components/navigator.dart';
import 'package:recorderapp/Pages/whisper_page.dart';
import 'package:recorderapp/Services/chatGPT_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recorderapp/Components/my_button.dart';
import 'package:recorderapp/Components/my_button_icon.dart';
import 'package:recorderapp/Pages/report_page.dart';

class ChatGPTPage extends StatefulWidget {
  const ChatGPTPage({super.key});

  @override
  State<ChatGPTPage> createState() => _ChatGPTPageState();
}

class _ChatGPTPageState extends State<ChatGPTPage> {
  final ChatGPTService _chatGPTService = ChatGPTService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      bottomNavigationBar: const BottomAppBar(child: PageNavigator()),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const WhisperPage()))
        },
        child: const Icon(Icons.add),
      ),
      body: Expanded(
        // Виджет для списка сообщений, занимает все доступное пространство
        child: _buildDescriptionsList(), // Построение списка сообщений
      ),
    ));
  }

  Widget _buildDescriptionsList() {
    return StreamBuilder(
      // Создание StreamBuilder для работы с потоковыми данными
      stream: _chatGPTService.getReports(_firebaseAuth
          .currentUser!.uid), // Инициализация потока сообщений от сервиса чата
      builder: (context, snapshot) {
        // Функция-строитель, создающая UI на основе текущего состояния snapshot
        if (snapshot.hasError) {
          // Проверка на наличие ошибки в потоке данных
          return Text(
              'Error${snapshot.error}'); // Отображение сообщения об ошибке
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Проверка состояния соединения, ждем ли данные
          return Container(); // Отображение текста, указывающего на процесс загрузки
        }
        // Создание прокручиваемого списка сообщений, если данные успешно получены
        return ListView(
          // Использование ListView для вывода списка элементов
          children: snapshot.data!.docs
              .map((document) => _buildReportItem(document))
              .toList(),
        );
      },
    );
  }

  Widget _buildReportItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return Padding(
        padding: const EdgeInsets.all(2),
        child: Container(
          height: 50,
          padding: const EdgeInsets.all(1),
          margin: const EdgeInsets.all(1),
          child: Row(children: [
            Expanded(
                flex: 1,
                child: MyButtonIcon(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => reportPage(document)));
                  },
                  icon: const Icon(Icons.edit, color: Colors.blueAccent),
                )),
            Expanded(
              flex: 6,
              child: MyButton(
                onTap: () => {},
                text: data['title'],
              ),
            )
          ]),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
