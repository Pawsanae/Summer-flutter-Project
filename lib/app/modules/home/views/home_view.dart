import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
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
                children: const [
                  Text(
                    'การแจ้งเตือน',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.notifications), // เพิ่ม icon หรือ widget ตามต้องการ
                ],
              ),
            ),

            // List ของรายการแจ้งเตือน
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
                  _buildBottomNavItem(Icons.person, false, () {
                    Get.toNamed('/profile');
                  }),
                  _buildBottomNavItem(Icons.notifications, true, () {}),
                  _buildBottomNavItem(Icons.assignment, false, () {
                    Get.toNamed('/data-stu');
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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