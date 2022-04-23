import 'package:bias_admin/app/modules/division/controllers/division_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nx_flutter_ui_starter_pack/nx_flutter_ui_starter_pack.dart';

class DivisionFormView extends StatefulWidget {
  
  const DivisionFormView({ 
    Key? key,
  }) : super(key: key);

  @override
  State<DivisionFormView> createState() => _DivisionFormViewState();
}

class _DivisionFormViewState extends State<DivisionFormView> {

  final controller = DivisionController.to;

  @override
  void initState() {
    controller.initForm();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Ubah Profile User',
          )
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NxText.body2('Nama Divisi'),
                      SizedBox(height: 8),
                      NxTextFieldBox(
                        textHint: 'Masukkan nama divisi',
                        controller: controller.nameController,
                        padding: 12,
                        onChanged: (val) => controller.name.value = val,
                        textError: controller.nameError.value,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(12),
              child: Obx(() => NxButton.primary(
                onPressed: controller.isUpdateDivisionValid ? () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  controller.saveDivision();
                } : null,
                isLoading: controller.updatingDivision.value,
                child: NxText(
                  'Simpan',
                  color: Colors.white,
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
  
}