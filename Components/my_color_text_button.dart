import 'package:flutter/material.dart';

// Объявляем класс MyButton, наследуемый от StatelessWidget — базовый виджет для создания кнопки
class MyColorTextButton extends StatelessWidget {
  final void Function()?
      onTap; // Объявляем колбэк-функцию для обработки нажатия
  final String text; // Переменная для текста кнопки
  final Color textColor;
  final Color bgcolor;
  // Конструктор класса MyButton
  const MyColorTextButton(
      {super.key, // Ключ для контроля состояния виджета
      required this.onTap, // Обязательный параметр для колбэка нажатия
      required this.text,
      required this.textColor,
      required this.bgcolor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: bgcolor, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                decoration: TextDecoration.none),
          ),
        ),
      ),
    );
  }
}
