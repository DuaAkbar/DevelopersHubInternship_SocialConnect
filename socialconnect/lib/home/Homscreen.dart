import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialconnect/services/navigationservice.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  NavigationServices navigationServices = Get.put(NavigationServices());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: navigationServices.pages[navigationServices.currentPage.value],
        bottomNavigationBar: NavigationBar(
          height: 60,
          selectedIndex: navigationServices.currentPage.value,
          onDestinationSelected: (value) {
            navigationServices.updateindex(value);
          },
          destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: ""),
            NavigationDestination(icon: Icon(Icons.search), label: ""),
            NavigationDestination(icon: Icon(Icons.add), label: ""),
            NavigationDestination(icon: Icon(Icons.person), label: "")
          ]
        ),
      ),
    );
  }
}
