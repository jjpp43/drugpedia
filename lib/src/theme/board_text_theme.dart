import 'package:flutter/material.dart';

final ThemeData boardTheme = ThemeData(
  textTheme: const TextTheme(
    /*   
     *   <Title>
     *   Noto Sans KR
     *   17
     *   Regular
     *   0xff212121
     */
    titleLarge: TextStyle(
      color: Color(0xff1F1F1F),
      fontSize: 18,
      fontFamily: 'Yes_Title',
    ),
    /*   
     *   <Content>
     *   Noto Sans KR
     *   13
     *   Regular
     *   0xff888888
     */
    titleMedium: TextStyle(
      color: Color(0xff757575),
      fontSize: 16,
      fontFamily: 'Yes_Body',
    ),
    /*   
     *   <Details>
     *   Noto Sans KR
     *   12
     *   Regular
     *   0xff888888
     */
    titleSmall: TextStyle(
      color: Color(0xff888888),
      fontSize: 13,
      fontFamily: 'Yes_Body',
    ),
    /*   
     *   <Type>
     *   Noto Sans KR
     *   12
     *   Regular
     *   0xff
     */
    labelSmall: TextStyle(
      color: Colors.white,
      fontSize: 12,
      fontFamily: 'Yes_Title',
    ),
  ),
);
