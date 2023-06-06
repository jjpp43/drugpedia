import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'controller/comment_controller.dart';
import 'controller/report_controller.dart';
import 'controller/toggle_btn_controller.dart';
import 'controller/mypage_controller.dart';
import 'controller/post_controller.dart';
import 'firestore_service.dart';

import 'app.dart';
import 'controller/auth_controller.dart';
import 'pages/login_page.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  void initState() {
    initialization();
    super.initState();
  }

  void initialization() async {
    Future.delayed(const Duration(milliseconds: 300));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext _, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          Get.put(FirestoreService());
          Get.put(PostController());
          Get.put(MyPageController());
          Get.put(ToggleButtonController());
          Get.put(CommentController());
          Get.put(ReportController());
          return FutureBuilder(
            future: Future.wait([
              Get.find<AuthController>().signInWithGoogle(),
            ]),
            builder: (context, snapshot) {
              return Builder(
                builder: (context) => const App(),
              );
            },
          );
        } else if (snapshot.hasError) {
          return const Text('Something is wrong');
        }

        return const LoginPage();
      },
    );
  }
}
