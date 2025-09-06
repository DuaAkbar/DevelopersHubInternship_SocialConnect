import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialconnect/controllers/profilecontroller.dart';
import 'package:socialconnect/controllers/usersProfilecontroller.dart';
import 'package:socialconnect/model/user.dart';

class Usersprofiles extends StatefulWidget {
  final Users user;
  const Usersprofiles({super.key, required this.user});

  @override
  State<Usersprofiles> createState() => _UsersprofilesState();
}

class _UsersprofilesState extends State<Usersprofiles> {
  // NavigationServices navigationService = Get.find<NavigationServices>();
  Profilecontroller profilecontroller = Get.put(Profilecontroller());
  Usersprofilecontroller usersprofilecontroller = Get.put(
    Usersprofilecontroller(),
  );

  final user = Get.arguments;
  int selectedTab = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // navigationService.currentPage.value =
            //     navigationService.previousPage.value;
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          widget.user.metaData?.name ?? 'No Name',
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
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 20),
            Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage:
                      widget.user.metaData?.image != null
                          ? NetworkImage(
                            "https://massqohrwvyezbghqhho.supabase.co/storage/v1/object/public/${widget.user.metaData?.image}",
                          )
                          : AssetImage("assets/images/one.jpeg"),
                ),

                SizedBox(height: 12),
                Text(
                  widget.user.metaData?.name ?? 'No Name',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontFamily: 'Delius',
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  widget.user.metaData?.description ?? 'Hi everyone',
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
                  child: Obx(
                    () => OutlinedButton.icon(
                      onPressed: () {
                        usersprofilecontroller.togglefollow();
                      },
                      icon: Icon(
                        usersprofilecontroller.isFollowing.value
                            ? Icons.check
                            : Icons.person_add,
                      ),
                      label: Text(
                        usersprofilecontroller.isFollowing.value
                            ? "Following"
                            : "Follow",
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
