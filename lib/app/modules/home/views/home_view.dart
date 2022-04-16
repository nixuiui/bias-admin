import 'package:bias_admin/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nx_flutter_ui_starter_pack/nx_flutter_ui_starter_pack.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.init();
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Merchat'),
            leading: Icon(Icons.shopping_bag),
          ),
          ListTile(
            title: Text('Order'),
            leading: Icon(Icons.shopping_bag),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(12),
        child: NxButton.primary(
          onPressed: () {},
          child: NxText(
            'Logout', 
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}