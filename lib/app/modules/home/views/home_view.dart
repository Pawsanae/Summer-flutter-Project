import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

// Widget หลัก
class ScheduleApp extends StatelessWidget {
  const ScheduleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'การแจ้งเตือน',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Kanit', // ใช้ฟอนต์ไทย
      ),
      home: const ScheduleHomePage(),
    );
  }
}

// หน้าหลัก
class ScheduleHomePage extends StatelessWidget {
  const ScheduleHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ScheduleController controller = Get.put(ScheduleController());

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            // ส่วนหัว
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'การแจ้งเตือน',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Obx(() => IconButton(
                    onPressed: controller.onNotificationTap,
                    icon: Stack(
                      children: [
                        const Icon(Icons.notifications, size: 28),
                        if (controller.notificationCount.value > 0)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '${controller.notificationCount.value}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
            

            Expanded(
              child: Obx(() => ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: controller.scheduleItems.length,
                itemBuilder: (context, index) {
                  final item = controller.scheduleItems[index];
                  return ScheduleCard(
                    item: item,
                    onTap: () => controller.onItemTap(item),
                  );
                },
              )),
            ),
            
            // Bottom Navigation Bar
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.brown[400],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildBottomNavItem(Icons.person, false),
                  _buildBottomNavItem(Icons.notifications, true),
                  _buildBottomNavItem(Icons.assignment, false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, bool isActive) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isActive ? Colors.orange : Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 28,
      ),
    );
  }
}

// Component สำหรับ Card แต่ละรายการ
class ScheduleCard extends StatelessWidget {
  final ScheduleItem item;
  final VoidCallback onTap;

  const ScheduleCard({
  super.key,
  required this.item,
  required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        color: item.color,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // ไอคอน
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getIconForItem(item),
                    color: item.color,
                    size: 24,
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // ข้อความ
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.subtitle,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getIconForItem(ScheduleItem item) {
    if (item.title.contains('คณิตศาสตร์')) {
      return Icons.calculate;
    } else if (item.title.contains('วิทยาศาสตร์')) {
      return Icons.science;
    } else if (item.title.contains('ภาษาอังกฤษ')) {
      return Icons.language;
    } else if (item.type == 'class') {
      return Icons.school;
    } else {
      return Icons.assignment;
    }
  }
}

