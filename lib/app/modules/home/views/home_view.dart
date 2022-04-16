import 'package:bias_admin/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

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
    );
  }
}