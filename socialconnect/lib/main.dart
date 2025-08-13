import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialconnect/services/navigationservice.dart';
import 'package:socialconnect/services/supabaseservices.dart';
import 'package:socialconnect/widget/pageRoutes.dart';
import 'package:socialconnect/widget/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(NavigationServices());
  Get.put(SupabaseService());
  runApp(const SocialConnectApp());
}

class SocialConnectApp extends StatelessWidget {
  const SocialConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: mytheme,
      getPages: appRoute,
      initialRoute: "/login",
    );
  }
}
