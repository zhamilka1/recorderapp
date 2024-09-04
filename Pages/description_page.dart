import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recorderapp/Components/my_button.dart';
import 'package:recorderapp/Components/my_text_field.dart';
import 'package:flutter/services.dart';

Future saveDescription(userId, docId, String title, String text) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  await firestore
      .collection('descriptions')
      .doc(userId)
      .collection('userDescriptions')
      .doc(docId)
      .update({'title': title, 'text': text});
}

Widget descriptionPage(DocumentSnapshot description) {
  final Map<String, dynamic> doc = description.data() as Map<String, dynamic>;
  var docId = description.reference.id;
  TextEditingController titleEditingController =
      TextEditingController(text: doc['title']);
  TextEditingController transcriptionEditingController =
      TextEditingController(text: doc['text']);
  return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(
                  height: 125,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(25, 75, 25, 0),
                      child: Text(
                        "Редактирование расшифровки",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.blueAccent,
                            decoration: TextDecoration.none),
                      ))),
              SizedBox(
                  height: 450,
                  child: MyTextField(
                      expandable: true,
                      controller: transcriptionEditingController,
                      hintText: "Текст расшифровки",
                      obscureText: false)),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                child: MyTextField(
                  controller: titleEditingController,
                  expandable: false,
                  obscureText: false,
                  hintText: "Заголовок",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  SizedBox(
                      height: 50,
                      child: MyButton(
                          onTap: () {
                            if (doc['text'] != "") {
                              Clipboard.setData(
                                  ClipboardData(text: doc["text"]));
                            }
                          },
                          text: "скопировать")),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                      height: 50,
                      child: MyButton(
                          onTap: () {
                            saveDescription(
                                doc["uId"],
                                docId,
                                titleEditingController.text,
                                transcriptionEditingController.text);
                          },
                          text: "сохранить"))
                ],
              )
            ],
          )));
}
