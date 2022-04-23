import 'package:bias_admin/app/modules/admin-merchant/controllers/merchant_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nx_flutter_ui_starter_pack/nx_flutter_ui_starter_pack.dart';

class MerchantUpdateView extends StatefulWidget {
  
  const MerchantUpdateView({ 
    Key? key,
  }) : super(key: key);

  @override
  State<MerchantUpdateView> createState() => _MerchantUpdateViewState();
}

class _MerchantUpdateViewState extends State<MerchantUpdateView> {

  final controller = MerchantController.to;

  @override
  void initState() {
    controller.initUpdateUserForm();
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
            'Ubah Merchant',
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
                      NxText.body2('Nama Lengkap'),
                      SizedBox(height: 8),
                      NxTextFieldBox(
                        textHint: 'Masukkan nama lengkap',
                        controller: controller.nameController,
                        padding: 12,
                        onChanged: (val) {
                          controller.name.value = val;
                          controller.nameError.value = '';
                        },
                        textError: controller.nameError.value,
                      ),
                      SizedBox(height: 16),
                      NxText.body2('Alamat'),
                      SizedBox(height: 8),
                      NxTextFieldBox(
                        textHint: 'Masukkan nama alamat',
                        controller: controller.addressController,
                        padding: 12,
                        onChanged: (val) {
                          controller.address.value = val;
                          controller.addressError.value = '';
                        },
                        textError: controller.addressError.value,
                      ),
                      SizedBox(height: 16),
                      NxText.body2('No HP'),
                      SizedBox(height: 8),
                      NxTextFieldBox(
                        textHint: '08xxx',
                        controller: controller.phoneNumberController,
                        inputType: TextInputType.phone,
                        padding: 12,
                        onChanged: (val) {
                          controller.phoneNumber.value = val;
                          controller.phoneNumberError.value = '';
                        },
                        textError: controller.phoneNumberError.value,
                      ),
                      SizedBox(height: 16),
                      NxText.body2('Username'),
                      SizedBox(height: 8),
                      NxTextFieldBox(
                        textHint: 'Masukkan username',
                        controller: controller.usernameController,
                        padding: 12,
                        onChanged: (val) {
                          controller.username.value = val;
                          controller.usernameError.value = '';
                        },
                        textError: controller.usernameError.value,
                      ),
                      SizedBox(height: 16),
                      if(controller.merchant.value == null) NxText.body2('Password'),
                      if(controller.merchant.value == null) SizedBox(height: 8),
                      if(controller.merchant.value == null) NxTextFieldBox(
                        textHint: 'Masukkan password',
                        controller: controller.passwordController,
                        padding: 12,
                        isObsecure: true,
                        onChanged: (val) {
                          controller.password.value = val;
                          controller.passwordError.value = '';
                        },
                        textError: controller.passwordError.value,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(12),
              child: Obx(() => NxButton.primary(
                onPressed: controller.isUpdateUserValid ? () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  controller.saveMerchant();
                } : null,
                isLoading: controller.updatingUser.value,
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