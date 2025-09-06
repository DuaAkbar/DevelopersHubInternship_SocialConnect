import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialconnect/home/homePage.dart';
import 'package:socialconnect/views/addpost.dart';
import 'package:socialconnect/views/profile.dart';
import 'package:socialconnect/views/searchscreen.dart';

class NavigationServices extends GetxService {
  var currentPage = 0.obs;
  var previousPage = 0.obs;

  List<Widget> pages = [Homepage(), SearchScreen(), Addpost() , Profile()];

  void updateindex(int index) {
    previousPage.value = currentPage.value;
    currentPage.value = index;  
  }
}