import 'package:get/get.dart';

enum PageName { HOME, BOARD, MYPAGE }

class BottomNavController extends GetxController {
  RxInt pageIndex = 0.obs;
  String? title = '슬생바생';
  List<int> bottomHistory = [0];
  RxDouble turns = 0.0.obs;

  void openFab() {
    turns.value = 0.25;
  }

  void closeFab() {
    turns.value = 0.0;
  }

  void changeBottomNav(int value, {bool hasGesture = true}) {
    var page = PageName.values[value];
    pageIndex(value);
    switch (page) {
      case PageName.HOME:
        title = '슬생바생 마약사전';
        _changePage(value, hasGesture: hasGesture);
      case PageName.BOARD:
        title = '슬생바생 커뮤니티';
        _changePage(value, hasGesture: hasGesture);
      case PageName.MYPAGE:
        title = '마이페이지';
        _changePage(value, hasGesture: hasGesture);
        break;
      default:
    }
  }

  void _changePage(int value, {bool hasGesture = true}) {
    pageIndex(value);
    if (!hasGesture) return;
    if (bottomHistory.contains(value)) {
      bottomHistory.remove(value);
    }
    bottomHistory.add(value);
    print(bottomHistory);
  }

  Future<bool> willPopAction() async {
    if (bottomHistory.length == 1) {
      return true;
    } else {
      bottomHistory.removeLast();
      var index = bottomHistory.last;
      changeBottomNav(index, hasGesture: false);
      return false;
    }
  }
}
