import 'package:bias_admin/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nx_flutter_ui_starter_pack/nx_flutter_ui_starter_pack.dart';

class UserMenuView extends StatelessWidget {
  
  const UserMenuView({ 
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'User',
        )
      ),
      body: ListView(
        children: [
          ListTile(
            title: NxText('Riwayat Top Up'),
            onTap: () => Get.toNamed(Routes.userTopupHistory),
            trailing: Icon(Icons.chevron_right),
          ),
          Divider(),
          ListTile(
            title: NxText('List User'),
            onTap: () => Get.toNamed(Routes.user),
            trailing: Icon(Icons.chevron_right),
          ),
          Divider(),
        ],
      ),
    );
  }

}