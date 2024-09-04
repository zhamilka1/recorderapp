import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recorderapp/Components/my_button_icon.dart';
import 'package:recorderapp/Pages/home.dart';
import 'package:recorderapp/Services/auth/auth_service.dart';
import 'package:recorderapp/Pages/audio_page.dart';
import 'package:recorderapp/Pages/whisper_page.dart';
import 'package:recorderapp/Pages/chat_gpt_page.dart';

class PageNavigator extends StatelessWidget {
  const PageNavigator({super.key});
  @override
  Widget build(BuildContext context) {
    void signOut() {
      // Получение сервиса аутентификации.
      final authService = Provider.of<AuthService>(context, listen: false);
      authService
          .signOut(); // Вызов функции выхода через сервис аутентификации.
    }

    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: MyButtonIcon(
                  onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AudioPage()))
                      },
                  icon:
                      Icon(Icons.mic, color: Theme.of(context).disabledColor))),
          Expanded(
              flex: 1,
              child: MyButtonIcon(
                  onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WhisperPage()))
                      },
                  icon: Icon(Icons.text_format,
                      color: Theme.of(context).disabledColor))),
          Expanded(
              flex: 1,
              child: MyButtonIcon(
                  onTap: () => {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => HomePage()))
                      },
                  icon: const Icon(
                    Icons.home,
                    color: Colors.blueAccent,
                    size: 25,
                  ))),
          Expanded(
              flex: 1,
              child: MyButtonIcon(
                  onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatGPTPage()))
                      },
                  icon: Icon(Icons.message,
                      color: Theme.of(context).disabledColor))),
          Expanded(
              flex: 1,
              child: MyButtonIcon(
                  onTap: () => {signOut()},
                  icon: Icon(
                    Icons.logout,
                    color: Theme.of(context).disabledColor,
                  )))
        ],
      ),
    );
  }
}
