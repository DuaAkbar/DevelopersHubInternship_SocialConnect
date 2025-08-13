import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialconnect/home/homePage.dart';
import 'package:socialconnect/views/addpost.dart';
import 'package:socialconnect/views/profile.dart';
import 'package:socialconnect/views/settings.dart';
import 'package:socialconnect/widget/updateProfile.dart';

class NavigationServices extends GetxService {
  var currentPage = 0.obs;
  var previousPage = 0.obs;

  List<Widget> pages = [Homepage(), Addpost() ,  Profile(), Settings(),  UpdateProfileScreen(),];

  void updateindex(int index) {
    previousPage.value = currentPage.value;
    currentPage.value = index;  
  }
}