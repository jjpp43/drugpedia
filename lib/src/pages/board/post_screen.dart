import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../controller/auth_controller.dart';
import '../../controller/post_controller.dart';
import '../../controller/report_controller.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../../controller/comment_controller.dart';
import '../../theme/post_text_theme.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  dynamic argumentData = Get.arguments;
  final textController = TextEditingController();
  final reportController = Get.find<ReportController>();
  final currentUserId = Get.find<AuthController>().getCurrentUserId();
  final currentUname = Get.find<AuthController>().getCurrentUserId();

  @override
  void initState() {
    Get.find<CommentController>().getComments(Get.arguments[2]);
    super.initState();
  }

  static const String reportSvg = 'assets/svg/report.svg';

  /// 0 - post.title,
  /// 1 - post.content,
  /// 2 - post.postId,
  /// 3 - post.username,
  /// 4 - post.timestamp,
  /// 5 - post.type,
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //Custom Back button

        // Title
        title: const Text(
          '슬생바생 커뮤니티',
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: IconButton(
              onPressed: () => showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: const Color(0xffFAE9C8),
                      title: Container(
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '신고',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              '신고 사유를 선택해주세요',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ReportButtons(),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xffff5724)
                                        .withOpacity(0.8),
                                  ),
                                  onPressed: () {
                                    Get.find<PostController>().addReport(
                                        argumentData[2],
                                        reportController.selectedType.value);
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor:
                                            Color.fromARGB(255, 90, 80, 54),
                                        duration: Duration(seconds: 1),
                                        content: Text(
                                          '신고 완료',
                                          style: TextStyle(
                                            fontFamily: 'Yangjin',
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    '신고하기',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }),
              icon: Stack(
                children: [
                  Transform.translate(
                    offset: const Offset(0.5, -0.5),
                    child: SvgPicture.asset(
                      reportSvg,
                      fit: BoxFit.scaleDown,
                      height: 22,
                      width: 22,
                      colorFilter: const ColorFilter.mode(
                        Colors.black54,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(-0.5, 0.5),
                    child: SvgPicture.asset(
                      reportSvg,
                      fit: BoxFit.scaleDown,
                      height: 22,
                      width: 22,
                      colorFilter: const ColorFilter.mode(
                        Colors.black54,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(-0.5, -0.5),
                    child: SvgPicture.asset(
                      reportSvg,
                      fit: BoxFit.scaleDown,
                      height: 22,
                      width: 22,
                      colorFilter: const ColorFilter.mode(
                        Colors.black54,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0.5, 0.5),
                    child: SvgPicture.asset(
                      reportSvg,
                      fit: BoxFit.scaleDown,
                      height: 22,
                      width: 22,
                      colorFilter: const ColorFilter.mode(
                        Colors.black54,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(1, 1),
                    child: SvgPicture.asset(
                      reportSvg,
                      fit: BoxFit.scaleDown,
                      height: 22,
                      width: 22,
                      colorFilter: const ColorFilter.mode(
                        Colors.black54,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(1.5, 1.5),
                    child: SvgPicture.asset(
                      reportSvg,
                      fit: BoxFit.scaleDown,
                      height: 22,
                      width: 22,
                      colorFilter: const ColorFilter.mode(
                        Colors.black54,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    reportSvg,
                    fit: BoxFit.scaleDown,
                    height: 22,
                    width: 22,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Display username
                        Text(
                          argumentData[3],
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: postTheme.textTheme.bodySmall,
                        ),

                        // Post timestamp
                        Text(
                          DateFormat('MM-dd hh:mm')
                              .format(argumentData[4])
                              .toString(),
                          style: const TextStyle(
                            color: Color(0xff757575),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    // Post Title
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              argumentData[0],
                              overflow: TextOverflow.clip,
                              maxLines: 3,
                              style: postTheme.textTheme.titleLarge,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    // Post Content
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            argumentData[1],
                            style: postTheme.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),

                    /// Write comment
                    Center(
                      child: TextFormField(
                        controller: textController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 4,
                        maxLength: 300,
                        //글자 위아래 간격 띄우기
                        style: const TextStyle(
                          height: 1.2,
                          fontFamily: 'Yes_Body',
                        ),
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffff5722),
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color(0xffff5722).withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          hintText: '최대 300자',
                          // Save comment
                          suffixIcon: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(
                                24,
                                24,
                              ),
                              foregroundColor: const Color(0xffff5722),
                              backgroundColor: Colors.white.withOpacity(
                                0,
                              ),
                              elevation: 0,
                              shape: const CircleBorder(),
                            ),
                            onPressed: () async {
                              Get.find<CommentController>()
                                  .addComment(
                                argumentData[2],
                                textController.text,
                                currentUserId,
                                currentUname,
                              )
                                  .then(
                                (value) {
                                  FocusScope.of(context).unfocus();
                                  textController.clear();
                                },
                              ).catchError(
                                (error) => print(error),
                              );
                              Get.find<CommentController>()
                                  .getComments(argumentData[2]);
                              // Close the bottom sheet
                            },
                            child: const Icon(
                              Icons.send_rounded,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    GetBuilder<CommentController>(
                      init: Get.find<CommentController>(),
                      builder: (controller) {
                        return Obx(() {
                          if (controller.comments.isEmpty) {
                            return const Center(
                              child: Text('댓글이 없습니다'),
                            );
                          }
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.comments.length,
                            itemBuilder: (context, index) {
                              return Center(
                                child: Column(
                                  children: [
                                    const Divider(),
                                    const SizedBox(height: 4),
                                    //Comment Username & timestamp
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          controller.comments[index].username,
                                          style: postTheme.textTheme.labelLarge,
                                        ),
                                        Text(
                                          DateFormat('MM-dd hh:mm')
                                              .format(controller
                                                  .comments[index].timestamp)
                                              .toString(),
                                          style: postTheme.textTheme.labelSmall,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    // Comment content
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            controller.comments[index].content,
                                            style:
                                                postTheme.textTheme.labelMedium,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                  ],
                                ),
                              );
                            },
                          );
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
