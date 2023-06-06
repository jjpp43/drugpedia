import 'package:flutter/material.dart';

final ThemeData homeTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(
      color: Color(
        0xff212121,
      ),
    ),
  ),
  fontFamily: 'Yangjin',
  textTheme: TextTheme(
    titleLarge: const TextStyle(
      color: Color.fromARGB(255, 72, 72, 72),
      fontSize: 40,
    ),

    titleMedium: const TextStyle(
      fontSize: 28,
      fontFamily: 'Yangjin',
      color: Color(0xff1F1F1F),
      letterSpacing: 4,
    ),

    /*
     * MainButton
     */

    //메인버튼 마약 이름(한글)
    labelLarge: TextStyle(
      fontSize: 24,
      fontFamily: 'Yes_Title',
      color: Colors.black.withOpacity(0.75),
      letterSpacing: 2,
    ),
    //메인버튼 마약 이름(영어)
    labelMedium: TextStyle(
      fontSize: 16,
      fontFamily: 'Yes_Title',
      color: Colors.black.withOpacity(0.75),
      letterSpacing: 2,
    ),
    //큰 제목
    bodyLarge: const TextStyle(
      fontSize: 34,
      fontFamily: 'Yes_Title',
      color: Color(
        0xff1F1F1F,
      ),
    ),
    //부제목
    bodyMedium: const TextStyle(
      fontSize: 26,
      fontFamily: 'Yes_Title',
      color: Color(0xff1F1F1F),
    ),
    //내용
    bodySmall: const TextStyle(
      fontSize: 18,
      fontFamily: 'Yes_Body',
      color: Color(
        0xff353535,
      ),
    ),
  ),
);
