import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../controller/auth_controller.dart';
import 'mypage_board_screen.dart';
import '../../theme/profile_text_theme.dart';
import 'mypage_comment_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String commentSvg = 'assets/svg/profile-comments.svg';
    const String postSvg = 'assets/svg/profile-posts.svg';
    const String codeSvg = 'assets/svg/square-code.svg';
    const String logoutSvg = 'assets/svg/sign-out.svg';
    const String emailSvg = 'assets/svg/email.svg';

    // Test Crashlytics
    ErrorWidget.builder = (FlutterErrorDetails details) {
      FirebaseCrashlytics.instance.recordFlutterError(details);
      return Container(); // Return an empty container to prevent UI errors
    };

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            FutureBuilder<User?>(
                future: Get.find<AuthController>().getUserInfo(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    return const Text('사용자 정보를 불러오는 중 에러가 발생했습니다');
                  }

                  final User? userInfo = snapshot.data;
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                          userInfo?.photoURL ?? '0',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            Text(
                              userInfo?.displayName ?? '?',
                              style: profileTheme.textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
            const SizedBox(
              height: 32,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Text(
                        '내 활동',
                        style: profileTheme.textTheme.bodyMedium,
                      )
                    ],
                  ),
                ),
                //아이콘 + 내 글
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const MyPageBoardScreen());
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          postSvg,
                          width: 21,
                          height: 21,
                          fit: BoxFit.scaleDown,
                          colorFilter: const ColorFilter.mode(
                            Color(
                              0xff212121,
                            ),
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          '내 글',
                          style: profileTheme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
                //아이콘 + 내 댓글
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const MyPageCommentScreen());
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          commentSvg,
                          width: 20,
                          height: 20,
                          fit: BoxFit.scaleDown,
                          colorFilter: const ColorFilter.mode(
                            Color(
                              0xff212121,
                            ),
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          '내 댓글',
                          style: profileTheme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            // 피드백
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Text(
                    '피드백',
                    style: profileTheme.textTheme.bodyMedium,
                  )
                ],
              ),
            ),
            // 아이콘 + 이메일
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  SvgPicture.asset(
                    emailSvg,
                    width: 20,
                    height: 20,
                    fit: BoxFit.scaleDown,
                    colorFilter: const ColorFilter.mode(
                      Color(
                        0xff212121,
                      ),
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'jparkdev63@gmail.com',
                    style: profileTheme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const Divider(),
            // 앱 버전
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Text(
                    '앱 버전',
                    style: profileTheme.textTheme.bodyMedium,
                  )
                ],
              ),
            ),
            // 아이콘 + 앱 버전
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  SvgPicture.asset(
                    codeSvg,
                    width: 20,
                    height: 20,
                    fit: BoxFit.scaleDown,
                    colorFilter: const ColorFilter.mode(
                      Color(
                        0xff212121,
                      ),
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'v1.0.0',
                    style: profileTheme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const Divider(),
            // 계정
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Text(
                    '계정',
                    style: profileTheme.textTheme.bodyMedium,
                  )
                ],
              ),
            ),
            // 아이콘 + 로그아웃
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: GestureDetector(
                onTap: () => Get.find<AuthController>().signOut(),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      logoutSvg,
                      width: 20,
                      height: 20,
                      fit: BoxFit.scaleDown,
                      colorFilter: const ColorFilter.mode(
                        Color(
                          0xff212121,
                        ),
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      '로그아웃',
                      style: profileTheme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
