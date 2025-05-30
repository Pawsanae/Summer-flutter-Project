import 'package:get/get.dart';

class ProfileController extends GetxController {
  var isEditing = false.obs;
  var profileImage = ''.obs;
  var teacherName = 'ครูสมหญิง ใจดี'.obs;
  var homeroom = 'ม.1/1'.obs;
  var subjects = 'คณิตศาสตร์'.obs;

  void toggleEdit() {
    isEditing.value = !isEditing.value;
  }

  void saveProfile() {
    isEditing.value = false;
    Get.snackbar(
      'สำเร็จ',
      'บันทึกข้อมูลเรียบร้อยแล้ว',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Get.theme.primaryColor,
      colorText: Get.theme.colorScheme.onPrimary,
    );
  }

  void changeProfileImage() {
    // ในการใช้งานจริง จะเป็นการเปิด Image Picker
    Get.snackbar(
      'เปลี่ยนรูปโปรไฟล์',
      'คุณสามารถเลือกรูปภาพจากแกลลอรี่ได้',
      snackPosition: SnackPosition.TOP,
    );
  }

  void updateTeacherName(String value) {
    teacherName.value = value;
  }

  void updateHomeroom(String value) {
    homeroom.value = value;
  }

  void updateSubjects(String value) {
    subjects.value = value;
  }
}