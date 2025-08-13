import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialconnect/controllers/postscontroller.dart';
import 'package:socialconnect/widget/postcard.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final Postscontroller postscontroller = Get.put(Postscontroller());

  @override
  void initState() {
    postscontroller.fetchPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SocialConnect",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontFamily: 'Delius',
            fontWeight: FontWeight.w700,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        actions: [
           IconButton(
          onPressed: () {
            Get.toNamed("/notifications");
          },
          icon: Icon(Icons.notifications),
        ),
        ]
      ),
      body: Obx(
        () => RefreshIndicator(
          child:
              postscontroller.isLoading.value == true
                  ? Center(child: CircularProgressIndicator.adaptive())
                  : Padding(
                    padding: EdgeInsets.all(16),
                    child: ListView.builder(
                      itemCount: postscontroller.posts.length,
                      itemBuilder: (context, index) {
                        return Postcard(post: postscontroller.posts[index]);
                      },
                    ),
                  ),
          onRefresh: () => postscontroller.fetchPosts(),
        ),
      ),
    );
  }
}
