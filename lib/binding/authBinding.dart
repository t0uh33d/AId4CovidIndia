import 'package:get/get.dart';
import 'package:oxygenforcovid/controllers/authController.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
