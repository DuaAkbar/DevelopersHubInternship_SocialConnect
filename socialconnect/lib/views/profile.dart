import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialconnect/controllers/profilecontroller.dart';
import 'package:socialconnect/services/navigationservice.dart';
import 'package:socialconnect/services/supabaseservices.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  NavigationServices navigationServices = Get.find<NavigationServices>();
  Profilecontroller profilecontroller = Get.put(Profilecontroller());
  int selectedTab = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            navigationServices.currentPage.value =
                navigationServices.previousPage.value;
          },
          icon:  Icon(Icons.arrow_back),
        ),
        title: Text(
          "Profile",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontFamily: 'Delius',
            fontWeight: FontWeight.w700,
            fontSize: 23,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding:  EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 20),
            Column(
              children: [
                Obx(
                  () => CircleAvatar(
                    radius: 45,
                    backgroundImage:
                        SupabaseService
                                    .currentUser
                                    .value!
                                    .userMetadata?["image"] !=
                                null
                            ? NetworkImage(
                              "https://massqohrwvyezbghqhho.supabase.co/storage/v1/object/public/${SupabaseService.currentUser.value!.userMetadata!["image"]}",
                            )
                            : AssetImage("assets/images/one.jpeg"),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  SupabaseService.currentUser.value!.userMetadata!["name"],
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontFamily: 'Delius',
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  SupabaseService
                          .currentUser
                          .value!
                          .userMetadata!["description"] ??
                      'Hi everyone',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontFamily: 'Delius',
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                  ),
                ),
                 SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Get.toNamed(
                        "/profileupdate",
                      ); 
                    },
                    icon: Icon(Icons.edit),
                    label: Text("Edit Profile",
                        style: TextStyle(
                        fontFamily: 'Delius',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                      ),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      foregroundColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String label, int index) {
    final isSelected = selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => selectedTab = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color:
                isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildMediaSection() {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 6, // placeholder items
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
              image: AssetImage(
                "asset/images/media_placeholder.jpg",
              ), // Add your image
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
