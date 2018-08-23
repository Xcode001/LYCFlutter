import 'dart:async';
import 'package:flutter_lyc/ui/article/data/article_details.dart';
import 'package:flutter_lyc/ui/comment/data/comment.dart';
import 'package:flutter_lyc/base/data/message.dart';

abstract class VideoDetailsRepository{
  Future<ArticleDetails> getArticleDetail(String accessCode, int articleId);

  Future<Message> saveArticle(String accessCode, int articleId);

  Future<Message> setFavorite(String accessCode, int articleId);

  Future<Message> deleteArticleComment(String accessCode, int articleId, int commentId);

  Future<Message> setShareClick(String accessCode, int articleid);

  Future<Comment> getComments(String accessCode, int articleId, int perPage);
}