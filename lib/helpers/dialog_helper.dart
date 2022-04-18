import 'package:bias_admin/app/widgets/dialogs/dialog.dart';
import 'package:get/get.dart';


class DialogHelper {

  static showDialogError({
    String? title, 
    String? description
  }) async {
    await Get.dialog(
      DialogAlert.error(
        title: title,
        description: description,
      ),
    );
  }
  
  static showDialogSuccess({
    String? title, 
    String? description
  }) async {
    await Get.dialog(
      DialogAlert.success(
        title: title,
        description: description,
      ),
    );
  }

}