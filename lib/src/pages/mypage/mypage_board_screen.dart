import 'package:flutter/material.dart';
import '../../theme/board_text_theme.dart';
import '../../controller/mypage_controller.dart';
import 'package:get/get.dart';
import '../../models/post_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../board/post_screen.dart';

class MyPageBoardScreen extends StatefulWidget {
  const MyPageBoardScreen({Key? key}) : super(key: key);

  @override
  State<MyPageBoardScreen> createState() => _MyPageBoardScreenState();
}

class _MyPageBoardScreenState extends State<MyPageBoardScreen> {
  static const String commentSvg = 'assets/svg/comment.svg';
  static const String eyeSvg = 'assets/svg/eye.svg';
  static const String menuSvg = 'assets/svg/menu-dots-vertical.svg';
  static const String trashSvg = 'assets/svg/trash.svg';
  static const String backButtonSvg = 'assets/svg/angle-left.svg';

  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    Get.find<MyPageController>().getPostsByUserId();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      // Reached the bottom of the list
      if (!isLoading) {
        isLoading = true;
        final List<PostModel> posts = Get.find<MyPageController>().myPosts;
        if (posts.isNotEmpty) {
          final PostModel lastPost = posts.last;
          Get.find<MyPageController>().getMorePostsByUserId(lastPost);
        }
      }
    }
  }

  Color _colorChoice(String type) {
    switch (type) {
      // 도움 요청
      case '도움 요청':
        return const Color(0xffC50603);

      // 정보 공유
      case '정보 공유':
        return const Color(0xffFE642E);

      // 치료 후기
      case '치료 후기':
        return const Color(0xff00726B);

      // 기타
      case '기타':
        return const Color(0xff024B6E);

      default:
        return const Color(0xff378CB1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '내 글',
          style: TextStyle(
            letterSpacing: 3,
            fontSize: 24,
            fontFamily: 'Yangjin',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          16,
        ),
        child: GetBuilder<MyPageController>(
          init: Get.find<MyPageController>(),
          builder: (controller) {
            return Obx(
              () {
                if (controller.myPosts.isEmpty) {
                  return const Center(
                    child: Text('No posts available'),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  controller: _scrollController,
                  itemCount: controller.myPosts.length,
                  itemBuilder: (context, index) {
                    if (index == controller.myPosts.length) {
                      controller
                          .getMorePostsByUserId(controller.myPosts[index - 1]);
                      return const Center(child: CircularProgressIndicator());
                    }

                    final PostModel post = controller.myPosts[index];
                    if (index < controller.myPosts.length) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () => Get.to(
                              () => const PostScreen(),
                              arguments: [
                                post.title,
                                post.content,
                                post.postId,
                                post.username,
                                post.timestamp,
                                post.type,
                              ],
                            ),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      //Post Type
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 6,
                                              vertical: 3,
                                            ),
                                            decoration: BoxDecoration(
                                              color: _colorChoice(post.type),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              post.type.toString(),
                                              style: boardTheme
                                                  .textTheme.labelSmall,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              post.title.length > 30
                                                  ? post.title.substring(0, 30)
                                                  : post.title,
                                              style: boardTheme
                                                  .textTheme.titleLarge,
                                              overflow: TextOverflow.clip,
                                              maxLines: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              post.content.length > 32
                                                  ? post.content
                                                      .substring(0, 32)
                                                  : post.content,
                                              style: boardTheme
                                                  .textTheme.titleMedium,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${post.username} ㅣ ${DateFormat('MM-dd hh:mm').format(post.timestamp).toString()}',
                                            style:
                                                boardTheme.textTheme.titleSmall,
                                          ),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                eyeSvg,
                                                height: 14,
                                                width: 14,
                                                fit: BoxFit.scaleDown,
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                  Color(
                                                    0xff757575,
                                                  ),
                                                  BlendMode.srcIn,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                post.viewCounts.toString(),
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xff757575),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              SvgPicture.asset(
                                                commentSvg,
                                                height: 12,
                                                width: 12,
                                                fit: BoxFit.scaleDown,
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                  Color(
                                                    0xff757575,
                                                  ),
                                                  BlendMode.srcIn,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                post.commentCounts.toString(),
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xff757575),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      const Divider()
                                    ],
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: PopupMenuButton(
                                      icon: SvgPicture.asset(
                                        menuSvg,
                                        width: 16,
                                        height: 16,
                                        fit: BoxFit.scaleDown,
                                      ),
                                      itemBuilder: (BuildContext context) =>
                                          <PopupMenuEntry>[
                                        PopupMenuItem(
                                          padding: const EdgeInsets.fromLTRB(
                                              18, 0, 0, 0),
                                          height: 40,
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                trashSvg,
                                                width: 12,
                                                height: 12,
                                                fit: BoxFit.scaleDown,
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              const Text('삭제'),
                                            ],
                                          ),
                                          onTap: () {
                                            Get.find<MyPageController>()
                                                .deletePost(post.postId);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return null;
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
