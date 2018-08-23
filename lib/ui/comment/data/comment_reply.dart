import 'package:flutter_lyc/base/data/pagination.dart';
import 'package:flutter_lyc/ui/comment/data/reply.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment_reply.g.dart';

@JsonSerializable()
class CommentReply extends Object with _$CommentReplySerializerMixin{
  Pagination pagination;
  List<Reply> data;

  CommentReply(this.pagination, this.data);


  factory CommentReply.fromJson(Map<String, dynamic> json) => _$CommentReplyFromJson(json);
}