import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ข้อมูลครู',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Kanit', // ใช้ฟอนต์ไทย
      ),
      home: const TeacherProfilePage(),
    );
  }
}

// หน้าข้อมูลครู
class TeacherProfilePage extends StatelessWidget {
  const TeacherProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TeacherProfileController controller = Get.put(
      TeacherProfileController(),
    );

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
                    'ข้อมูลครู',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Obx(
                    () => IconButton(
                      onPressed:
                          controller.isEditing.value
                              ? controller.saveProfile
                              : controller.toggleEdit,
                      icon: Icon(
                        controller.isEditing.value ? Icons.save : Icons.edit,
                        size: 28,
                        color:
                            controller.isEditing.value
                                ? Colors.green
                                : Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // รูปโปรไฟล์
                    Obx(
                      () => TeacherImageWidget(
                        imageUrl: controller.profileImage.value,
                        isEditing: controller.isEditing.value,
                        onImageTap: controller.changeProfileImage,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ข้อมูลครู
                    Obx(
                      () => Column(
                        children: [
                          TeacherInfoCard(
                            icon: Icons.person,
                            title: 'ชื่อ-นามสกุล',
                            value: controller.teacherName.value,
                            isEditing: controller.isEditing.value,
                            onChanged: controller.updateTeacherName,
                            color: Colors.blue,
                          ),

                          TeacherInfoCard(
                            icon: Icons.school,
                            title: 'ประจำชั้น',
                            value: controller.homeroom.value,
                            isEditing: controller.isEditing.value,
                            onChanged: controller.updateHomeroom,
                            color: Colors.green,
                          ),

                          TeacherInfoCard(
                            icon: Icons.book,
                            title: 'สอนวิชา',
                            value: controller.subjects.value,
                            isEditing: controller.isEditing.value,
                            onChanged: controller.updateSubjects,
                            color: Colors.orange,
                            isMultiline: true,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
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
                  _buildBottomNavItem(Icons.person, true, () {}),
                  _buildBottomNavItem(Icons.notifications, false, () {
                    Get.toNamed('/home');
                  }),
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
        child: Icon(icon, color: Colors.white, size: 28),
      ),
    );
  }
}

// Widget สำหรับรูปโปรไฟล์ครู
class TeacherImageWidget extends StatelessWidget {
  final String imageUrl;
  final bool isEditing;
  final VoidCallback onImageTap;

  const TeacherImageWidget({
    super.key,
    required this.imageUrl,
    required this.isEditing,
    required this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEditing ? onImageTap : null,
      child: Stack(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 10,
                ),
              ],
            ),
            child: ClipOval(
              child:
                  imageUrl.isNotEmpty
                      ? Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.person,
                              size: 60,
                              color: Colors.grey,
                            ),
                          );
                        },
                      )
                      : Container(
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.grey,
                        ),
                      ),
            ),
          ),
          if (isEditing)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// Component สำหรับ Card ข้อมูลครูแต่ละรายการ
class TeacherInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final bool isEditing;
  final Function(String) onChanged;
  final Color color;
  final bool isMultiline;

  const TeacherInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.isEditing,
    required this.onChanged,
    required this.color,
    this.isMultiline = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        color: color,
        elevation: 2,
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
                child: Icon(icon, color: color, size: 24),
              ),

              const SizedBox(width: 16),

              // ข้อมูล
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (isEditing)
                      TextField(
                        controller: TextEditingController(text: value),
                        onChanged: onChanged,
                        maxLines: isMultiline ? 3 : 1,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          hintText: _getHintText(title),
                          hintStyle: const TextStyle(color: Colors.grey),
                        ),
                      )
                    else
                      Text(
                        value.isEmpty ? 'ไม่ระบุ' : value,
                        style: TextStyle(
                          color: value.isEmpty ? Colors.white70 : Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getHintText(String title) {
    switch (title) {
      case 'ชื่อ-นามสกุล':
        return 'เช่น นายสมชาย ใจดี';
      case 'ประจำชั้น':
        return 'เช่น ม.1/1, ป.6/2';
      case 'สอนวิชา':
        return 'เช่น คณิตศาสตร์, ภาษาไทย';
      default:
        return '';
    }
  }
}

void main() {
  runApp(ProfileApp());
}
