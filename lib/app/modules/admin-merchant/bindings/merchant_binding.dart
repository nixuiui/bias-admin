import 'package:get/get.dart';

import '../controllers/merchant_controller.dart';


class MerchantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MerchantController>(
      () => MerchantController(),
    );
  }
}
