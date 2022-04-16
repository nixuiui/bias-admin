import 'package:bias_admin/app/modules/auth/auth_pages.dart';
import 'package:bias_admin/app/modules/home/home_pages.dart';
import 'package:bias_admin/app/modules/splash/splash_pages.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = [
    ...splashPages,
    ...authPages,
    ...homePages,
  ];
}
