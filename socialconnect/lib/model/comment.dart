import 'package:socialconnect/model/user.dart';

class Comment {
  int? id;
  String? comment; 
  String? userId;
  String? toUserId;
  int? postId;
  String? createdAt;
  Users? users;

  Comment({
    this.id,
    this.comment,
    this.userId,
    this.toUserId,
    this.postId,
    this.createdAt,
    this.users,
  });

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment']; 
    userId = json['user_id'];
    toUserId = json['to_user_id'];
    postId = json['post_id'];
    createdAt = json['created_at'];
    users = json['users'] != null ? Users.fromJson(json['users']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['comment'] = comment; 
    data['user_id'] = userId;
    data['to_user_id'] = toUserId;
    data['post_id'] = postId;
    data['created_at'] = createdAt;
    if (users != null) {
      data['users'] = users!.toJson();
    }
    return data;
  }
}
