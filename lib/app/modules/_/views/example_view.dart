import 'package:bias_admin/app/modules/_/controllers/example_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ReceiptOrderFormView extends GetView<ExampleController> {

  const ReceiptOrderFormView({ 
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Example'),
      ),
      body: Text('Body'),
    );
  }
}