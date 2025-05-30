import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      initialRoute: _Paths.HOME,
      getPages: [
        GetPage(
          name: _Paths.HOME,
          page: () => const HomeView(),
        ),
        GetPage(
          name: _Paths.PROFILE,
          page: () => const ProfileView(),
        ),
        GetPage(
          name: _Paths.DATA_STU,
          page: () => const DataStuView(),
        ),
      ],
    )
  );
}
