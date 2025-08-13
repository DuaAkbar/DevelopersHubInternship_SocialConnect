import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialconnect/controllers/notificationcontroller.dart';
import 'package:socialconnect/services/supabaseservices.dart';
import 'package:socialconnect/utils/Helpers.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  Notificationcontroller notificationsController = Get.put(
    Notificationcontroller(),
  );

  @override
  void initState() {
    notificationsController.fetchNotifications(
      SupabaseService.currentUser.value!.id,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.close),
        ),
        title: Text(
          "Notifications",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontFamily: 'Delius',
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ),
      body: Obx(
        () => Column(
          children: [
            notificationsController.isLoading.value == true
                ? Center(child: CircularProgressIndicator.adaptive())
                : Expanded(
                  child:
                      notificationsController.notification.isNotEmpty
                          ? ListView.builder(
                            itemCount:
                                notificationsController.notification.length,
                            itemBuilder: (context, index) {
                              final notification =
                                  notificationsController.notification[index];
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: ListTile(
                                  isThreeLine: true,
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        notification.users!.metaData?.image !=
                                                null
                                            ? NetworkImage(
                                              "https://massqohrwvyezbghqhho.supabase.co/storage/v1/object/public/${notification.users!.metaData!.image}",
                                            )
                                            : AssetImage(
                                              "assets/images/one.jpeg",
                                            ),
                                  ),
                                  title: Text(
                                    notification.users!.metaData!.name!,
                                    style: TextStyle(
                                      fontFamily: 'Delius',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                    ),
                                  ),
                                  subtitle: Text(
                                    style: TextStyle(
                                      fontFamily: 'Delius',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                    notification.notifications ?? "No details",
                                  ),
                                  trailing: Text(
                                    style: TextStyle(
                                      fontFamily: 'Delius',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                    ),
                                    Helpers.formatDateTime(
                                      notification.createdAt!,
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                          : Center(child: Text("No Notifications Found")),
                ),
          ],
        ),
      ),
    );
  }
}
