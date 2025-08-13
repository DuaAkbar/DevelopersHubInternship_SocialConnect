import 'dart:io';
import 'package:get/get.dart';
import 'package:socialconnect/model/posts.dart';
import 'package:socialconnect/services/supabaseservices.dart';
import 'package:socialconnect/utils/Helpers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Profilecontroller extends GetxController {
  Rx<File?> profilePicture = Rx<File?>(null);
  Rx<String> profileDescription = Rx<String>("");
  RxList<PostModel> posts = RxList<PostModel>([]);

  Future<void> pickImage() async {
    File? image = await Helpers.pickImageFromGallery();
    if (image != null) {
      profilePicture.value = image;
    }
  }

  Future<void> updateProfile(String userId) async {
    try {
      String fullPath = "";
      if (profilePicture.value != null) {
        fullPath = await SupabaseService.client.storage
            .from('postsimage')
            .upload(
              '$userId/profile.jpg',
              profilePicture.value!,
              fileOptions: FileOptions(upsert: true),
            );
      }
      final UserResponse response  = await SupabaseService.client.auth.updateUser(
        UserAttributes(
          data: {"image": fullPath, "description": profileDescription.value},
        ),
      );
      Helpers.showCustomSnackBar("Success", "Profile Updated Successfully");
    } catch (e) {
      print("Update Error: $e.message");
      Helpers.showCustomSnackBar("Error", "Some Error Occurred");
    }
  }
}
