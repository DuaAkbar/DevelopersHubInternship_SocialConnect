import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialconnect/controllers/commentscontroller.dart';
import 'package:socialconnect/controllers/postscontroller.dart';
import 'package:socialconnect/model/posts.dart';
import 'package:socialconnect/services/supabaseservices.dart';
import 'package:socialconnect/utils/Helpers.dart';
import 'package:socialconnect/views/profile.dart';
import 'package:socialconnect/views/usersProfiles.dart';

class Postcard extends StatefulWidget {
  final PostModel post;
  const Postcard({super.key, required this.post});

  @override
  State<Postcard> createState() => _PostcardState();
}

class _PostcardState extends State<Postcard> {
  Postscontroller postscontroller = Get.find<Postscontroller>();
  Commentscontroller commentscontroller = Get.put(Commentscontroller());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: context.width * 0.12,
              child: CircleAvatar(
                radius: 40,
                backgroundImage:
                    widget.post.users!.metaData?.image != null
                        ? NetworkImage(
                          "https://massqohrwvyezbghqhho.supabase.co/storage/v1/object/public/${widget.post.users!.metaData!.image}",
                        )
                        : AssetImage("assets/images/one.jpeg"),
              ),
            ),
            SizedBox(
              width: context.width * 0.8,
              child: Column(
                children: [
                  ListTile(
                    isThreeLine: true,
                    title: GestureDetector(
                      onTap: () {
                        final currentId =
                            SupabaseService.currentUser.value!.id.toString();
                        final clickedId = widget.post.userId.toString();

                        print("Clicked User: ${widget.post.userId}");
                        print(
                          "Current User: ${SupabaseService.currentUser.value!.id}",
                        );

                        if (clickedId == currentId) {
                          Get.to(() => const Profile());
                        } else {
                          Get.to(() => Usersprofiles(user: widget.post.users!));
                        }
                      },

                      child: Text(
                        widget.post.users!.metaData!.name!,
                        style: TextStyle(
                          fontFamily: 'Delius',
                          fontWeight: FontWeight.w700,
                          fontSize: 19,
                        ),
                      ),
                    ),
                    subtitle: Text(
                      widget.post.content!,
                      style: TextStyle(
                        fontFamily: 'Delius',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    trailing: Text(
                      style: TextStyle(
                        fontFamily: 'Delius',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                      Helpers.formatDateTime(widget.post.createdAt!),
                    ),
                  ),
                  SizedBox(height: 2),
                  widget.post.image != null
                      ? ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: context.height * 0.40,
                          maxWidth: context.width * 100,
                          minWidth: context.width * 100,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            "https://massqohrwvyezbghqhho.supabase.co/storage/v1/object/public/postsimage/${widget.post.image}",
                          ),
                        ),
                      )
                      : SizedBox(),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          postscontroller.toggleLike(widget.post);
                        },
                        icon: Icon(
                          Icons.favorite,
                          color:
                              postscontroller.likedPosts[widget.post.id] == true
                                  ? Colors.red
                                  : null,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Get.toNamed("/comments", arguments: widget.post);
                          setState(() {});
                        },
                        icon: Icon(Icons.chat_bubble),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.send_outlined),
                      ),
                      widget.post.userId ==
                              SupabaseService.currentUser.value!.id
                          ? IconButton(
                            onPressed: () {
                              Helpers.showConfirmationDialogue(
                                "Are You Sure?",
                                "This will delete the post",
                                () {
                                  postscontroller.deletePosts(widget.post.id!);
                                  Get.back();
                                },
                              );
                            },
                            icon: Icon(Icons.delete, color: Colors.red),
                          )
                          : SizedBox(),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "${widget.post.replyCount} Comments",
                        style: TextStyle(
                          fontFamily: 'Delius',
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "${widget.post.likeCount} Likes",
                        style: TextStyle(
                          fontFamily: 'Delius',
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
        Divider(color: Colors.lightBlue[700]),
      ],
    );
  }
}
