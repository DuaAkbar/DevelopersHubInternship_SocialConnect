import 'package:get/get.dart';
import 'package:socialconnect/model/notifications.dart';
import 'package:socialconnect/services/supabaseservices.dart';
import 'package:socialconnect/utils/Helpers.dart';

class Notificationcontroller extends GetxController {
  RxBool isLoading = RxBool(false);
  RxList<Notification> notification = RxList<Notification>([]);

  Future<void> fetchNotifications(String userId) async {
    try {
      isLoading.value = true;
      final data = await SupabaseService.client
          .from('notifications')
          .select(
            ''' id , notifications, user_id , to_user_id, post_id, created_at, users:user_id(email , metadata) ''',
          )
          .eq("to_user_id", userId)
          .order("created_at", ascending: false);
      if (data.isNotEmpty) {
        notification.value = [
          for (var item in data) Notification.fromJson(item),
        ];
      }
      print(data);
    } catch (e) {
      notification.value = [];
      Helpers.showCustomSnackBar("Error", "Some Error Occured");
    } finally {
      isLoading.value = false;
    }
  }
}
