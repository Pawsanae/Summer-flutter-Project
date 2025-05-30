import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ScheduleItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String type; // 'class' หรือ 'assignment'

  ScheduleItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.type,
  });
}
class HomeController extends GetxController {
  final count = 0.obs;
  
  // ประกาศ ScheduleController ที่นี่
  late ScheduleController scheduleController;

  @override
  void onInit() {
    super.onInit();
    // Initialize ScheduleController
    scheduleController = Get.put(ScheduleController());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Methods สำหรับ HomeController
  void increment() {
    count.value++;
  }

  void decrement() {
    count.value--;
  }
}
// Controller สำหรับจัดการ state ด้วย GetX
class ScheduleController extends GetxController {
  // Observable list ของรายการ
  final scheduleItems = <ScheduleItem>[].obs;
  
  // Observable สำหรับ notification count
  final notificationCount = 1.obs;

  @override
  void onInit() {
    super.onInit();
    loadScheduleData();
  }

  void loadScheduleData() {
    scheduleItems.value = [
      ScheduleItem(
        title: 'ด.ช. อนพัทร์ สว่างศรี',
        subtitle: 'เข้าใจเรียนเวลา 07.59 น.',
        icon: Icons.school,
        color: const Color(0xFF7B68EE),
        type: 'class',
      ),
      ScheduleItem(
        title: 'วิชาคณิตศาสตร์ ป.2',
        subtitle: 'อีก 10 นาที ถึงคาบเรียน',
        icon: Icons.calculate,
        color: const Color(0xFFFF69B4),
        type: 'assignment',
      ),
      ScheduleItem(
        title: 'ด.ช. กรรณิการ์ เอี่ยงอวน',
        subtitle: 'เข้าใจเรียนเวลา 07.30 น.',
        icon: Icons.school,
        color: const Color(0xFF7B68EE),
        type: 'class',
      ),
      ScheduleItem(
        title: 'วิชาวิทยาศาสตร์ ป.1',
        subtitle: 'กำหนดส่งการบ้านภายใน 16.00 น.',
        icon: Icons.science,
        color: const Color(0xFFFF69B4),
        type: 'assignment',
      ),
      ScheduleItem(
        title: 'ด.ญ. อัจจนา อนทรูป',
        subtitle: 'เข้าใจเรียนเวลา 06.30 น.',
        icon: Icons.school,
        color: const Color(0xFF7B68EE),
        type: 'class',
      ),
      ScheduleItem(
        title: 'วิชาภาษาอังกฤษ ป.2',
        subtitle: 'หมดเวลาส่งการบ้าน',
        icon: Icons.language,
        color: const Color(0xFFFF69B4),
        type: 'assignment',
      ),
    ];
  }

  void onItemTap(ScheduleItem item) {
    Get.snackbar(
      'เลือกรายการ',
      item.title,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: item.color,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  void onNotificationTap() {
    Get.dialog(
      AlertDialog(
        title: const Text('แจ้งเตือน'),
        content: Text('คุณมีแจ้งเตือน ${notificationCount.value} รายการ'),
        actions: [
          TextButton(
            onPressed: () {
              notificationCount.value = 0;
              Get.back();
            },
            child: const Text('ตกลง'),
          ),
        ],
      ),
    );
  }
}
