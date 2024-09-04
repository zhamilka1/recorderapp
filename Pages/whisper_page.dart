import 'package:flutter/material.dart';
import 'package:recorderapp/Components/navigator.dart';
import 'package:recorderapp/Services/whisper_service.dart';
import 'package:recorderapp/env.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recorderapp/Components/my_text_field.dart';
import 'package:recorderapp/Components/my_button.dart';
import 'package:recorderapp/Components/my_button_icon.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:recorderapp/Pages/description_page.dart';
import 'package:recorderapp/Pages/start_new_report_page.dart';

class WhisperPage extends StatefulWidget {
  const WhisperPage({super.key});
  @override
  State<WhisperPage> createState() => _WhisperPageState();
}

class _WhisperPageState extends State<WhisperPage> {
  Constants env = Constants();
  late WhisperService _whisperService;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  PlatformFile? _pickedFile;
  UploadTask? _uploadTask;

  @override
  void initState() {
    super.initState();
    _whisperService = WhisperService(
        urlToWhisper: env.replicateApiUrl,
        replicateApiVersion: env.replicateApiVersion,
        whisperModelVersion: env.whisperModelVersion,
        whisperApiKey: env.whisperApiKey);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      bottomNavigationBar: BottomAppBar(child: PageNavigator()),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            {showDialog(context: context, builder: whisperInterface)},
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
      stream: _whisperService.getDescriptions(_firebaseAuth
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
              .map((document) => _buildDescriptionItem(document))
              .toList(),
        );
      },
    );
  }

  Widget _buildDescriptionItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return Padding(
        padding: EdgeInsets.all(2),
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
                            builder: (context) => descriptionPage(document)));
                  },
                  icon: const Icon(Icons.edit, color: Colors.blueAccent),
                )),
            Expanded(
              flex: 6,
              child: MyButton(
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewReportPage(
                                document,
                              )))
                },
                text: data['title'],
              ),
            )
          ]),
        ));
  }

  Future selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return;
    }
    setState(() {
      _pickedFile = result.files.first;
    });
  }

  Future sendFile(String title) async {
    final path = 'audiofiles/${_pickedFile!.name}';
    final file = File(_pickedFile!.path!);

    var ref = _storage.ref().child(path);
    _uploadTask = ref.putFile(file);
    await _uploadTask;
    String urlDownland = await ref.getDownloadURL();
    _whisperService.getPushParsePrediction(urlDownland, title);
  }

  Widget whisperInterface(BuildContext context) {
    final titleEditingController = TextEditingController(text: "unnamed");
    return AlertDialog(
        title: const Row(children: [
          Text("Расшифровка"),
        ]),
        content: Container(
            height: 200,
            child: Column(
              children: [
                const Text("Название расшифровки"),
                MyTextField(
                    expandable: false,
                    controller: titleEditingController,
                    hintText: "Название расшифровки",
                    obscureText: false),
                ElevatedButton(
                    onPressed: selectFile, child: Text("Выбрать аудиофайл")),
                ElevatedButton(
                    onPressed: () {
                      sendFile(titleEditingController.text);
                    },
                    child: Text("Запустить расшифровку")),
              ],
            )));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
