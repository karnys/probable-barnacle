import 'package:coop_admin/Pages/home.dart';
import 'package:coop_admin/Pages/list.dart';
import 'package:coop_admin/Pages/setting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

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
                label: ''),
            NavigationDestination(
                icon: Icon(
                  Icons.list,
                  color: Colors.red,
                  size: 30,
                ),
                label: ''),
            NavigationDestination(
                icon: Icon(
                  Icons.settings,
                  color: Colors.red,
                  size: 30,
                ),
                label: ''),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [Home(), History(), Setting()];
}
