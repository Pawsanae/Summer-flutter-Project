import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var notificationCount = 3.obs;
  var scheduleItems = <ScheduleItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadScheduleItems();
  }

  void loadScheduleItems() {
    scheduleItems.value = [
      ScheduleItem(
        id: '1',
        title: 'คณิตศาสตร์ ม.3/1',
        subtitle: '08:00 - 09:00 น.',
        color: Colors.blue,
        type: 'class',
      ),
      ScheduleItem(
        id: '2',
        title: 'วิทยาศาสตร์ ม.3/1',
        subtitle: '09:00 - 10:00 น.',
        color: Colors.green,
        type: 'class',
      ),
      ScheduleItem(
        id: '3',
        title: 'ภาษาอังกฤษ ม.3/1',
        subtitle: '10:00 - 11:00 น.',
        color: Colors.orange,
        type: 'class',
      ),
      ScheduleItem(
        id: '4',
        title: 'การบ้านคณิตศาสตร์',
        subtitle: 'ครบกำหนด: วันนี้',
        color: Colors.red,
        type: 'homework',
      ),
      ScheduleItem(
        id: '5',
        title: 'ประชุมครู',
        subtitle: '14:00 - 15:00 น.',
        color: Colors.purple,
        type: 'meeting',
      ),
    ];
  }

  void onNotificationTap() {
    Get.snackbar(
      'แจ้งเตือน',
      'คุณมีการแจ้งเตือน ${notificationCount.value} รายการ',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
    );
  }

  void onItemTap(ScheduleItem item) {
    Get.dialog(
      AlertDialog(
        title: Text(item.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('เวลา: ${item.subtitle}'),
            const SizedBox(height: 8),
            Text('ประเภท: ${_getTypeText(item.type)}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('ปิด'),
          ),
        ],
      ),
    );
  }

  String _getTypeText(String type) {
    switch (type) {
      case 'class':
        return 'คาบเรียน';
      case 'homework':
        return 'การบ้าน';
      case 'meeting':
        return 'ประชุม';
      default:
        return 'อื่นๆ';
    }
  }
}

class ScheduleItem {
  final String id;
  final String title;
  final String subtitle;
  final Color color;
  final String type;

  ScheduleItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.type,
  });
}