import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportController extends GetxController {
  final List<bool> isSelected = [false, false, false].obs;
  RxString selectedType = ''.obs;

  void toggleButton(int index) {
    for (var i = 0; i < isSelected.length; i++) {
      isSelected[i] = i == index;
    }
    switch (index) {
      case 0:
        selectedType.value = '스팸';
        break;
      case 1:
        selectedType.value = '폭력성';
        break;
      case 2:
        selectedType.value = '거짓 정보';
        break;
      default:
        selectedType.value = '?';
    }
  }
}

class ReportButtons extends StatelessWidget {
  final ReportController controller = Get.put(ReportController());

  ReportButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: List.generate(
          controller.isSelected.length,
          (index) => buildReportButton(index),
        ),
      ),
    );
  }

  Widget buildReportButton(int index) {
    Widget buttonChild;
    switch (index) {
      case 0:
        buttonChild = const Text(
          '스팸',
          style: TextStyle(
            fontFamily: 'Yes_Body',
          ),
        );
        break;
      case 1:
        buttonChild = const Text(
          '폭력성',
          style: TextStyle(
            fontFamily: 'Yes_Body',
          ),
        );
        break;
      case 2:
        buttonChild = const Text(
          '거짓 정보',
          style: TextStyle(
            fontFamily: 'Yes_Body',
          ),
        );
        break;

      default:
        buttonChild = const Text('');
    }

    return Row(
      children: [
        ElevatedButton(
          style: controller.isSelected[index]
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
            controller.toggleButton(index);
          },
          child: buttonChild,
        ),
        const SizedBox(
          width: 4,
        )
      ],
    );
  }
}
