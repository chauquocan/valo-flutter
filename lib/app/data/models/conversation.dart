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
class ConversationsPage {
  ConversationsPage({
    required this.content,
    required this.pageable,
    required this.last,
    required this.totalElements,
    required this.totalPages,
    required this.size,
    required this.number,
    required this.sort,
    required this.first,
    required this.numberOfElements,
    required this.empty,
  });
  late final List<Content> content;
  late final Pageable pageable;
  late final bool last;
  late final int totalElements;
  late final int totalPages;
  late final int size;
  late final int number;
  late final Sort sort;
  late final bool first;
  late final int numberOfElements;
  late final bool empty;
  
  ConversationsPage.fromJson(Map<String, dynamic> json){
    content = List.from(json['content']).map((e)=>Content.fromJson(e)).toList();
    pageable = Pageable.fromJson(json['pageable']);
    last = json['last'];
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
    size = json['size'];
    number = json['number'];
    sort = Sort.fromJson(json['sort']);
    first = json['first'];
    numberOfElements = json['numberOfElements'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['content'] = content.map((e)=>e.toJson()).toList();
    _data['pageable'] = pageable.toJson();
    _data['last'] = last;
    _data['totalElements'] = totalElements;
    _data['totalPages'] = totalPages;
    _data['size'] = size;
    _data['number'] = number;
    _data['sort'] = sort.toJson();
    _data['first'] = first;
    _data['numberOfElements'] = numberOfElements;
    _data['empty'] = empty;
    return _data;
  }
}

class Content {
  Content({
    required this.id,
    required this.createAt,
    required this.conversationType,
    required this.participants,
  });
  late final String id;
  late final String createAt;
  late final String conversationType;
  late final List<Participants> participants;
  
  Content.fromJson(Map<String, dynamic> json){
    id = json['id'];
    createAt = json['createAt'];
    conversationType = json['conversationType'];
    participants = List.from(json['participants']).map((e)=>Participants.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['createAt'] = createAt;
    _data['conversationType'] = conversationType;
    _data['participants'] = participants.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Participants {
  Participants({
    required this.userId,
    required this.admin,
  });
  late final String userId;
  late final bool admin;
  
  Participants.fromJson(Map<String, dynamic> json){
    userId = json['userId'];
    admin = json['admin'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['admin'] = admin;
    return _data;
  }
}

class Pageable {
  Pageable({
    required this.sort,
    required this.offset,
    required this.pageSize,
    required this.pageNumber,
    required this.unpaged,
    required this.paged,
  });
  late final Sort sort;
  late final int offset;
  late final int pageSize;
  late final int pageNumber;
  late final bool unpaged;
  late final bool paged;
  
  Pageable.fromJson(Map<String, dynamic> json){
    sort = Sort.fromJson(json['sort']);
    offset = json['offset'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    unpaged = json['unpaged'];
    paged = json['paged'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['sort'] = sort.toJson();
    _data['offset'] = offset;
    _data['pageSize'] = pageSize;
    _data['pageNumber'] = pageNumber;
    _data['unpaged'] = unpaged;
    _data['paged'] = paged;
    return _data;
  }
}

class Sort {
  Sort({
    required this.empty,
    required this.sorted,
    required this.unsorted,
  });
  late final bool empty;
  late final bool sorted;
  late final bool unsorted;
  
  Sort.fromJson(Map<String, dynamic> json){
    empty = json['empty'];
    sorted = json['sorted'];
    unsorted = json['unsorted'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['empty'] = empty;
    _data['sorted'] = sorted;
    _data['unsorted'] = unsorted;
    return _data;
  }
}