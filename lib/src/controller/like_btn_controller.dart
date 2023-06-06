import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LikeController extends GetxController {
  RxBool isLiked = false.obs;
  RxBool isButtonEnabled = true.obs;

  void toggleLike() {
    if (isButtonEnabled.value) {
      isLiked.toggle();
      isButtonEnabled.value = false;
      Future.delayed(
        const Duration(seconds: 1),
        () {
          isButtonEnabled.value = true;
        },
      );
    }
  }
}

class LikeButton extends StatelessWidget {
  final LikeController _likeController = Get.put(LikeController());

  LikeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          ElevatedButton(
              style: _likeController.isLiked.value
                  ? ElevatedButton.styleFrom(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(
                          color: Color(0xffD4D4D4),
                        ),
                      ),
                      backgroundColor: const Color(0xffff5724).withOpacity(0.9),
                      foregroundColor: Colors.white,
                    )
                  : ElevatedButton.styleFrom(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(
                          color: Color(0xffD4D4D4),
                        ),
                      ),
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xff252525),
                    ),
              onPressed: () {
                _likeController.toggleLike();
              },
              child: const Icon(Icons.arrow_upward_outlined)),
        ],
      ),
    );
  }
}
