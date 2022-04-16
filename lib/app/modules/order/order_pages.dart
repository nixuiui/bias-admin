import 'package:bias_admin/app/routes/app_pages.dart';
import 'package:get/get.dart';

import 'bindings/order_binding.dart';
import 'views/order_view.dart';

final orderPages = [
  GetPage(
    name: Routes.order,
    page: () => OrderView(),
    binding: OrderBinding(),
    participatesInRootNavigator: true,
    preventDuplicates: true,
  )
];