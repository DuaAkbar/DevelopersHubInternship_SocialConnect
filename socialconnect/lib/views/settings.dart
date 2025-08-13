import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialconnect/controllers/settingscontroller.dart';
import 'package:socialconnect/services/navigationservice.dart';
import 'package:socialconnect/utils/Helpers.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  SettingsController settingsController = Get.put(SettingsController());
  NavigationServices navigationServices = Get.find<NavigationServices>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontFamily: 'Delius',
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.offNamed("/");
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            onTap: () {
              Helpers.showConfirmationDialogue(
                "Are you Sure?",
                "This action will log you out from the App",
                () {
                  settingsController.logout();
                },
              );
            },
            title: Text(
              "Logout",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontFamily: 'Delius',
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            leading: Icon(Icons.logout),
            trailing: Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }
}
