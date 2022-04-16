import 'package:bias_admin/app/widgets/dialogs/dialog.dart';
import 'package:get/get.dart';


class DialogHelper {

  static showDialogError({
    String? title, String? description
  }) {
    Get.dialog(
      DialogAlert.error(
        title: title,
        description: description,
      ),
    );
  }

}