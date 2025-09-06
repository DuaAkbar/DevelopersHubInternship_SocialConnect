import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/supabaseservices.dart';

class MessagingController extends GetxController {
  var messages = <Map<String, dynamic>>[].obs;
  var unreadMessages = <String, int>{}.obs;

  final Set<int> processedMessageIds = {};

  @override
  void onInit() {
    super.onInit();
    subscribeToMessages();
  }

  Future<void> loadMessages(String senderId, String receiverId) async {
    try {
      final response = await SupabaseService.client
          .from('messages')
          .select()
          .or(
            'and(sender_id.eq.$senderId,receiver_id.eq.$receiverId),and(sender_id.eq.$receiverId,receiver_id.eq.$senderId)',
          )
          .order('created_at', ascending: true);

      messages.value = List<Map<String, dynamic>>.from(response);

      // Mark old messages as processed
      for (var m in messages) {
        processedMessageIds.add(m['id']);
      }
    } catch (e) {
      print("Error fetching messages: $e");
    }
  }

  Future<void> sendMessage(
    String senderId,
    String receiverId,
    String content,
  ) async {
    if (content.isEmpty) return;
    try {
      await SupabaseService.client.from('messages').insert({
        'sender_id': senderId,
        'receiver_id': receiverId,
        'content': content,
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      print("Error sending message: $e");
    }
  }

  void subscribeToMessages() {
    final currentUserId = SupabaseService.currentUser.value?.id;
    if (currentUserId == null) return;

    SupabaseService.client
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('receiver_id', currentUserId)
        .listen((List<Map<String, dynamic>> newMessages) async {
      for (var newMessage in newMessages) {
        final msgId = newMessage['id'];

        if (processedMessageIds.contains(msgId)) continue;

        processedMessageIds.add(msgId);
        messages.add(newMessage);

        final senderId = newMessage['sender_id'];
        final senderData = await SupabaseService.client
            .from('users')
            .select('metadata')
            .eq('id', senderId)
            .single();

        final senderName = senderData['metadata']?['name'] ?? 'Unknown';

        Get.snackbar(
          'New Message',
          'You have received a message from $senderName',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.blueGrey,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );

        unreadMessages[senderId] = (unreadMessages[senderId] ?? 0) + 1;
      }
    });
  }
}

