import 'package:get/get.dart';

import '../controllers/merchant_history_withdraw_controller.dart';

class MerchantHistoryWithdrawBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MerchantHistoryWithDrawController>(
      () => MerchantHistoryWithDrawController(),
    );
  }
}
