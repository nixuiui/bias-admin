import 'package:bias_admin/app/modules/admin-merchant/controllers/merchant_controller.dart';
import 'package:bias_admin/helpers/general.dart';
import 'package:bias_admin/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nx_flutter_ui_starter_pack/nx_flutter_ui_starter_pack.dart';

class MerchantWithdrawView extends StatefulWidget {
  
  const MerchantWithdrawView({ 
    Key? key,
  }) : super(key: key);

  @override
  State<MerchantWithdrawView> createState() => _MerchantWithdrawViewState();
}

class _MerchantWithdrawViewState extends State<MerchantWithdrawView> {

  final controller = MerchantController.to;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Tarik Saldo',
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
                        NxText.lead1('Tarik Saldo'),
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
                  controller.withdraw();
                } : null,
                isLoading: controller.updatingBalance.value,
                child: NxText(
                  'TARIK SALDO',
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
            rupiah(controller.merchant.value?.balance ?? 0),
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          )),
        ],
      ),
    );
  }
}