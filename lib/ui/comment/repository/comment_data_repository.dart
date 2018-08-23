import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_lyc/utils/configs.dart';
import 'package:flutter_lyc/ui/comment/repository/comment_repository.dart';
import 'package:flutter_lyc/ui/comment/data/comment.dart';
import 'package:flutter_lyc/base/data/message.dart';
import 'package:flutter_lyc/ui/comment/data/reply.dart';
import 'package:flutter_lyc/ui/comment/data/review.dart';

class CommentDataRepository implements CommentRepository {
  JsonDecoder _decoder = new JsonDecoder();
  String url = Configs.LYC_URL + Configs.VERSION_NO + "/";

  @override
  Future<Comment> getArticleComments(String accessCode, int articleId) async {
    print('URL ${url + accessCode + '/article/' + articleId.toString() +
        '/comment?perpage=10'}');
    http.Response response = await http.get(url +
        accessCode +
        '/article/' +
        articleId.toString() +
        '/comment?perpage=10');
    final responseBody = response.body;
    final statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 300 || responseBody == null) {
      //throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.error}]");
      print(statusCode);
    }
    final jsonBody = _decoder.convert(responseBody);
    var comment = new Comment.fromJson(jsonBody);
    print('Article Comment Data${comment.toString()}');
    return comment;
  }

  @override
  Future<Comment> getMoreArticleComments(
      String accessCode, int articleId, int page) async {
    http.Response response = await http.get(url +
        accessCode +
        '/article/' +
        articleId.toString() +
        '/comment?perpage=10&page=' +
        page.toString());
    final responseBody = response.body;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || responseBody == null) {
      //throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.error}]");
      print(statusCode);
    }
    final jsonBody = _decoder.convert(responseBody);
    var comment = new Comment.fromJson(jsonBody);
    print('Article Comment Data${comment.toString()}');
    return comment;
  }

  @override
  Future<Message> deleteArticleComment(
      String accessCode, int articleId, int commentId) async {
    print('URL ${url + accessCode + '/article/' + articleId.toString() +
        '/comment/' + commentId.toString()}');
    http.Response response = await http.delete(url +
        accessCode +
        '/article/' +
        articleId.toString() +
        '/comment/' +
        commentId.toString());
    final responseBody = response.body;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || responseBody == null) {
      //throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.error}]");
      print(statusCode);
    }
    final jsonBody = _decoder.convert(responseBody);
    var message = new Message.fromMap(jsonBody);
    print('Doctor Comment Data${message.toString()}');
    return message;
  }

  @override
  Future<Message> deleteArticleCommentReply(
      String accessCode, int articleId, int commentId, int replyId) async {
    print('URL ${url + accessCode + '/article/' + articleId.toString() +
        '/comment/' + commentId.toString()}');
    http.Response response = await http.delete(url +
        accessCode +
        '/article/' +
        articleId.toString() +
        '/comment/' +
        commentId.toString() +
        'reply/' +
        replyId.toString());
    final responseBody = response.body;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || responseBody == null) {
      //throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.error}]");
      print(statusCode);
    }
    final jsonBody = _decoder.convert(responseBody);
    var message = new Message.fromMap(jsonBody);
    print('Delete Article Comment Reply:${message.toString()}');
    return message;
  }

  @override
  Future<Review> submitArticleComment(
      String accessCode, int articleId, String mesg) async {
    print('URL ${url + accessCode + '/article/' + articleId.toString() +
        '/comment?mesg=' + mesg}');
    http.Response response = await http.post(url +
        accessCode +
        '/article/' +
        articleId.toString() +
        '/comment?mesg=' +
        mesg);
    final responseBody = response.body;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || responseBody == null) {
      //throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.error}]");
      print(statusCode);
    }
    final jsonBody = _decoder.convert(responseBody);
    var review = new Review.fromJson(jsonBody);
    print('Submit Article Comment:${review.toString()}');
    return review;
  }

  @override
  Future<Reply> submitArticleCommentReply(String accessCode, int articleId,
      int commentId, String mesg, int replyId) async {
    print('URL ${url + accessCode + '/article/' + articleId.toString() +
        '/comment?mesg=' + mesg}');
    http.Response response = await http.post(url +
        accessCode +
        '/article/' +
        articleId.toString() +
        '/comment/' +
        commentId.toString() +
        '/reply?mesg=' +
        mesg);
    final responseBody = response.body;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || responseBody == null) {
      //throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.error}]");
      print(statusCode);
    }
    final jsonBody = _decoder.convert(responseBody);
    var reply = new Reply.fromJson(jsonBody);
    print('Submit Article Comment Reply:${reply.toString()}');
    return reply;
  }

  @override
  Future<Comment> getComments(String accessCode, int doctorID) async {
    print('URL ${url + accessCode + '/doctor/' + doctorID.toString() +
        '/review?perpage=10'}');
    http.Response response = await http.get(url +
        accessCode +
        '/doctor/' +
        doctorID.toString() +
        '/review?perpage=10');
    final responseBody = response.body;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || responseBody == null) {
      //throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.error}]");
      print(statusCode);
    }
    final jsonBody = _decoder.convert(responseBody);
    var comment = new Comment.fromJson(jsonBody);
    print('Doctor Comment Data${comment.toString()}');
    return comment;
  }

  @override
  Future<Comment> getMoreComments(
      String accessCode, int doctorID, int page) async {
    http.Response response = await http.get(url +
        accessCode +
        '/doctor/' +
        doctorID.toString() +
        '/review?perpage=10&page=' +
        page.toString());
    final responseBody = response.body;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || responseBody == null) {
      //throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.error}]");
      print(statusCode);
    }
    final jsonBody = _decoder.convert(responseBody);
    var comment = new Comment.fromJson(jsonBody);
    print('Doctor Comment Data${comment.toString()}');
    return comment;
  }

  @override
  Future<Message> deleteReview(
      String accessCode, int doctorID, int reviewid) async {
    print('URL ${url + accessCode + '/doctor/' + doctorID.toString() +
        '/review/' + reviewid.toString()}');
    http.Response response = await http.delete(url +
        accessCode +
        '/doctor/' +
        doctorID.toString() +
        '/review/' +
        reviewid.toString());
    final responseBody = response.body;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || responseBody == null) {
      //throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.error}]");
      print(statusCode);
    }
    final jsonBody = _decoder.convert(responseBody);
    var message = new Message.fromMap(jsonBody);
    print('Doctor Review Message${message.toString()}');
    return message;
  }

  @override
  Future<Message> deleteReplyOfReview(
      String accessCode, int doctorID, int reviewid, int replyId) async {
    print('URL ${url + accessCode + '/doctor/' + doctorID.toString() +
        '/review/' + reviewid.toString()}');
    http.Response response = await http.delete(url +
        accessCode +
        '/doctor/' +
        doctorID.toString() +
        '/review/' +
        reviewid.toString() +
        '/reply/' +
        replyId.toString());
    final responseBody = response.body;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || responseBody == null) {
      //throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.error}]");
      print(statusCode);
    }
    final jsonBody = _decoder.convert(responseBody);
    var message = new Message.fromMap(jsonBody);
    print('Doctor Review Message${message.toString()}');
    return message;
  }

  @override
  Future<Review> submitReview(
      String accessCode, int doctorID, String mesg) async {
    print('URL ${url + accessCode + '/doctor/' + doctorID.toString() +
        '/review?mesg=' + mesg}');
    http.Response response = await http.post(url +
        accessCode +
        '/doctor/' +
        doctorID.toString() +
        '/review?mesg=' +
        mesg);
    final responseBody = response.body;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || responseBody == null) {
      //throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.error}]");
      print(statusCode);
    }
    final jsonBody = _decoder.convert(responseBody);
    var review = new Review.fromJson(jsonBody);
    print('Doctor Review Message${review.toString()}');
    return review;
  }
}
