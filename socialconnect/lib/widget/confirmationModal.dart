import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmationModal extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback callback;
  const ConfirmationModal({
    super.key,
    required this.title,
    required this.message,
    required this.callback,
  });

  static const Color primaryColor = Color(0xFF1565C0);
  static const Color accentColor = Color(0xFFFFF0F5);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        height: MediaQuery.of(context).size.height / 4,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              offset: const Offset(12, 26),
              blurRadius: 50,
              spreadRadius: 0,
              
              color: Colors.grey.withOpacity(0.1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                    fontFamily: 'Delius',
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                  
              ),
            ),
            const SizedBox(height: 3.5),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                    fontFamily: 'Delius',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SimpleBtn1(
                  text: "No",
                  onPressed: () {
                    Get.back();
                  },
                  invertedColors: true,
                ),
                SimpleBtn1(
                  text: "Yes",
                  onPressed: () {
                    Get.back();
                    callback();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SimpleBtn1 extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool invertedColors;

  const SimpleBtn1({
    required this.text,
    required this.onPressed,
    this.invertedColors = false,
    super.key,
  });

  static const Color primaryColor = Color(0xFF1565C0);
  static const Color accentColor = Color(0xFFFFF0F5);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        alignment: Alignment.center,
        side: const BorderSide(width: 1, color: primaryColor),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
        backgroundColor: invertedColors ? accentColor : primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: invertedColors ? primaryColor : accentColor,
          fontSize: 16,
        ),
      ),
    );
  }
}
