import 'package:bias_admin/app/modules/user/controllers/user_topup_controller.dart';
import 'package:get/get.dart';

class UserTopupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserTopupController>(
      () => UserTopupController(),
    );
  }
}
