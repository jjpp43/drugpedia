import 'package:flutter/material.dart';

final ThemeData postTheme = ThemeData(
  fontFamily: 'Yes_Body',
  textTheme: const TextTheme(
    /*   
     *   <Title>
     *   Noto Sans KR
     *   28
     *   Demilight
     *   0xff212121
     */
    titleLarge: TextStyle(
      color: Color(0xff1F1F1F),
      fontSize: 20,
      fontFamily: 'Yes_Title',
    ),
    /*   
     *   <Content>
     *   Noto Sans KR
     *   18
     *   Regular
     *   0xff212121
     */
    bodyLarge: TextStyle(
      color: Color(0xff1F1F1F),
      fontSize: 18,
    ),
    /*   
     *   <Comment Content>
     *   Noto Sans KR
     *   17
     *   Demilight
     *   0xff212121
     */
    bodyMedium: TextStyle(
      color: Color(0xff1F1F1F),
      fontSize: 17,
    ),
    /*   
     *   <Username>
     *   Noto Sans KR
     *   14
     *   Regular
     *   0xff353535
     */
    bodySmall: TextStyle(
      color: Color(0xff353535),
      fontSize: 16,
    ),
    /*   
     *   <Comment Username>
     *   Noto Sans KR
     *   13
     *   Regular
     *   0xff757575
     */
    labelLarge: TextStyle(
      color: Color(0xff353535),
      fontSize: 16,
    ),
    /*   
     *   <Comment Content>
     *   Noto Sans KR
     *   13
     *   Regular
     *   0xff757575
     */
    labelMedium: TextStyle(
      color: Color(0xff555555),
      fontSize: 15,
    ),
    /*   
     *   <Timestamp>
     *   Noto Sans KR
     *   13
     *   Regular
     *   0xff757575
     */
    labelSmall: TextStyle(
      color: Color(0xff757575),
      fontSize: 13,
    ),
  ),
);
