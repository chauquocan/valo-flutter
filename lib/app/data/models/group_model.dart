import 'package:valo_chat_app/app/data/models/conversation_model.dart';

class Group {
  Group({
    required this.name,
    required this.participants,
  });
  late final String name;
  late final List<Participants> participants;
  Group.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    participants = List.from(json['participants'])
        .map((e) => Participants.fromJson(e))
        .toList();
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['participants'] = participants.map((e) => e.toJson()).toList();
    return _data;
  }
}
