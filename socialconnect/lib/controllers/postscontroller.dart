import 'dart:io';
import 'package:get/get.dart';
import 'package:socialconnect/model/posts.dart';
import 'package:socialconnect/services/supabaseservices.dart';
import 'package:socialconnect/utils/Helpers.dart';
import 'package:uuid/uuid.dart';

class Postscontroller extends GetxController {
  Rx<File?> postImage = Rx<File?>(null);
  Rx<String> content = "".obs;
  RxList<PostModel> posts = <PostModel>[].obs;
  RxBool isLoading = false.obs;
  RxBool isLiked = false.obs;

  Future<void> pickImage() async {
    File? image = await Helpers.pickImageFromGallery();
    if (image != null) {
      postImage.value = image;
    }
  }

  Future<void> post(String userId) async {
    try {
      isLoading.value = true;
      var response = null;

      if (postImage.value != null) {
        response = await SupabaseService.client.storage
            .from("postsimage")
            .upload("$userId/${Uuid().v4()}.jpg", postImage.value!);
      }

      await SupabaseService.client.from("posts").insert({
        "content": content.value,
        "image":
            response != null ? response.substring("postsimage/".length) : null,
        "like-count": 0,
        "reply-count": 0,
        "user_id": userId,
      });

      content.value = "";
      postImage.value = null;
      Get.back();
      Helpers.showCustomSnackBar("Success", "Post created Successfully");
    } catch (e) {
      print(e);
      print(e);
      Helpers.showCustomSnackBar("Error", "Failed to upload post");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchPosts() async {
    try {
      isLoading.value = true;
      final data = await SupabaseService.client
          .from("posts")
          .select('''
        id, content, image, like-count, reply-count, user_id, created_at, users:user_id(email , metadata)
      ''')
          .order("created_at", ascending: false);

      if (data.isNotEmpty) {
        posts.value = [for (var item in data) PostModel.fromJson(item)];
        print(data);
      }
    } catch (e) {
      posts.value = [];
      Helpers.showCustomSnackBar("Error", "Some Error Occurred");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deletePosts(int postId) async {
    try {
      await SupabaseService.client.from("posts").delete().eq("id", postId);
      Helpers.showCustomSnackBar("Success", "Post Deleted Successfully");
    } catch (e) {
      Helpers.showCustomSnackBar("Error", "Some Error Occurred");
    }
  }

  RxMap<int, bool> likedPosts = <int, bool>{}.obs;

Future<void> toggleLike(PostModel post) async {
  try {
    bool currentlyLiked = likedPosts[post.id] ?? false;

    if (currentlyLiked) {
      await SupabaseService.client
          .from("posts")
          .update({"like-count": post.likeCount! - 1})
          .eq("id", post.id!);

      post.likeCount = post.likeCount! - 1;
      likedPosts[post.id!] = false;
      Helpers.showCustomSnackBar("Success", "Like Removed");
    } else {
      await SupabaseService.client
          .from("posts")
          .update({"like-count": post.likeCount! + 1})
          .eq("id", post.id!);

      post.likeCount = post.likeCount! + 1;
      likedPosts[post.id!] = true;
      Helpers.showCustomSnackBar("Success", "Liked Successfully");
    }

    posts.refresh();
  } catch (e) {
    Helpers.showCustomSnackBar("Error", "Failed to update like");
  }
}

Future<void> commentCount(PostModel post, String commentText) async {
  if (commentText.trim().isEmpty) return;

  try {
    await SupabaseService.client.from("comments").insert({
      "post_id": post.id,
      "comment_text": commentText,
      "created_at": DateTime.now().toIso8601String(),
    });

  
   
    Helpers.showCustomSnackBar("Success", "Comment added!");
  } catch (e) {
    Helpers.showCustomSnackBar("Error", "Failed to add comment");
  }
}



}
