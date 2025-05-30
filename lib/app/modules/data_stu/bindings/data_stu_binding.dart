import 'package:get/get.dart';
import '../controllers/data_stu_controller.dart';

class DataStuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataStuController>(
      () => DataStuController(),
    );
  }
}