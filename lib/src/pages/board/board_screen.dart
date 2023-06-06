import 'package:flutter/material.dart';
import 'post_screen.dart';
import '../../controller/post_controller.dart';
import 'package:get/get.dart';
import '../../models/post_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../theme/board_text_theme.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({super.key});

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  static const String commentSvg = 'assets/svg/comment.svg';
  static const String eyeSvg = 'assets/svg/eye.svg';
  static const String loadingSvg = 'assets/svg/loading.svg';
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    Get.find<PostController>().getPosts();
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
        setState(() {
          isLoading = true;
        });

        final List<PostModel> posts = Get.find<PostController>().posts;
        if (posts.isNotEmpty) {
          final PostModel lastPost = posts.last;
          Get.find<PostController>().getMorePosts(lastPost);
          setState(() {
            isLoading = false;
          });
        }
      }
    }
  }

  Color _colorChoice(String type) {
    switch (type) {
      case '도움 요청':
        return const Color(0xffC50603);

      case '정보 공유':
        return const Color(0xffFE642E);

      case '치료 후기':
        return const Color(0xff00726B);

      case '기타':
        return const Color(0xff024B6E);

      default:
        return const Color(0xff378CB1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: GetBuilder<PostController>(
        init: Get.find<PostController>(),
        builder: (controller) {
          return Obx(
            () {
              if (controller.posts.isEmpty) {
                return const Center(
                  child: Text('No posts available'),
                );
              }

              return CustomRefreshIndicator(
                builder: MaterialIndicatorDelegate(
                  builder: (context, controller) {
                    return Ink(
                      width: 22,
                      height: 22,
                      child: SvgPicture.asset(
                        loadingSvg,
                        width: 22,
                        height: 22,
                      ),
                    );
                  },
                ),
                onRefresh: () async {
                  await Get.find<PostController>().getPosts();
                },
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: controller.posts.length,
                  itemBuilder: (context, index) {
                    if (index == controller.posts.length) {
                      controller.getMorePosts(controller.posts[index - 1]);
                      return const Center(child: CircularProgressIndicator());
                    }

                    final PostModel post = controller.posts[index];
                    if (index < controller.posts.length) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(
                                () => const PostScreen(),
                                arguments: [
                                  post.title,
                                  post.content,
                                  post.postId,
                                  post.username,
                                  post.timestamp,
                                  post.type,
                                ],
                              );
                              Get.find<PostController>()
                                  .incrementViewCountByPostId(post.postId);
                            },
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 4,
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
                                          style:
                                              boardTheme.textTheme.labelSmall,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),

                                  //Post title
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          post.title,
                                          style:
                                              boardTheme.textTheme.titleLarge,
                                          overflow: TextOverflow.clip,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  //Post Content
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          post.content,
                                          style:
                                              boardTheme.textTheme.titleMedium,
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
                                    children: [
                                      Text(
                                        '${post.username} ㅣ ${DateFormat('MM-dd hh:mm').format(post.timestamp).toString()}',
                                        style: boardTheme.textTheme.titleSmall,
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            eyeSvg,
                                            height: 14,
                                            width: 14,
                                            fit: BoxFit.scaleDown,
                                            colorFilter: const ColorFilter.mode(
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
                                            colorFilter: const ColorFilter.mode(
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
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  const Divider(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return null;
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
