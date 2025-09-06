import 'package:get/get.dart';

class Usersprofilecontroller extends GetxController {
  var isFollowing = false.obs;

  void togglefollow() {
    isFollowing.value = !isFollowing.value;
  }
}
