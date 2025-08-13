import 'package:socialconnect/model/metadata.dart';

class Users {
  String? id;
  String? email;
  MetaData? metaData;

  Users({this.id, this.email, this.metaData});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    metaData = 
         json['metadata'] != null ? MetaData.fromJson(json['metadata']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    if (metaData != null) {
      data['metadata'] = metaData!.toJson(); 
    }
    return data;
  }
}
