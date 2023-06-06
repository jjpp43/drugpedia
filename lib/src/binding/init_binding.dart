import 'package:get/get.dart';
import '../controller/auth_controller.dart';
import '../controller/bottom_nav_controller.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      BottomNavController(),
      permanent: true,
    );
    Get.lazyPut(
      () => AuthController(),
      fenix: true,
    );
  }
}
