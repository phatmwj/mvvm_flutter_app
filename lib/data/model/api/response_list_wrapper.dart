import 'ApiStatus.dart';

class ResponseListWrapper<T>{
  List<T>? content;
  int? page;
  int? totalPages;
  int? totalElements;

  ResponseListWrapper(
      {this.content, this.page, this.totalPages, this.totalElements});

  factory ResponseListWrapper.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    return ResponseListWrapper(
      content: (json['content'] as List<dynamic>?)?.map((e) => fromJsonT(e)).toList(),
      page: json['page'] as int?,
      totalPages: json['totalPages'] as int?,
      totalElements: json['totalElements'] as int?,
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['totalPages'] = totalPages;
    data['totalElements'] = totalElements;
    data['content'] = content!.map((e) => toJsonT(e)).toList();
    return data;
  }

}