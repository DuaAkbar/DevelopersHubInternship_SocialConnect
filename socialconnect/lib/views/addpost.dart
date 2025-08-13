import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialconnect/controllers/postscontroller.dart';
import 'package:socialconnect/services/navigationservice.dart';
import 'package:socialconnect/services/supabaseservices.dart';

class Addpost extends StatefulWidget {
  const Addpost({super.key});

  @override
  State<Addpost> createState() => _AddpostState();
}

class _AddpostState extends State<Addpost> {
  NavigationServices navigationServices = Get.find<NavigationServices>();
  Postscontroller postscontroller = Get.put(Postscontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            navigationServices.currentPage.value =
                navigationServices.previousPage.value;
          },
          icon: Icon(Icons.close),
        ),
        title: Text(
          "Add Post",
          style: TextStyle(
            fontFamily: 'Delius',
            fontWeight: FontWeight.w700,
            fontSize: 19,
          ),
        ),
        actions: [
          Obx(
            () => TextButton(
              onPressed: () async {
                if (postscontroller.isLoading.value == false) {
                  if (postscontroller.content.value.isNotEmpty) {
                    await postscontroller.post(
                      SupabaseService.currentUser.value!.id,
                    );
                    navigationServices.updateindex(0);
                  }
                }
              },
              child: Text(
                postscontroller.isLoading.value ? "Posting" : "Post",
                style: TextStyle(
                  fontFamily: 'Delius',
                  fontWeight: FontWeight.w300,
                  fontSize: 19,
                  color:
                      postscontroller.content.value.isEmpty
                          ? Colors.grey
                          : null,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: context.width * 0.12,
              child: CircleAvatar(
                backgroundImage:
                    SupabaseService.currentUser.value!.userMetadata?["image"] !=
                            null
                        ? NetworkImage(
                          "https://massqohrwvyezbghqhho.supabase.co/storage/v1/object/public/${SupabaseService.currentUser.value!.userMetadata!["image"]}",
                        )
                        : AssetImage("assets/images/three.jpeg"),
              ),
            ),
            SizedBox(width: 10),
            SizedBox(
              width: context.width * 0.80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    SupabaseService.currentUser.value!.userMetadata!["name"],
                    style: TextStyle(
                        fontFamily: 'Delius',
                        fontWeight: FontWeight.w700,
                        fontSize: 19,
                      ),
                  ),
                  TextField(
                    onChanged: (value) {
                      postscontroller.content.value = value;
                    },
                    autofocus: true,
                    maxLength: 1000,
                    maxLines: 10,
                    minLines: 1,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Delius',
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      hintText: "Type a Caption",
                      border: InputBorder.none,
                    ),
                  ),
                  Obx(
                    () => Column(
                      children: [
                        postscontroller.postImage.value != null
                            ? Stack(
                              alignment: Alignment.topRight,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    postscontroller.postImage.value!,
                                    // width: context.width * 0.8,
                                    // fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  child: IconButton(
                                    onPressed: () {
                                      postscontroller.postImage.value = null;
                                    },
                                    icon: Icon(Icons.cancel),
                                  ),
                                ),
                              ],
                            )
                            : IconButton(
                              onPressed: () {
                                postscontroller.pickImage();
                              },
                              icon: Icon(Icons.attach_file),
                            ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
