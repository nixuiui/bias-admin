import 'package:bias_admin/app/modules/admin-merchant/controllers/merchant_controller.dart';
import 'package:bias_admin/app/routes/app_pages.dart';
import 'package:bias_admin/helpers/general.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nx_flutter_ui_starter_pack/nx_flutter_ui_starter_pack.dart';

class MerchantDetailView extends StatefulWidget {
  
  const MerchantDetailView({ 
    Key? key,
  }) : super(key: key);

  @override
  State<MerchantDetailView> createState() => _MerchantDetailViewState();
}

class _MerchantDetailViewState extends State<MerchantDetailView> {

  final controller = MerchantController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Detail Merchant',
        )
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildInformationUser(),
          SizedBox(height: 24),
          _buildButtonAction(
            icon: Icon(Icons.edit, color: Colors.grey[700]),
            title: 'Ubah User',
            onTap: () => Get.toNamed(Routes.userUpdate)
          ),
          SizedBox(height: 24),
          _buildButtonAction(
            icon: Icon(Icons.lock, color: Colors.grey[700]),
            title: 'Ubah Password',
            onTap: () => Get.toNamed(Routes.merchantUpdatePassword)
          ),
          SizedBox(height: 24),
          _buildButtonAction(
            icon: Icon(Icons.monetization_on, color: Colors.grey[700]),
            title: 'Tarik Saldo',
            onTap: () => Get.toNamed(Routes.merchantWithdraw)
          ),
        ],
      ),
    );
  }

  Widget _buildButtonAction({
    Widget? icon,
    String title = '',
    VoidCallback? onTap
  }) {
    return NxBox(
      padding: EdgeInsets.all(16),
      color: Colors.grey[50],
      borderRadius: 12,
      onPressed: onTap?.call,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 12),
            child: icon!
          ),
          Expanded(
            child: NxText(
              title,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey[700])
        ],
      ),
    );
  }

  Widget _buildInformationUser() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => _buildInfo('Nama', controller.merchant.value?.name ?? '')),
        SizedBox(height: 12),
        Obx(() => _buildInfo('Username', controller.merchant.value?.userName ?? '')),
        SizedBox(height: 12),
        Obx(() => _buildInfo('No HP', controller.merchant.value?.phoneNumber ?? '')),
        SizedBox(height: 12),
        Obx(() => _buildInfo('Saldo', rupiah(controller.merchant.value?.balance))),
        SizedBox(height: 12),
        Obx(() => _buildInfo('Alamat', controller.merchant.value?.address ?? '')),
      ],
    );
  }

  Widget _buildInfo(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NxText.body2(label),
        NxText.subtitle(value),
      ],
    );
  }
}