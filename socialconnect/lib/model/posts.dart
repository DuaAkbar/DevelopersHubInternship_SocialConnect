import 'package:socialconnect/model/user.dart';

class PostModel {
  int? id;
  String? content;
  String? image;
  int? likeCount;
  int? replyCount;
  String? userId;
  String? createdAt;
  Users? users;

  PostModel({
    this.id,
    this.content,
    this.image,
    this.likeCount,
    this.replyCount,
    this.userId,
    this.createdAt,
    this.users,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    image = json['image'];
    likeCount = json['like-count']; 
    replyCount = json['reply-count']; 
    userId = json['user_id'];
    createdAt = json['created_at'];
    users = json['users'] != null ? Users.fromJson(json['users']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['image'] = image;
    data['like-count'] = likeCount; 
    data['reply-count'] = replyCount;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    if (users != null) {
      data['users'] = users!.toJson();
    }
    return data;
  }
}
