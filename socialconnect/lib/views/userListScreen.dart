import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialconnect/controllers/messagingcontroller.dart';
import '../services/supabaseservices.dart';
import 'chatscreen.dart';

class UsersListScreen extends StatelessWidget {
  const UsersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserId = SupabaseService.currentUser.value?.id;
    final MessagingController controller = Get.put(MessagingController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Messages",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontFamily: 'Delius',
            fontWeight: FontWeight.w700,
            fontSize: 25,
          ),
        ),
      ),
      body: FutureBuilder(
        future: SupabaseService.client
            .from('users')
            .select()
            .neq('id', currentUserId ?? ''),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          final users = snapshot.data as List<dynamic>;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Obx(() {
                final unreadCount = controller.unreadMessages[user['id']] ?? 0;

                return ListTile(
                  
                  title: Text(user['metadata']?['name'] ?? 'No Name'),
                  trailing:
                      unreadCount > 0
                          ? Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '$unreadCount',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          )
                          : null,
                  onTap: () {
                    // When you open chat, reset unread count for this user
                    controller.unreadMessages[user['id']] = 0;
                    Get.to(() => ChatScreen(receiverId: user['id']));
                  },
                );
              });
            },
          );
        },
      ),
    );
  }
}
