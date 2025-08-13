import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:socialconnect/model/comment.dart';
import 'package:socialconnect/model/posts.dart';
import 'package:socialconnect/services/supabaseservices.dart';
import 'package:socialconnect/utils/Helpers.dart';

class Commentscontroller extends GetxController {
  RxString replyContent = RxString("");
  RxBool isLoading = false.obs;
  RxBool fetchIsLoading = false.obs;
  RxList<Comment> comments = RxList<Comment>([]);

  Future<void> addComment(PostModel post , int postId, String userId, String toUserId) async {
    isLoading.value = true;

    print("----- ADD COMMENT DEBUG START -----");
    print("Post ID: $postId");
    print("Current User ID: $userId");
    print("Post Owner ID: $toUserId");
    print("Reply Content: '${replyContent.value}'");

    try {
      print("Inserting into 'comments' table...");
      final commentRes = await SupabaseService.client.from('comments').insert({
        'comment': replyContent.value,
        'user_id': userId,
        'to_user_id': toUserId,
        'post_id': postId,
      });
      print("Comments insert result: $commentRes");

      print("Inserting into 'notifications' table...");
      final notifRes = await SupabaseService.client
          .from('notifications')
          .insert({
            'notifications': "Replied on your Post",
            'user_id': userId,
            'to_user_id': toUserId,
            'post_id': postId,
          });

      await SupabaseService.client
          .from("posts")
          .update({"reply-count": post.replyCount! + 1})
          .eq("id", post.id!);

      post.replyCount = post.replyCount! + 1;


      Helpers.showCustomSnackBar("Success", "Your Comment has been added");

      Get.back();
    } catch (e) {
      print("Error details: $e");
      Helpers.showCustomSnackBar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchComments(int postId) async {
    try {
      fetchIsLoading.value = true;
      final data = await SupabaseService.client
          .from('comments')
          .select(
            '''id, comment, user_id, to_user_id, post_id, created_at, users: user_id(email, metadata)''',
          )
          .eq('post_id', postId);
      if (data.isNotEmpty) {
        comments.value = [for (var item in data) Comment.fromJson(item)];
      }
    } catch (e) {
      Helpers.showCustomSnackBar("Error", "Some Error Occured");
    } finally {
      fetchIsLoading.value = false;
    }
  }
}
