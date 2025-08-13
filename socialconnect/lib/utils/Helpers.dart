import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:socialconnect/widget/confirmationModal.dart';
import 'package:uuid/uuid.dart';

class Helpers {
  static void showCustomSnackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      snackStyle: SnackStyle.GROUNDED,
      margin: EdgeInsets.zero,
      backgroundColor:  Color(0xFF3B8AC4), 
      colorText: Colors.white,
      titleText: Text(
      title,
      style:  TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    messageText: Text(
      message,
      style:  TextStyle(
        color: Colors.white,
      ),
    ),
    );
  }

  static void showConfirmationDialogue(
    String title,
    String message,
    VoidCallback callback,
  ) {
    Get.dialog(
      ConfirmationModal(title: title, message: message, callback: callback),
    );
  }

 static Future<File?> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;

    final Directory tempDir = Directory.systemTemp;
    final tragetPath = "${tempDir.absolute.path}/${Uuid().v6()}.jpg";

    File newFile = await File(image.path).copy(tragetPath);

    return newFile;
  }


  static String formatDateTime(String date) {
    DateTime utc = DateTime.parse(date.split("+")[0]);
    DateTime localTime = utc.add(
      Duration(hours: 5),
    );
    return Jiffy.parseFromDateTime(localTime).fromNow();
  }
}
