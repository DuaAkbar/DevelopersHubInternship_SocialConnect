import 'package:socialconnect/model/user.dart';

class Notification {
  int? id;
  String? notifications;
  String? userId;
  String? toUserId;
  int? postId;
  String? createdAt;
  Users? users;

  Notification({
    this.id,
    this.notifications,
    this.userId,
    this.toUserId,
    this.postId,
    this.createdAt,
    this.users,
  });

  Notification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notifications = json['notifications'];
    userId = json['user_id'];
    toUserId = json['to_user_id'];
    postId = json['post_id'];
    createdAt = json['created_at'];
    users = json['users'] != null ? new Users.fromJson(json['users']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['notifications'] = this.notifications;
    data['user_id'] = this.userId;
    data['to_user_id'] = this.toUserId;
    data['post_id'] = this.postId;
    data['created_at'] = this.createdAt;
    if (this.users != null) {
      data['users'] = this.users!.toJson();
    }
    return data;
  }
}
