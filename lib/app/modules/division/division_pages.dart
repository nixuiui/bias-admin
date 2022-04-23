import 'package:bias_admin/app/modules/division/bindings/user_binding.dart';
import 'package:bias_admin/app/modules/division/views/division_form_view.dart';
import 'package:bias_admin/app/routes/app_pages.dart';
import 'package:get/get.dart';

import 'views/division_view.dart';

final divisionPages = [
  GetPage(
    name: Routes.division,
    page: () => DivisionView(),
    binding: DivisionBinding(),
    participatesInRootNavigator: true,
    preventDuplicates: true,
  ),
  GetPage(
    name: Routes.divisionForm,
    page: () => DivisionFormView(),
    participatesInRootNavigator: true,
    preventDuplicates: true,
  ),
];