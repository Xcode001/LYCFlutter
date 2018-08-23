import 'package:flutter_lyc/ui/comment/data/comment.dart';
import 'package:flutter_lyc/ui/article/data/article.dart';
abstract class VideoDetailsContract{
  void showArticle(Article a  ,   int commentCount);
  void showComments(Comment  c);
}