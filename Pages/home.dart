import 'dart:ffi';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recorderapp/Pages/audio_page.dart';
import 'package:recorderapp/Pages/chat_gpt_page.dart';
import 'package:recorderapp/Pages/whisper_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
      ),
      child: Container(
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFF7FAFC),
          ),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Opacity(
                    opacity: 1,
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            'assets/images/depth_2_frame_0.png',
                          ),
                        ),
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.fromLTRB(16, 300, 16, 40),
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                                sigmaX: 3,
                                sigmaY: 3,
                                tileMode: TileMode.repeated),
                            child: Container(
                              width: double.infinity,
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(),
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 30.9, 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                                        child: Text(
                                          'От голоса к тексту',
                                          style: GoogleFonts.getFont(
                                            'Inter',
                                            fontWeight: FontWeight.w900,
                                            fontSize: 36,
                                            height: 1.3,
                                            color: Color(0xFF000000),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 0, 3.6, 0),
                                        child: Text(
                                          'элегантное формирование структурированных докладов',
                                          style: GoogleFonts.getFont(
                                            'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            height: 1.5,
                                            color: Color(0xFF000000),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFF7FAFC),
                  ),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(16, 16, 18, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AudioPage()));
                          },
                          child: Text(
                            'Новая запись',
                            style: GoogleFonts.getFont(
                              'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              height: 1.5,
                              color: Color(0xFF0D141C),
                            ),
                          ),
                        ),
                        Container(
                          width: 24,
                          height: 24,
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: SvgPicture.asset(
                              'assets/vectors/vector_08_x2.svg',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF7FAFC),
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(16, 16, 18, 16),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WhisperPage()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                'Расшифровка текста',
                                style: GoogleFonts.getFont(
                                  'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  height: 1.5,
                                  color: Color(0xFF0D141C),
                                ),
                              ),
                            ),
                            Container(
                              width: 24,
                              height: 24,
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: SvgPicture.asset(
                                  'assets/vectors/vector_05_x2.svg',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF7FAFC),
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(16, 16, 18, 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatGPTPage()));
                            },
                            child: Text(
                              'Работа с Llama',
                              style: GoogleFonts.getFont(
                                'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                height: 1.5,
                                color: Color(0xFF0D141C),
                              ),
                            ),
                          )),
                          Container(
                            width: 24,
                            height: 24,
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: SvgPicture.asset(
                                'assets/vectors/vector_01_x2.svg',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 23.5),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      child: Text(
                        'Темы для вас',
                        style: GoogleFonts.getFont(
                          'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                          height: 1.3,
                          letterSpacing: -0.3,
                          color: Color(0xFF0D141C),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(12, 0, 12, 12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              color_tag('AI'),
                              tag('Dart'),
                              color_tag('IT'),
                              tag('Музыка'),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              tag('Музыка'),
                              color_tag('STT'),
                              tag('Диплом'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

Widget tag(text) {
  Color color = Color(0xFFE8EDF5);
  return Container(
    margin: EdgeInsets.fromLTRB(0, 0, 12.5, 0),
    child: Container(
      decoration: BoxDecoration(
        color: Color(0xFFE8EDF5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: GestureDetector(
        onTap: () {},
        child: Padding(
            padding: EdgeInsets.fromLTRB(16, 5.5, 16.1, 5.5),
            child: Row(
              children: [
                Text(
                  text,
                  style: GoogleFonts.getFont(
                    'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    height: 1.5,
                    color: Color(0xFF0D141C),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    color = Colors.blueGrey;
                  },
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Icon(
                        Icons.close,
                        size: 18,
                      )),
                )
              ],
            )),
      ),
    ),
  );
}

Widget color_tag(text) {
  Color color = Color(0xFFE8EDF5);
  return Container(
    margin: EdgeInsets.fromLTRB(0, 0, 12.5, 0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: GestureDetector(
        onTap: () {},
        child: Padding(
            padding: EdgeInsets.fromLTRB(16, 5.5, 16.1, 5.5),
            child: Row(
              children: [
                Text(
                  text,
                  style: GoogleFonts.getFont(
                    'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    height: 1.5,
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    color = Colors.blueAccent;
                  },
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Icon(
                        Icons.close,
                        size: 18,
                      )),
                )
              ],
            )),
      ),
    ),
  );
}
