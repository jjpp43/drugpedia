import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  final String backgroundImg = 'assets/images/background_login.png';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImg),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Column(
                children: [],
              ),
              const SizedBox(
                height: 120,
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black38,
                          offset: Offset(2, 2),
                        ),
                        BoxShadow(
                          color: Colors.black38,
                          offset: Offset(4, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        fixedSize: Size(
                          MediaQuery.of(context).size.width * 0.64,
                          MediaQuery.of(context).size.width * 0.64 * 0.2,
                        ),
                        backgroundColor: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/btn_google_light_normal_xxhdpi.png',
                            width: 36,
                            height: 36,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Google 계정으로 로그인',
                            style: TextStyle(
                              fontFamily: 'Yes_Title',
                              fontSize: 15,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Get.find<AuthController>().signInWithGoogle();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
