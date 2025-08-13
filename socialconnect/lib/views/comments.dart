import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialconnect/controllers/commentscontroller.dart';
import 'package:socialconnect/model/comment.dart';
import 'package:socialconnect/model/posts.dart';
import 'package:socialconnect/services/supabaseservices.dart';
import 'package:socialconnect/widget/commentCard.dart';

class Comments extends StatefulWidget {
  const Comments({super.key});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  final Commentscontroller commentscontroller = Get.put(Commentscontroller());
  PostModel post = Get.arguments;

  @override
  void initState() {
    super.initState();
    post = Get.arguments;
    commentscontroller.fetchComments(post.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Comments",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontFamily: 'Delius',
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Comments List
            Expanded(
              child: Obx(
                () =>
                    commentscontroller.fetchIsLoading.value
                        ? Center(child: CircularProgressIndicator.adaptive())
                        : SizedBox(
                          width: double.infinity,
                          child:
                              commentscontroller.comments.isNotEmpty
                                  ? ListView.builder(
                                    itemCount:
                                        commentscontroller.comments.length,
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      Comment comment =
                                          commentscontroller.comments[index];
                                      return CommentCard(comment: comment);
                                    },
                                  )
                                  : Center(
                                    child: Text(
                                      "No Comment Found",
                                      style: TextStyle(
                                        fontFamily: 'Delius',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 19,
                                      ),
                                    ),
                                  ),
                        ),
              ),
            ),
            SizedBox(height: 12),
            // Comment Input
            Obx(
              () => TextField(
                onChanged: (value) {
                  commentscontroller.replyContent.value = value;
                },
                controller: TextEditingController(
                    text: commentscontroller.replyContent.value,
                  )
                  ..selection = TextSelection.fromPosition(
                    TextPosition(
                      offset: commentscontroller.replyContent.value.length,
                    ),
                  ),
                decoration: InputDecoration(
                  hintText: "Add a comment...",
                  filled: true,
                  fillColor: Theme.of(
                    context,
                  ).colorScheme.secondary.withOpacity(0.2),
                  suffixIcon: IconButton(
                    onPressed: () async {
                      if (commentscontroller.replyContent.value.isNotEmpty &&
                          !commentscontroller.isLoading.value) {
                        await commentscontroller.addComment(
                          post,
                          post.id!,
                          SupabaseService.currentUser.value!.id,
                          post.userId!,
                        );
                        commentscontroller.replyContent.value = "";
                      }
                    },
                    icon:
                        commentscontroller.isLoading.value
                            ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                            : Icon(Icons.send_rounded),
                    color:
                        commentscontroller.replyContent.value.isEmpty
                            ? Colors.grey
                            : Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
