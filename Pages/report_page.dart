import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:recorderapp/Components/my_button.dart';
import 'package:recorderapp/Components/my_text_field.dart';
import 'package:flutter/services.dart';

Future saveDescription(userId, docId, String title, String text) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  await firestore
      .collection('reports')
      .doc(userId)
      .collection('userReports')
      .doc(docId)
      .update({'title': title, 'text': text});
}

Widget reportPage(DocumentSnapshot report) {
  final Map<String, dynamic> doc = report.data() as Map<String, dynamic>;
  var docId = report.reference.id;
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
                        "Редактирование доклада",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.blueAccent,
                            decoration: TextDecoration.none),
                      ))),
              SizedBox(
                  height: 450,
                  child: Markdown(data: transcriptionEditingController.text)),
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
