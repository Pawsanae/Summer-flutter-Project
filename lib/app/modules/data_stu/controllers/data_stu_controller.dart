import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataStuController extends GetxController {
  var students = <Student>[].obs;
  var filteredStudents = <Student>[].obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadStudents();
  }

  void loadStudents() {
    students.value = [
      Student(
        id: '1',
        name: 'นางสาวสมใส ใจดี',
        number: '1',
        classroom: 'ม.1/1',
        phone: '081-234-5678',
        parent: 'นายสมชาย ใจดี',
      ),
      Student(
        id: '2',
        name: 'นายสมศักดิ์ มั่นคง',
        number: '2',
        classroom: 'ม.1/1',
        phone: '082-345-6789',
        parent: 'นางสมหญิง มั่นคง',
      ),
      Student(
        id: '3',
        name: 'นางสาวอรุณี สว่าง',
        number: '3',
        classroom: 'ม.1/2',
        phone: '083-456-7890',
        parent: 'นายอรุณ สว่าง',
      ),
      Student(
        id: '4',
        name: 'นายชัยวัฒน์ เก่ง',
        number: '4',
        classroom: 'ม.1/2',
        phone: '084-567-8901',
        parent: 'นางชัยรัตน์ เก่ง',
      ),
      Student(
        id: '5',
        name: 'นางสาวพิมพ์ใจ รักเรียน',
        number: '5',
        classroom: 'ม.2/1',
        phone: '085-678-9012',
        parent: 'นายพิมพ์ศักดิ์ รักเรียน',
      ),
    ];
    filteredStudents.value = students;
  }

  void searchStudents(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredStudents.value = students;
    } else {
      filteredStudents.value = students.where((student) {
        return student.name.toLowerCase().contains(query.toLowerCase()) ||
               student.classroom.toLowerCase().contains(query.toLowerCase()) ||
               student.number.contains(query);
      }).toList();
    }
  }

  void addStudent() {
    Get.dialog(
      AddStudentDialog(
        onSave: (student) {
          students.add(student);
          if (searchQuery.value.isEmpty) {
            filteredStudents.value = students;
          } else {
            searchStudents(searchQuery.value);
          }
          Get.back();
          Get.snackbar(
            'สำเร็จ',
            'เพิ่มข้อมูลนักเรียนเรียบร้อยแล้ว',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        },
      ),
    );
  }

  void editStudent(Student student) {
    Get.dialog(
      EditStudentDialog(
        student: student,
        onSave: (updatedStudent) {
          int index = students.indexWhere((s) => s.id == student.id);
          if (index != -1) {
            students[index] = updatedStudent;
            searchStudents(searchQuery.value);
          }
          Get.back();
          Get.snackbar(
            'สำเร็จ',
            'แก้ไขข้อมูลนักเรียนเรียบร้อยแล้ว',
            backgroundColor: Colors.blue,
            colorText: Colors.white,
          );
        },
      ),
    );
  }

  void deleteStudent(Student student) {
    Get.dialog(
      AlertDialog(
        title: const Text('ยืนยันการลบ'),
        content: Text('คุณต้องการลบข้อมูลของ ${student.name} หรือไม่?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('ยกเลิก'),
          ),
          TextButton(
            onPressed: () {
              students.removeWhere((s) => s.id == student.id);
              searchStudents(searchQuery.value);
              Get.back();
              Get.snackbar(
                'สำเร็จ',
                'ลบข้อมูลนักเรียนเรียบร้อยแล้ว',
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            },
            child: const Text('ลบ', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void viewStudentDetail(Student student) {
    Get.dialog(
      AlertDialog(
        title: Text(student.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('เลขที่: ${student.number}'),
            Text('ห้องเรียน: ${student.classroom}'),
            Text('เบอร์โทร: ${student.phone}'),
            Text('ผู้ปกครอง: ${student.parent}'),
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
}

class Student {
  final String id;
  final String name;
  final String number;
  final String classroom;
  final String phone;
  final String parent;

  Student({
    required this.id,
    required this.name,
    required this.number,
    required this.classroom,
    required this.phone,
    required this.parent,
  });

  Student copyWith({
    String? id,
    String? name,
    String? number,
    String? classroom,
    String? phone,
    String? parent,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      number: number ?? this.number,
      classroom: classroom ?? this.classroom,
      phone: phone ?? this.phone,
      parent: parent ?? this.parent,
    );
  }
}

// Dialog สำหรับเพิ่มนักเรียน
class AddStudentDialog extends StatefulWidget {
  final Function(Student) onSave;

  const AddStudentDialog({super.key, required this.onSave});

  @override
  State<AddStudentDialog> createState() => _AddStudentDialogState();
}

class _AddStudentDialogState extends State<AddStudentDialog> {
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final classroomController = TextEditingController();
  final phoneController = TextEditingController();
  final parentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('เพิ่มนักเรียนใหม่'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'ชื่อ-นามสกุล',
                hintText: 'เช่น นางสาวสมใส ใจดี',
              ),
            ),
            TextField(
              controller: numberController,
              decoration: const InputDecoration(
                labelText: 'เลขที่',
                hintText: 'เช่น 1',
              ),
            ),
            TextField(
              controller: classroomController,
              decoration: const InputDecoration(
                labelText: 'ห้องเรียน',
                hintText: 'เช่น ม.1/1',
              ),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'เบอร์โทร',
                hintText: 'เช่น 081-234-5678',
              ),
            ),
            TextField(
              controller: parentController,
              decoration: const InputDecoration(
                labelText: 'ผู้ปกครอง',
                hintText: 'เช่น นายสมชาย ใจดี',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('ยกเลิก'),
        ),
        TextButton(
          onPressed: () {
            if (nameController.text.isNotEmpty &&
                numberController.text.isNotEmpty &&
                classroomController.text.isNotEmpty) {
              final student = Student(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                name: nameController.text,
                number: numberController.text,
                classroom: classroomController.text,
                phone: phoneController.text,
                parent: parentController.text,
              );
              widget.onSave(student);
            }
          },
          child: const Text('บันทึก'),
        ),
      ],
    );
  }
}

// Dialog สำหรับแก้ไขนักเรียน
class EditStudentDialog extends StatefulWidget {
  final Student student;
  final Function(Student) onSave;

  const EditStudentDialog({
    super.key,
    required this.student,
    required this.onSave,
  });

  @override
  State<EditStudentDialog> createState() => _EditStudentDialogState();
}

class _EditStudentDialogState extends State<EditStudentDialog> {
  late TextEditingController nameController;
  late TextEditingController numberController;
  late TextEditingController classroomController;
  late TextEditingController phoneController;
  late TextEditingController parentController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.student.name);
    numberController = TextEditingController(text: widget.student.number);
    classroomController = TextEditingController(text: widget.student.classroom);
    phoneController = TextEditingController(text: widget.student.phone);
    parentController = TextEditingController(text: widget.student.parent);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('แก้ไขข้อมูลนักเรียน'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'ชื่อ-นามสกุล'),
            ),
            TextField(
              controller: numberController,
              decoration: const InputDecoration(labelText: 'เลขที่'),
            ),
            TextField(
              controller: classroomController,
              decoration: const InputDecoration(labelText: 'ห้องเรียน'),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'เบอร์โทร'),
            ),
            TextField(
              controller: parentController,
              decoration: const InputDecoration(labelText: 'ผู้ปกครอง'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('ยกเลิก'),
        ),
        TextButton(
          onPressed: () {
            final updatedStudent = widget.student.copyWith(
              name: nameController.text,
              number: numberController.text,
              classroom: classroomController.text,
              phone: phoneController.text,
              parent: parentController.text,
            );
            widget.onSave(updatedStudent);
          },
          child: const Text('บันทึก'),
        ),
      ],
    );
  }
}