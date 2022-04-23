import 'package:bias_admin/app/modules/admin-merchant/bindings/merchant_history_withdraw_binding.dart';
import 'package:bias_admin/app/modules/admin-merchant/views/merchant_detail_view.dart';
import 'package:bias_admin/app/modules/admin-merchant/views/merchant_history_withdraw_view.dart';
import 'package:bias_admin/app/modules/admin-merchant/views/merchant_menu_view.dart';
import 'package:bias_admin/app/modules/admin-merchant/views/merchant_update_password_view.dart';
import 'package:bias_admin/app/modules/admin-merchant/views/merchant_withdraw_view.dart';
import 'package:bias_admin/app/modules/user/views/user_update_view.dart';
import 'package:bias_admin/app/routes/app_pages.dart';
import 'package:get/get.dart';

import 'bindings/merchant_binding.dart';
import 'views/merchant_view.dart';

final adminMerchantPages = [
  GetPage(
    name: Routes.merchantMenu,
    page: () => MerchantMenuView(),
    participatesInRootNavigator: true,
    preventDuplicates: true,
  ),
  GetPage(
    name: Routes.merchant,
    page: () => MerchantView(),
    binding: MerchantBinding(),
    participatesInRootNavigator: true,
    preventDuplicates: true,
  ),
  GetPage(
    name: Routes.merchantWithdrawHistory,
    page: () => MerchantHistoryWithdrawView(),
    binding: MerchantHistoryWithdrawBinding(),
    participatesInRootNavigator: true,
    preventDuplicates: true,
  ),
  GetPage(
    name: Routes.merchantDetail,
    page: () => MerchantDetailView(),
    participatesInRootNavigator: true,
    preventDuplicates: true,
  ),
  GetPage(
    name: Routes.merchantWithdraw,
    page: () => MerchantWithdrawView(),
    participatesInRootNavigator: true,
    preventDuplicates: true,
  ),
  GetPage(
    name: Routes.merchantUpdatePassword,
    page: () => MerchantUpdatePasswordView(),
    participatesInRootNavigator: true,
    preventDuplicates: true,
  ),
  GetPage(
    name: Routes.userUpdate,
    page: () => UserUpdateView(),
    participatesInRootNavigator: true,
    preventDuplicates: true,
  ),
];