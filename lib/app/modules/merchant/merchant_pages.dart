import 'package:bias_admin/app/routes/app_pages.dart';
import 'package:get/get.dart';

import 'bindings/merchant_history_withdraw_binding.dart';
import 'views/merchant_history_withdraw_view.dart';

final merchantPages = [
  GetPage(
    name: Routes.merchatHistoryWithdraw,
    page: () => MerchantHistoryWithdrawView(),
    binding: MerchantHistoryWithdrawBinding(),
    participatesInRootNavigator: true,
    preventDuplicates: true,
  )
];