import 'package:bias_admin/app/modules/_/controllers/example_controller.dart';
import 'package:get/get.dart';

class ExampleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExampleController>(
      () => ExampleController(),
    );
  }
}
