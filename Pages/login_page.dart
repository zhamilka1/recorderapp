import 'package:recorderapp/Components/my_color_text_button.dart';
import 'package:recorderapp/Components/my_password_field.dart';
import 'package:recorderapp/Components/my_text_field.dart'; // Пользовательский виджет текстового поля
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart'; // Основной пакет виджетов и стилей Flutter
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart'; // Пакет для управления состоянием приложения через Provider
import 'package:recorderapp/Services/auth/auth_service.dart'; // Сервис аутентификации пользователя

// Создание класса LoginPage, который будет состоянием StatefulWidget
class LoginPage extends StatefulWidget {
  final void Function()?
      onTap; // Переменная для функции обратного вызова при нажатии
  const LoginPage(
      {super.key,
      required this.onTap}); // Конструктор класса с ключом и функцией onTap

  @override // Переопределение метода createState для создания состояния
  State<LoginPage> createState() =>
      _LoginPageState(); // Создание состояния _LoginPageState для LoginPage
}

// Класс состояния _LoginPageState для нашего StatefulWidget LoginPage
class _LoginPageState extends State<LoginPage> {
  // Контроллеры текста для управления вводом пользователя
  final emailController =
      TextEditingController(); // Контроллер для электронной почты
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  // Метод для входа пользователя в систему
  void signIn() async {
    // Получаем экземпляр authService для работы с аутентификацией
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      // Пытаемся войти по электронной почте и паролю
      await authService.signInWithEmailandPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      // Обрабатываем возможные ошибки
      // Показываем сообщение об ошибке на экране
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString() // Преобразуем ошибку в строку и отображаем
              )));
    }
  }

  void signInWithGoogle() async {
    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      authService.signUpZ(authResult);
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString() // Преобразуем ошибку в строку и отображаем
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Создает основную структуру визуального макета приложения
        backgroundColor: Colors.white, // Устанавливает фоновый цвет Scaffold
        body: SafeArea(
          // Виджет, создающий область в интерфейсе, которая не перекрывается, например, нотчем или системными индикаторами
          child: SingleChildScrollView(
            // Этот виджет позволяет прокручивать его содержимое, если оно переполняет видимую область
            child: Expanded(
              // Виджет, который расширяет дочерний элемент, чтобы заполнить все доступное пространство
              child: Center(
                // Центрирует его дочерний элемент
                child: Padding(
                  // Применяет отступы ко всем граням дочернего элемента
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                      vertical:
                          50.0), // Устанавливает горизонтальные и вертикальные отступы
                  child: Column(
                    // Виджет, который отображает своих детей в вертикальной последовательности
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Центрует детей в основной оси (вертикальной)
                    children: [
                      // Массив дочерних виджетов
                      const SizedBox(
                        height: 50,
                      ), // Оставляет пустое пространство с фиксированной высотой
                      // значок сообщения
                      const Icon(
                        // Виджет иконки
                        Icons.text_format, // Значок иконки
                        size: 100, // Размер значка
                        color: Colors.blueAccent, // Цвет значка
                      ),
                      const SizedBox(
                        height: 50,
                      ), // Оставляет пустое пространство с фиксированной высотой
                      // приветственное сообщение
                      MyTextField(
                          expandable: false,
                          controller: emailController,
                          hintText: 'Email',
                          obscureText: false),
                      const SizedBox(height: 10),
                      MyPasswordField(
                          controller: passwordController,
                          hintText: 'Password',
                          obscureText: true),
                      const SizedBox(
                          height:
                              25), // Оставляет пустое пространство с фиксированной высотой
                      // кнопка входа
                      SizedBox(
                          height: 50,
                          child: MyColorTextButton(
                              onTap: signIn,
                              text: "Войти",
                              textColor: Colors.white,
                              bgcolor: Colors.blueAccent)),
                      const SizedBox(height: 10),
                      SizedBox(
                          height: 50,
                          child: MyColorTextButton(
                              onTap: signInWithGoogle,
                              text: "Войти с Google",
                              textColor: Colors.white,
                              bgcolor: Colors.blueAccent)),
                      const SizedBox(
                          height:
                              50), // Оставляет пустое пространство с фиксированной высотой
                      // зарегистрироваться
                      Row(
                        // Виджет, располагающий своих детей в горизонтальной последовательности
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Вы еще с не с нами?'),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: const Text(
                              'Зарегистрируйтесь!',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
