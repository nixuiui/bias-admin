import 'package:bias_admin/app/modules/admin-merchant/admin_merchant_pages.dart';
import 'package:bias_admin/app/modules/auth/auth_pages.dart';
import 'package:bias_admin/app/modules/division/division_pages.dart';
import 'package:bias_admin/app/modules/home/home_pages.dart';
import 'package:bias_admin/app/modules/merchant/merchant_pages.dart';
import 'package:bias_admin/app/modules/order/order_pages.dart';
import 'package:bias_admin/app/modules/splash/splash_pages.dart';
import 'package:bias_admin/app/modules/user/user_pages.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = [
    ...splashPages,
    ...authPages,
    ...homePages,
    ...orderPages,
    ...merchantPages,
    ...userPages,
    ...divisionPages,
    ...adminMerchantPages,
  ];
}
