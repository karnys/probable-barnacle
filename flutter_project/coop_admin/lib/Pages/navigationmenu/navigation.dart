import 'dart:io';

import 'package:coop_admin/Pages/HistoryPage/history.dart';
import 'package:coop_admin/Pages/HomePage/home.dart';
import 'package:coop_admin/Pages/Scaner/scanner_page.dart';
import 'package:coop_admin/Pages/SettingPage/setting.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          indicatorColor: Colors.white,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(
              icon: Icon(
                Icons.home,
                color: Colors.red,
                size: 30,
              ),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.qr_code_scanner_sharp,
                color: Colors.red,
                size: 30,
              ),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.list,
                color: Colors.red,
                size: 30,
              ),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.settings,
                color: Colors.red,
                size: 30,
              ),
              label: '',
            ),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  // ตั้งค่าหน้าเริ่มต้นเป็น Home
  final screens = [Home(), ScannerPage(), History(), Setting()];
}
