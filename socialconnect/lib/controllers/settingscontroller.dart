import 'package:get/get.dart';
import 'package:socialconnect/services/supabaseservices.dart';

class SettingsController extends GetxController {
  Future<void> logout() async {
   await  SupabaseService.client.auth.signOut();
    Get.offAllNamed("/login");
  }
}
