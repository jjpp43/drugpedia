import 'package:flutter/material.dart';
import '../../theme/board_text_theme.dart';
import '../../controller/mypage_controller.dart';
import 'package:get/get.dart';
import '../../models/comment_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class MyPageCommentScreen extends StatefulWidget {
  const MyPageCommentScreen({Key? key}) : super(key: key);

  @override
  State<MyPageCommentScreen> createState() => _MyPageCommentScreenState();
}

class _MyPageCommentScreenState extends State<MyPageCommentScreen> {
  static const String commentSvg = 'assets/svg/comment.svg';
  static const String menuSvg = 'assets/svg/menu-dots-vertical.svg';
  static const String trashSvg = 'assets/svg/trash.svg';
  static const String backButtonSvg = 'assets/svg/angle-left.svg';

  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    Get.find<MyPageController>().getCommentsByUserId();
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
        final List<CommentModel> comments =
            Get.find<MyPageController>().comments;
        if (comments.isNotEmpty) {
          final CommentModel lastComment = comments.last;
          Get.find<MyPageController>().getMoreCommentsByUserId(lastComment);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '내 댓글',
          style: TextStyle(
            letterSpacing: 3,
            fontSize: 24,
            fontFamily: 'Yangjin',
          ),
        ),
        centerTitle: true,
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
                if (controller.comments.isEmpty) {
                  return const Center(
                    child: Text('No comments available'),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  controller: _scrollController,
                  itemCount: controller.comments.length,
                  itemBuilder: (context, index) {
                    if (index == controller.comments.length) {
                      controller.getMoreCommentsByUserId(
                          controller.comments[index - 1]);
                      return const Center(child: CircularProgressIndicator());
                    }

                    final CommentModel comment = controller.comments[index];
                    if (index < controller.comments.length) {
                      return Column(
                        children: [
                          GestureDetector(
                            // onTap: () => Get.to(
                            //   () => const PostScreen(),
                            //   arguments: [

                            //     comment.content,
                            //     comment.username,
                            //     comment.timestamp.toString(),
                            //   ],
                            // ),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              comment.content.length > 25
                                                  ? comment.content
                                                      .substring(0, 25)
                                                  : comment.content,
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
                                            '${comment.username} ㅣ ${DateFormat('MM-dd hh:mm').format(comment.timestamp).toString()}',
                                            style:
                                                boardTheme.textTheme.titleSmall,
                                          ),
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
                                            controller.deleteComment(
                                                comment.commentId);
                                            controller.getCommentsByUserId();
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
