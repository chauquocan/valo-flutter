class ContactModel {
  String? name;
  String? phone;
  String? email;
  String? address;
  int? id;
  String? icon;
  ContactModel(
      {this.name,
      this.phone,
      this.email,
      this.address,
      this.id,
      this.icon = "assets/icons/User Icon.svg"});
}

class FriendReqModel {
  late String? id;
  late String fromId;
  late String? toId;
  late String sendAt;

  FriendReqModel(
      {this.id, required this.fromId, this.toId, required this.sendAt});

  FriendReqModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromId = json['fromId'];
    toId = json['toId'];
    sendAt = json['sendAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fromId'] = this.fromId;
    data['toId'] = this.toId;
    data['sendAt'] = this.sendAt;
    return data;
  }
}
