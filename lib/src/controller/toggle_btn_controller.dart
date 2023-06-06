import 'package:get/get.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class ToggleButtonController extends GetxController {
  final List<bool> isSelected = [false, false, false, false].obs;
  RxString selectedType = ''.obs;

  void toggleButton(int index) {
    for (var i = 0; i < isSelected.length; i++) {
      isSelected[i] = i == index;
    }
    switch (index) {
      case 0:
        selectedType.value = '도움 요청';
        break;
      case 1:
        selectedType.value = '정보 공유';
        break;
      case 2:
        selectedType.value = '치료 후기';
        break;
      case 3:
        selectedType.value = '기타';
        break;
      default:
        selectedType.value = '?';
    }
  }
}

Color darken(Color color, [double amount = .05]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}

class CustomToggleButtons extends StatelessWidget {
  final ToggleButtonController controller = Get.put(ToggleButtonController());

  CustomToggleButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: List.generate(
          controller.isSelected.length,
          (index) => buildToggleButton(index),
        ),
      ),
    );
  }

  Widget buildToggleButton(int index) {
    Color _colorChoice(int index) {
      switch (index) {
        // 도움 요청
        case 0:
          return const Color(0xffC50603);

        // 정보공유
        case 1:
          return const Color(0xffFE642E);

        // 치료 후기
        case 2:
          return const Color(0xff00726B);

        // 기타
        case 3:
          return const Color(0xff024B6E);

        default:
          return const Color(0xff378CB1);
      }
    }

    Widget buttonChild;
    switch (index) {
      case 0:
        buttonChild = const Text(
          '도움 요청',
          style: TextStyle(
            fontFamily: 'Yes_Title',
            color: Colors.white,
          ),
        );
        break;
      case 1:
        buttonChild = const Text(
          '정보 공유',
          style: TextStyle(
            fontFamily: 'Yes_Title',
            color: Colors.white,
          ),
        );
        break;
      case 2:
        buttonChild = const Text(
          '치료 후기',
          style: TextStyle(
            fontFamily: 'Yes_Title',
            color: Colors.white,
          ),
        );
        break;
      case 3:
        buttonChild = const Text(
          '기타',
          style: TextStyle(
            fontFamily: 'Yes_Title',
            color: Colors.white,
          ),
        );

        break;
      default:
        buttonChild = const Text('?');
    }

    return Row(
      children: [
        Container(
          child: controller.isSelected[index]
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: darken(_colorChoice(index)),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black87,
                        spreadRadius: 2,
                        inset: true,
                        offset: Offset(1, 2),
                      ),
                      BoxShadow(
                        color: Colors.black87,
                        spreadRadius: 2,
                        inset: true,
                        offset: Offset(1, 1),
                      ),
                      BoxShadow(
                        color: Colors.black38,
                        spreadRadius: 3,
                        blurRadius: 5,
                        inset: true,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () => controller.toggleButton(index),
                    child: buttonChild,
                  ),
                )
              : GestureDetector(
                  onTap: () => controller.toggleButton(index),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: _colorChoice(index),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black87,
                          offset: Offset(2, 2),
                        ),
                        BoxShadow(
                          color: Colors.black87,
                          offset: Offset(3, 3),
                        ),
                      ],
                    ),
                    child: buttonChild,
                  ),
                ),
        ),
        const SizedBox(
          width: 8,
        )
      ],
    );
  }
}
