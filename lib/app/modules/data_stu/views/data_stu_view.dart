import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/data_stu_controller.dart';

class DataStuView extends GetView<DataStuController> {
  const DataStuView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DataStuView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DataStuView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
