class ConversationModel {
  String name;
  String icon;
  bool isGroup;
  String time;
  String currentMessage;
  String? status;
  bool select = false;
  int? id;
  ConversationModel({
    required this.name,
    required this.icon,
    required this.isGroup,
    required this.time,
    required this.currentMessage,
    this.status,
    this.select = false,
    this.id,
  });
}
