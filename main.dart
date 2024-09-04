import 'package:flutter/material.dart';
import 'package:recorderapp/firebase_options.dart';
import 'package:recorderapp/Services/auth/auth_gate.dart';
import 'package:recorderapp/Services/auth/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Инициализация Flutter виджетов перед выполнением асинхронных операций.
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions
          .currentPlatform); // Асинхронно инициализируем Firebase с авто-определенными опциями в зависимости от платформы.
  await FirebaseAppCheck.instance
      // Your personal reCaptcha public key goes here:
      .activate(
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.debug,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) =>
          AuthService(), // Создаем экземпляр AuthService, который будет доступен для потомков в дереве виджетов.
      child: const MyApp(), // Запускаем основное приложение "MyApp".
    ),
  );
}

class MyApp extends StatelessWidget {
  // Определяем основной класс приложения, который является статичным и не изменяет своего состояния.
  const MyApp({super.key}); // Конструктор класса MyApp с ключом.

  @override
  Widget build(BuildContext context) {
    // Определяем метод построения UI.
    return const MaterialApp(
      debugShowCheckedModeBanner:
          false, // Убираем баннер режима отладки в углу экрана.
      home: AuthGate(), // Устанавливаем AuthGate в качестве домашнего экрана.
    );
  }
}
