import 'package:flutter/material.dart';

// Объявляем класс MyButton, наследуемый от StatelessWidget — базовый виджет для создания кнопки
class MyButtonIcon extends StatelessWidget {
  final void Function()?
      onTap; // Объявляем колбэк-функцию для обработки нажатия
  final Icon icon;

  // Конструктор класса MyButton
  const MyButtonIcon({
    super.key, // Ключ для контроля состояния виджета
    required this.onTap, // Обязательный параметр для колбэка нажатия
    required this.icon,
    // Обязательный параметр для текста кнопки
  });

  @override
  Widget build(BuildContext context) {
    // Переопределенный метод строит элемент интерфейса
    return GestureDetector(
      // Виджет для обработки жестов
      onTap: onTap, // Передача колбэка onTap
      child: Container(
        // Контейнер для стилизации элемента
        padding: const EdgeInsets.all(10), // Внутренний отступ со всех сторон
        // ignore: prefer_const_constructors
        decoration: BoxDecoration(
            // Оформление контейнера
            color: Color.fromARGB(255, 240, 240, 240),
            // Скругление углов
            borderRadius: BorderRadius.circular(5)),
        child: Center(
            // Центрированный виджет
            child: icon),
      ),
    );
  }
}
