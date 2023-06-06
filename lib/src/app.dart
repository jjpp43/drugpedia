import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'pages/mypage/profile_screen.dart';
import 'controller/auth_controller.dart';
import 'controller/bottom_nav_controller.dart';
import 'package:get/get.dart';
import 'controller/post_controller.dart';
import 'pages/board/board_screen.dart';
import 'pages/home/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'pages/home/components/phone_dialog.dart';
import 'controller/toggle_btn_controller.dart';
import 'dart:math' as math;

class App extends GetView<BottomNavController> {
  const App({super.key});

//전화연결
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  static const String homeSvg = 'assets/svg/home.svg';
  static const String listSvg = 'assets/svg/list.svg';
  static const String userSvg = 'assets/svg/user.svg';
  static const String bookSvg = 'assets/svg/book-alt.svg';
  static const String cancelSvg = 'assets/svg/cross.svg';
  static const phoneNumberList = [
    {
      'name': '국립부곡병원',
      'number': '0555366440',
      'uri': 'http://bgnmh.go.kr/',
    },
    {
      'name': '시립은평병원',
      'number': '023008114',
      'uri': 'https://ephosp.seoul.go.kr/'
    },
    {
      'name': '중독재활센터',
      'number': '0246790436',
      'uri':
          'https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query=%EC%A4%91%EB%8F%85%EC%9E%AC%ED%99%9C%EC%84%BC%ED%84%B0',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    final postType = Get.find<ToggleButtonController>().selectedType;
    final currentUserId = Get.find<AuthController>().getCurrentUserId();
    final currentUsername = Get.find<AuthController>().getCurrentUsername();

    return WillPopScope(
      onWillPop: controller.willPopAction,
      child: Obx(
        () => Scaffold(
          appBar: AppBar(
            title: Text(
              controller.title.toString(),
            ),
            actions: [
              controller.pageIndex.value == 0
                  ? IconButton(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      icon: const Icon(
                        Icons.info_outline,
                      ),
                      tooltip: '마약 관련 도움 요청하기',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => const PhoneNumbersDialog(
                            phoneNumbers: phoneNumberList,
                          ),
                        );
                      },
                    )
                  : Container(),
            ],
          ),
          body: IndexedStack(
            index: controller.pageIndex.value,
            children: const [
              HomeScreen(),
              BoardScreen(),
              ProfileScreen(),
            ],
          ),
          floatingActionButton: controller.pageIndex.value == 1
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 22, 8),
                  child: SizedBox(
                    height: 56,
                    width: 56,
                    child: Transform.rotate(
                      angle: 45 * math.pi / 180,
                      child: AnimatedRotation(
                        duration: const Duration(milliseconds: 500),
                        turns: controller.turns.value,
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(5, 0),
                              ),
                              BoxShadow(
                                offset: Offset(5, 2),
                              ),
                              BoxShadow(
                                offset: Offset(5, -2),
                              ),
                              BoxShadow(
                                offset: Offset(-2, 2),
                              ),
                              BoxShadow(
                                offset: Offset(2, -2),
                              ),
                              BoxShadow(
                                offset: Offset(-2, -2),
                              ),
                            ],
                          ),
                          child: FloatingActionButton(
                            shape: const ContinuousRectangleBorder(),
                            elevation: 0,
                            onPressed: () {
                              controller.openFab;
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return Container(
                                    color: const Color(0xffFAE9C8),
                                    height: MediaQuery.of(context).size.height *
                                        0.9,
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Stack(
                                          children: [
                                            // 취소 버튼
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                IconButton(
                                                  onPressed: () => Get.back(),
                                                  icon: const Icon(
                                                    Icons.close,
                                                    color: Color(0xffff5724),
                                                    size: 36,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // 글쓰기 텍스트
                                            const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  '글쓰기',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    letterSpacing: 3,
                                                    fontSize: 24,
                                                    fontFamily: 'Yangjin',
                                                    shadows: <Shadow>[
                                                      Shadow(
                                                        offset:
                                                            Offset(0.5, -0.5),
                                                        color: Colors.black54,
                                                      ),
                                                      Shadow(
                                                        offset:
                                                            Offset(-0.5, -0.5),
                                                        color: Colors.black54,
                                                      ),
                                                      Shadow(
                                                        offset:
                                                            Offset(-0.5, 0.5),
                                                        color: Colors.black54,
                                                      ),
                                                      Shadow(
                                                        offset:
                                                            Offset(0.5, 0.5),
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
                                              ],
                                            ),
                                            const SizedBox(height: 4),
                                            // 전송 버튼
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                //전송 버튼 클릭
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    shape: const CircleBorder(),
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    elevation: 0,
                                                  ),
                                                  onPressed: () async {
                                                    if (titleController
                                                                .text.length <
                                                            5 ||
                                                        contentController
                                                                .text.length <
                                                            10) {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          Future.delayed(
                                                            const Duration(
                                                                seconds: 1),
                                                            () {
                                                              Get.back();
                                                            },
                                                          );
                                                          return const Dialog(
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(16),
                                                              child: Text(
                                                                  '10자 이상 적어주세요'),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                      return;
                                                    }
                                                    if (Get.find<
                                                                ToggleButtonController>()
                                                            .selectedType
                                                            .value ==
                                                        '') {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          Future.delayed(
                                                            const Duration(
                                                                seconds: 1),
                                                            () {
                                                              Get.back();
                                                            },
                                                          );
                                                          return const Dialog(
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(16),
                                                              child: Text(
                                                                  '카테고리를 선택해주세요'),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                      return;
                                                    }

                                                    Get.find<PostController>()
                                                        .addPost(
                                                      titleController.text,
                                                      contentController.text,
                                                      currentUserId,
                                                      currentUsername,
                                                      postType.toString(),
                                                    )
                                                        .then(
                                                      (value) {
                                                        Get.back();
                                                        controller.openFab;
                                                      },
                                                    ).catchError(
                                                      (error) => Text(error),
                                                    );

                                                    Get.find<PostController>()
                                                        .getPosts();
                                                    // Close the bottom sheet
                                                    titleController.clear();
                                                    contentController.clear();
                                                  },
                                                  child: const Icon(
                                                    Icons.send_rounded,
                                                    color: Color(0xffff5724),
                                                    size: 36,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 16.0),
                                        Row(
                                          children: [
                                            CustomToggleButtons(),
                                          ],
                                        ),
                                        const SizedBox(height: 16.0),
                                        //Post title
                                        TextField(
                                          style: const TextStyle(
                                              fontFamily: 'Yes_Body'),
                                          controller: titleController,
                                          maxLength: 40,
                                          decoration: const InputDecoration(
                                            hintText: '제목 (5자 이상)',
                                          ),
                                        ),
                                        const SizedBox(height: 16.0),
                                        //Post content
                                        TextField(
                                          style: const TextStyle(
                                              fontFamily: 'Yes_Body'),
                                          controller: contentController,
                                          keyboardType: TextInputType.multiline,
                                          minLines: 1,
                                          maxLines: 15,
                                          maxLength: 300,
                                          decoration: const InputDecoration(
                                            hintText: '내용 (10자 이상)',
                                          ),
                                        ),
                                        const SizedBox(height: 16.0),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            backgroundColor: const Color(0xffff5724),
                            child: Transform.rotate(
                              angle: -45 * math.pi / 180,
                              child: const Center(
                                child: Icon(
                                  Icons.add,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
          bottomNavigationBar: BottomNavigationBar(
            selectedFontSize: 12,
            unselectedFontSize: 11,
            elevation: 1,
            backgroundColor: const Color(0xffEFD593),
            selectedItemColor: const Color(0xffff5724),
            unselectedItemColor: const Color(0xffAB926D),
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            currentIndex: controller.pageIndex.value,
            onTap: (value) {
              controller.changeBottomNav(value);
            },
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  bookSvg,
                  height: 22,
                  width: 22,
                  fit: BoxFit.scaleDown,
                  colorFilter: const ColorFilter.mode(
                    Color(0xffAB926D),
                    BlendMode.srcIn,
                  ),
                ),
                activeIcon: SvgPicture.asset(
                  bookSvg,
                  height: 24,
                  width: 24,
                  fit: BoxFit.scaleDown,
                  colorFilter: const ColorFilter.mode(
                    Color(0xffff5724),
                    BlendMode.srcIn,
                  ),
                ),
                label: '사전',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  listSvg,
                  height: 22,
                  width: 22,
                  fit: BoxFit.scaleDown,
                  colorFilter: const ColorFilter.mode(
                    Color(0xffAB926D),
                    BlendMode.srcIn,
                  ),
                ),
                activeIcon: SvgPicture.asset(
                  listSvg,
                  height: 24,
                  width: 24,
                  fit: BoxFit.scaleDown,
                  colorFilter: const ColorFilter.mode(
                    Color(0xffff5724),
                    BlendMode.srcIn,
                  ),
                ),
                label: '커뮤니티',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  userSvg,
                  height: 22,
                  width: 22,
                  fit: BoxFit.scaleDown,
                  colorFilter: const ColorFilter.mode(
                    Color(0xffAB926D),
                    BlendMode.srcIn,
                  ),
                ),
                activeIcon: SvgPicture.asset(
                  userSvg,
                  height: 24,
                  width: 24,
                  fit: BoxFit.scaleDown,
                  colorFilter: const ColorFilter.mode(
                    Color(0xffff5724),
                    BlendMode.srcIn,
                  ),
                ),
                label: '마이페이지',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
