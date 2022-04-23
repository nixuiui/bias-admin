import 'package:bias_admin/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nx_flutter_ui_starter_pack/nx_flutter_ui_starter_pack.dart';

class MerchantMenuView extends StatelessWidget {
  
  const MerchantMenuView({ 
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Merchant',
        )
      ),
      body: ListView(
        children: [
          ListTile(
            title: NxText('Riwayat Withdraw'),
            onTap: () => Get.toNamed(Routes.merchantWithdrawHistory),
            trailing: Icon(Icons.chevron_right),
          ),
          Divider(),
          ListTile(
            title: NxText('List Merchant'),
            onTap: () => Get.toNamed(Routes.merchant),
            trailing: Icon(Icons.chevron_right),
          ),
          Divider(),
        ],
      ),
    );
  }

}