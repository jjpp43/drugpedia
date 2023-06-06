import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'src/binding/init_binding.dart';
import 'src/root.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // Firebase
  await Firebase.initializeApp();
  // Firebase Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: '슬생바생',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Color(0xffEFD593),
            titleTextStyle: TextStyle(
              color: Colors.white,
              letterSpacing: 3,
              fontSize: 24,
              fontFamily: 'Yangjin',
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(0.5, -0.5),
                  color: Colors.black54,
                ),
                Shadow(
                  offset: Offset(-0.5, -0.5),
                  color: Colors.black54,
                ),
                Shadow(
                  offset: Offset(-0.5, 0.5),
                  color: Colors.black54,
                ),
                Shadow(
                  offset: Offset(0.5, 0.5),
                  color: Colors.black54,
                ),
                Shadow(
                  offset: Offset(2, 2),
                  color: Colors.black54,
                ),
                Shadow(
                  offset: Offset(3, 3),
                  color: Colors.black54,
                ),
              ],
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(0.5, -0.5),
                color: Colors.black54,
              ),
              Shadow(
                offset: Offset(-0.5, -0.5),
                color: Colors.black54,
              ),
              Shadow(
                offset: Offset(-0.5, 0.5),
                color: Colors.black54,
              ),
              Shadow(
                offset: Offset(0.5, 0.5),
                color: Colors.black54,
              ),
              Shadow(
                offset: Offset(1, 1),
                color: Colors.black54,
              ),
              Shadow(
                offset: Offset(1.5, 1.5),
                color: Colors.black54,
              ),
            ],
          ),
          fontFamily: 'Yangjin',
          scaffoldBackgroundColor: const Color(0xffFAE9C8)),
      home: const Root(),
      initialBinding: InitBinding(),
    );
  }
}
