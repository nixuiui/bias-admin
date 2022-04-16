import 'package:bias_admin/app/modules/user/bindings/user_topup_binding.dart';
import 'package:bias_admin/app/modules/user/views/user_menu_view.dart';
import 'package:bias_admin/app/modules/user/views/user_topup_view.dart';
import 'package:bias_admin/app/routes/app_pages.dart';
import 'package:get/get.dart';

import 'bindings/user_binding.dart';
import 'views/user_view.dart';

final userPages = [
  GetPage(
    name: Routes.userMenu,
    page: () => UserMenuView(),
    participatesInRootNavigator: true,
    preventDuplicates: true,
  ),
  GetPage(
    name: Routes.user,
    page: () => UserView(),
    binding: UserBinding(),
    participatesInRootNavigator: true,
    preventDuplicates: true,
  ),
  GetPage(
    name: Routes.userTopupHistory,
    page: () => UserTopupView(),
    binding: UserTopupBinding(),
    participatesInRootNavigator: true,
    preventDuplicates: true,
  ),
];