import 'dart:async';
import 'package:flutter_lyc/ui/comment/data/comment.dart';
import 'package:flutter_lyc/ui/comment/data/review.dart';
import 'package:flutter_lyc/base/data/message.dart';
import 'package:flutter_lyc/ui/comment/data/reply.dart';

abstract class CommentRepository{

  //There methods are used for doctor reviews
  Future<Comment> getComments( String accessCode  ,  int doctorID );
  Future<Comment> getMoreComments( String accessCode  ,  int doctorID , int  page);
  Future<Review> submitReview( String accessCode  ,  int doctorID ,  String mesg);
  Future<Message> deleteReview( String accessCode  ,  int doctorID ,  int  reviewid);
  Future<Message> deleteReplyOfReview( String accessCode  ,  int doctorID ,  int  reviewid,  int  replyId);

  //These methods are used for article comments
  Future<Comment> getArticleComments( String accessCode  ,  int  articleId);
  Future<Comment> getMoreArticleComments( String accessCode  ,  int  articleId,  int  page);
  Future<Review> submitArticleComment( String accessCode  ,  int  articleId,  String mesg);
  Future<Reply> submitArticleCommentReply( String accessCode  ,  int  articleId,  int  commentId,  String mesg,  int  replyId);
  Future<Message> deleteArticleComment( String accessCode  ,  int  articleId,  int  commentId);
  Future<Message> deleteArticleCommentReply( String accessCode  ,  int  articleId,  int  commentId,  int  replyId);
  
}