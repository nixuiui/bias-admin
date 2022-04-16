import 'package:bias_admin/app/routes/app_pages.dart';
import 'package:get/get.dart';

import 'bindings/splash_binding.dart';
import 'views/splash_view.dart';

final splashPages = [
  GetPage(
    name: Routes.splash,
    page: () => SplashView(),
    binding: SplashBinding(),
    participatesInRootNavigator: true,
    preventDuplicates: true,
  )
];