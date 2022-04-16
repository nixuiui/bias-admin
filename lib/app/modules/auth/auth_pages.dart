import 'package:bias_admin/app/routes/app_pages.dart';
import 'package:get/get.dart';

import 'bindings/auth_binding.dart';
import 'views/login_view.dart';

final authPages = [
  GetPage(
    name: Routes.login,
    page: () => LoginView(),
    binding: AuthBinding(),
    participatesInRootNavigator: true,
    preventDuplicates: true,
  )
];