import 'package:json_annotation/json_annotation.dart';

part 'pagination.g.dart';

@JsonSerializable(includeIfNull: false)
class Pagination extends Object with _$PaginationSerializerMixin {
  int from;
  int total;
  int currentPage;
  int lastPage;

  Pagination(this.from, this.total, this.currentPage, this.lastPage);

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  @override
  String toString() {
    return 'Pagination{from: $from, total: $total, currentPage: $currentPage, lastPage: $lastPage}';
  }
}
