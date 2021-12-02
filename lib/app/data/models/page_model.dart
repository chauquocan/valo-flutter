import 'dart:convert';

class Pageable {
    Pageable({
        required this.sort,
        required this.offset,
        required this.pageNumber,
        required this.pageSize,
        required this.paged,
        required this.unpaged,
    });

    Sort sort;
    int offset;
    int pageNumber;
    int pageSize;
    bool paged;
    bool unpaged;

    factory Pageable.fromRawJson(String str) => Pageable.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Pageable.fromJson(Map<String, dynamic> json) => Pageable(
        sort: Sort.fromJson(json["sort"]),
        offset: json["offset"],
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        paged: json["paged"],
        unpaged: json["unpaged"],
    );

    Map<String, dynamic> toJson() => {
        "sort": sort.toJson(),
        "offset": offset,
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "paged": paged,
        "unpaged": unpaged,
    };
}

class Sort {
    Sort({
        required this.empty,
        required this.sorted,
        required this.unsorted,
    });

    bool empty;
    bool sorted;
    bool unsorted;

    factory Sort.fromRawJson(String str) => Sort.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Sort.fromJson(Map<String, dynamic> json) => Sort(
        empty: json["empty"],
        sorted: json["sorted"],
        unsorted: json["unsorted"],
    );

    Map<String, dynamic> toJson() => {
        "empty": empty,
        "sorted": sorted,
        "unsorted": unsorted,
    };
}
