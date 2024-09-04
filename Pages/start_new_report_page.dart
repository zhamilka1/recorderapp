import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:recorderapp/Components/my_button.dart';
import 'package:recorderapp/Components/my_text_field.dart';
import 'package:recorderapp/Services/chatGPT_service.dart';

Widget NewReportPage(DocumentSnapshot document) {
  final Map<String, dynamic> doc = document.data() as Map<String, dynamic>;
  final ChatGPTService chatGPTService = ChatGPTService();
  final TextEditingController title = TextEditingController();
  final TextEditingController size = TextEditingController();
  final TextEditingController style = TextEditingController();
  final TextEditingController keywords = TextEditingController();
  final TextEditingController additional = TextEditingController();
  return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(
                  height: 200,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(25, 100, 25, 0),
                      child: Text(
                        "Создание доклада",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.blueAccent,
                            decoration: TextDecoration.none),
                      ))),
              const Text(
                "Заголовок расшифровки",
                style: TextStyle(
                    color: Colors.black,
                    decoration: TextDecoration.none,
                    fontSize: 15),
              ),
              Text(
                doc['title'],
                style: const TextStyle(
                    color: Colors.black,
                    decoration: TextDecoration.none,
                    fontSize: 30),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    SizedBox(
                        child: MyTextField(
                      controller: title,
                      expandable: false,
                      hintText: "Заголовок доклада",
                      obscureText: false,
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        child: MyTextField(
                      controller: style,
                      expandable: false,
                      hintText: "Стиль оформления",
                      obscureText: false,
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      child: MyTextField(
                        controller: size,
                        expandable: false,
                        hintText: "Количество символов",
                        obscureText: false,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      child: MyTextField(
                        controller: keywords,
                        expandable: false,
                        hintText: "Ключевые слова",
                        obscureText: false,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      child: MyTextField(
                        controller: additional,
                        expandable: false,
                        hintText: "Особые промты",
                        obscureText: false,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      height: 50,
                      child: MyButton(
                          onTap: () {
                            chatGPTService.getPushParseReport(
                                style.text,
                                title.text,
                                keywords.text,
                                size.text,
                                additional.text,
                                doc["text"]);
                          },
                          text: "Генерация доклада"),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          )));
}
