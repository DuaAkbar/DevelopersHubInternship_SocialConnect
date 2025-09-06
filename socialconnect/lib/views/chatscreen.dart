import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/messagingcontroller.dart';
import '../services/supabaseservices.dart';

class ChatScreen extends StatelessWidget {
  final String receiverId;
  final MessagingController controller = Get.put(MessagingController());
  final TextEditingController textController = TextEditingController();

  ChatScreen({required this.receiverId});

  @override
  Widget build(BuildContext context) {
    final senderId = SupabaseService.currentUser.value?.id;
    if (senderId == null)
      return Scaffold(body: Center(child: Text("User not logged in")));

    controller.loadMessages(senderId, receiverId);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chat",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontFamily: 'Delius',
            fontWeight: FontWeight.w700,
            fontSize: 25,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  bool isMe = message['sender_id'] == senderId;
                  return Align(
                    alignment:
                        isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color:
                            isMe
                                ? Theme.of(context).colorScheme.secondary
                                : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(message['content']),
                    ),
                  );
                },
              );
            }),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                     controller: textController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFF7F8FA),
                      hintText: "Type a Text...",

                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {
                    final content = textController.text.trim();
                    if (content.isNotEmpty) {
                      controller.sendMessage(senderId, receiverId, content);
                      textController.clear();
                    }
                  },
                ),
                SizedBox(height: 6),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
