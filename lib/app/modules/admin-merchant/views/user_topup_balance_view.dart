import 'package:bias_admin/app/modules/user/controllers/user_controller.dart';
import 'package:bias_admin/helpers/general.dart';
import 'package:bias_admin/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nx_flutter_ui_starter_pack/nx_flutter_ui_starter_pack.dart';

class UserTopupBalanceView extends StatefulWidget {
  
  const UserTopupBalanceView({ 
    Key? key,
  }) : super(key: key);

  @override
  State<UserTopupBalanceView> createState() => _UserTopupBalanceViewState();
}

class _UserTopupBalanceViewState extends State<UserTopupBalanceView> {

  final controller = UserController.to;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Topup Saldo',
          )
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  _buildCurrentBalance(),
                  SizedBox(height: 16),
                  NxBox(
                    padding: EdgeInsets.all(16),
                    borderColor: Colors.grey[300],
                    borderRadius: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NxText.lead1('Topup Saldo'),
                        SizedBox(height: 16),
                        NxText.body2('Nominal'),
                        SizedBox(height: 8),
                        NxTextFieldBox(
                          textHint: '0',
                          inputType: TextInputType.number,
                          controller: controller.balanceController,
                          padding: 12,
                          onChanged: (val) => controller.balance.value = int.tryParse(val),
                        ),
                        SizedBox(height: 16),
                        NxText.body2('Catatan'),
                        SizedBox(height: 8),
                        NxTextFieldBox(
                          textHint: 'Tulis catatan disini',
                          controller: controller.balanceNoteController,
                          padding: 12,
                          onChanged: (val) => controller.balanceNote.value = val,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(12),
              child: Obx(() => NxButton.primary(
                onPressed: controller.isUpdateBalanceValid ? () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  controller.updateBalanace();
                } : null,
                isLoading: controller.updatingBalance.value,
                child: NxText(
                  'TOP UP',
                  color: Colors.white,
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentBalance() {
    return NxBox(
      borderColor: AppColors.primary,
      color: AppColors.primary,
      padding: EdgeInsets.all(16),
      borderRadius: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NxText(
            'Saldo saat ini', 
            color: Colors.white,
            fontSize: 12,
          ),
          SizedBox(height: 6),
          SizedBox(height: 6),
          Obx(() => NxText(
            rupiah(controller.user.value?.balance ?? 0),
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          )),
        ],
      ),
    );
  }
}