import 'package:get/get.dart';
import 'package:socialconnect/model/user.dart';
import 'package:socialconnect/services/supabaseservices.dart';
import 'package:socialconnect/utils/Helpers.dart';

class Searchcontroller extends GetxController {
  RxBool isLoading = RxBool(false);
  RxList<Users> users = RxList<Users>([]);

  Future<void> searchUserdata(String name) async {
    try {
      users.value = [];
      isLoading.value = true;
      final data = await SupabaseService.client.from("users").select('''
*
''').like(
        "metadata->>name",
        name,
      );

      if (data.isNotEmpty) {
        users.value = [for (var item in data) Users.fromJson(item)];
      }
    } catch (e) {
      users.value = [];
      Helpers.showCustomSnackBar(
        "Error",
        "Some Error Occured",
      );
    } finally {
      isLoading.value = false;
    }
  }
}
