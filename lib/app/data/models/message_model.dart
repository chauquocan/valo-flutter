import 'dart:convert';

List<MessageModel> profileResponseFromJson(String str) =>
    List<MessageModel>.from(
        json.decode(str).map((x) => MessageModel.fromJson(x)));

String profileResponseToJson(List<MessageModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MessageModel {
  final String? id;
  final String type;
  final String message;
  final int time;
  final String senderID;
  //final String senderName;
  //final String? senderAvatar;

  MessageModel({
    this.id,
    required this.senderID,
    //required this.senderName,
    //required this.senderAvatar,
    required this.message,
    required this.type,
    required this.time,
  });

  factory MessageModel.fromRawJson(String str) =>
      MessageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json['id'],
        senderID: json['senderID'],
        //senderName: json['senderName'],
        //senderAvatar: json['senderAvatar'],
        message: json['message'],
        type: json['type'],
        time: json['time'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['senderID'] = senderID;
    //data['senderName'] = senderName;
    // data['senderAvatar'] = senderAvatar;
    data['message'] = message;
    data['type'] = type;
    data['time'] = time;

    return data;
  }
}
