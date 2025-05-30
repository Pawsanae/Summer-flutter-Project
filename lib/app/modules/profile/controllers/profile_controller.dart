import 'package:get/get.dart';
import 'package:flutter/material.dart';

class TeacherProfileController extends GetxController {
  // ตัวแปรสำหรับเก็บข้อมูลครู
  var isEditing = false.obs;
  var profileImage = ''.obs;
  var teacherName = 'ครูสมหญิง ประจำสกุล'.obs;
  var homeroom = 'ม.2/3'.obs;
  var subjects = 'คณิตศาสตร์, วิทยาศาสตร์'.obs;

  void toggleEdit() {
    isEditing.value = !isEditing.value;
  }

  void saveProfile() {
    // บันทึกข้อมูล (ในความเป็นจริงจะส่งไปยัง API)
    isEditing.value = false;
    Get.snackbar(
      'สำเร็จ',
      'บันทึกข้อมูลครูเรียบร้อยแล้ว',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
  }

  void changeProfileImage() {
    // เปิด Gallery หรือ Camera (ในความเป็นจริงจะใช้ image_picker)
    Get.snackbar(
      'เปลี่ยนรูปโปรไฟล์',
      'คุณสามารถเลือกรูปจาก Gallery หรือถ่ายรูปใหม่',
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
  }

  void updateTeacherName(String value) => teacherName.value = value;
  void updateHomeroom(String value) => homeroom.value = value;
  void updateSubjects(String value) => subjects.value = value;
}