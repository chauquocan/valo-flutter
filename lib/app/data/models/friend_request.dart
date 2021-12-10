import 'dart:convert';

import 'page_model.dart';

class FriendRequestPage {
    FriendRequestPage({
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

    List<FriendRequest> content;
    Pageable pageable;
    bool last;
    int totalElements;
    int totalPages;
    int size;
    int number;
    Sort sort;
    bool first;
    int numberOfElements;
    bool empty;

    factory FriendRequestPage.fromRawJson(String str) => FriendRequestPage.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FriendRequestPage.fromJson(Map<String, dynamic> json) => FriendRequestPage(
        content: List<FriendRequest>.from(json["content"].map((x) => FriendRequest.fromJson(x))),
        pageable: Pageable.fromJson(json["pageable"]),
        last: json["last"],
        totalElements: json["totalElements"],
        totalPages: json["totalPages"],
        size: json["size"],
        number: json["number"],
        sort: Sort.fromJson(json["sort"]),
        first: json["first"],
        numberOfElements: json["numberOfElements"],
        empty: json["empty"],
    );

    Map<String, dynamic> toJson() => {
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
        "pageable": pageable.toJson(),
        "last": last,
        "totalElements": totalElements,
        "totalPages": totalPages,
        "size": size,
        "number": number,
        "sort": sort.toJson(),
        "first": first,
        "numberOfElements": numberOfElements,
        "empty": empty,
    };
}

class FriendRequest {
    FriendRequest({
        required this.id,
        required this.fromId,
        required this.toId,
        required this.sendAt,
    });

    String id;
    String fromId;
    String toId;
    DateTime sendAt;

    factory FriendRequest.fromRawJson(String str) => FriendRequest.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FriendRequest.fromJson(Map<String, dynamic> json) => FriendRequest(
        id: json["id"],
        fromId: json["fromId"],
        toId: json["toId"],
        sendAt:DateTime.parse(json["sendAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fromId": fromId,
        "toId": toId,
        "sendAt": sendAt.toIso8601String(),
    };
}


