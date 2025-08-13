import 'package:get/route_manager.dart';
import 'package:socialconnect/auth/forgotPassword.dart';
import 'package:socialconnect/auth/login.dart';
import 'package:socialconnect/auth/register.dart';
import 'package:socialconnect/home/Homscreen.dart';
import 'package:socialconnect/home/homePage.dart';
import 'package:socialconnect/views/addpost.dart';
import 'package:socialconnect/views/comments.dart';
import 'package:socialconnect/views/notifications_screen.dart';
import 'package:socialconnect/views/profile.dart';
import 'package:socialconnect/views/settings.dart';
import 'package:socialconnect/widget/updateProfile.dart';

final List<GetPage> appRoute = [
  GetPage(name: "/", page: () => Homescreen()),
  GetPage(name: "/addpost", page: () => Addpost()),
  GetPage(name: "/notifications", page: () => NotificationsScreen()),
  GetPage(name: "/profile", page: () => Profile()),
  GetPage(name: "/profileupdate", page: () => UpdateProfileScreen()),
  GetPage(name: "/settings", page: () => Settings()),
  GetPage(name: "/register", page: () => Register()),
  GetPage(name: "/login", page: () => Login()),
  GetPage(name: "/homepage", page: () => Homepage()),
  GetPage(name: "/forgotpassword", page: () => forgotpassword()),
  GetPage(name: "/comments", page: () => Comments()),
];
