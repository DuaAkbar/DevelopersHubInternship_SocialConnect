import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialconnect/model/comment.dart';
import 'package:socialconnect/model/posts.dart';
import 'package:socialconnect/utils/Helpers.dart';

class CommentCard extends StatelessWidget {
  final Comment comment;
  final PostModel post = Get.arguments as PostModel;

  CommentCard({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: ListTile(
        isThreeLine: true,
        contentPadding: const EdgeInsets.all(14),
        tileColor: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1.3,
          ),
        ),
        title: Text(
          comment.users!.metaData!.name!,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontFamily: 'Delius',
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 6),
            Text(
              comment.comment!,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontFamily: 'Delius',
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                Helpers.formatDateTime(comment.createdAt!),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  fontSize: 12,
                  fontFamily: 'Delius',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
