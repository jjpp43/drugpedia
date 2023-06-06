import 'package:flutter/material.dart';

final ThemeData profileTheme = ThemeData(
  fontFamily: 'Yangjin',
  textTheme: const TextTheme(
    /*   
     *   <username>
     *   Noto Sans KR
     *   20
     *   Bold
     *   0xff212121
     */
    bodyLarge: TextStyle(
      color: Color(0xff1F1F1F),
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    /*   
     *   <Title>
     *   Noto Sans KR
     *   16
     *   Bold
     *   0xff888888
     */
    bodyMedium: TextStyle(
      color: Color(0xff1F1F1F),
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    /*   
     *   <label>
     *   Noto Sans KR
     *   16
     *   Demilight
     *   0xff888888
     */
    bodySmall: TextStyle(
      color: Color(0xff1F1F1F),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  ),
);
