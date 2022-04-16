import 'package:bias_admin/app/modules/home/controllers/home_controller.dart';
import 'package:bias_admin/services/auth_service.dart';
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
        title: Text('Home'),
      ),
      body: Text('aaa'),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16),
        child: NxButton.primary(
          onPressed: () => AuthService.to.logout(),
          child: NxText('Log Out', color: Colors.white),
        ),
      ),
    );
  }
}