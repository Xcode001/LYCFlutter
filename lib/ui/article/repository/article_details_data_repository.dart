import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_lyc/utils/configs.dart';
import 'package:flutter_lyc/ui/article/repository/article_details_repository.dart';
import 'package:flutter_lyc/ui/article/data/article_details.dart';
import 'package:flutter_lyc/ui/comment/data/comment.dart';
import 'package:flutter_lyc/base/data/message.dart';

class ArticleDetailsDataRepository implements ArticleDetailsRepository{
  String url = Configs.LYC_URL + Configs.VERSION_NO + "/";
  JsonDecoder _decoder = new JsonDecoder();
  @override
  Future<ArticleDetails> getArticleDetail(String accessCode, int articleId) async{
    http.Response response=await http.get(url+accessCode+'/article/'+articleId.toString());
    final jsonBody=response.body;
    final statusCode=response.statusCode;
    if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      //throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.error}]");
      print(statusCode);
    }
    final responseBody=_decoder.convert(jsonBody);
    var articleDetails=new ArticleDetails.fromJson(responseBody);
    return articleDetails;
  }

  @override
  Future<Comment> getComments(String accessCode, int articleId, int perPage) async{
    http.Response response=await http.get(url+accessCode+'/article/'+articleId.toString()+'/comment');
    final jsonBody=response.body;
    final statusCode=response.statusCode;
    if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      //throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.error}]");
      print(statusCode);
    }
    final responseBody=_decoder.convert(jsonBody);
    print('comment Response$responseBody');
    var comment=new Comment.fromJson(responseBody);
    return comment;
  }

  @override
  Future<Message> setShareClick(String accessCode, int articleid) async{
    http.Response response=await http.post(url+accessCode+'/article'+articleid.toString()+'/share');
    final responseBody=response.body;
    final statusCode=response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || response == null) {
      //throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.error}]");
      print(statusCode);

    }
    final jsonBody=_decoder.convert(responseBody);
    print('Response Favourite$jsonBody');
    return new Message.fromMap(jsonBody);
  }

  @override
  Future<Message> deleteArticleComment(String accessCode, int articleId, int commentId) {
    return null;
  }

  @override
  Future<Message> setFavorite(String accessCode, int articleId) async{
    http.Response response=await http.post(url+accessCode+'/article'+articleId.toString()+'/favorite');
    final responseBody=response.body;
    final statusCode=response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || response == null) {
      //throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.error}]");
      print(statusCode);

    }
    final jsonBody=_decoder.convert(responseBody);
    print('Response Favourite$jsonBody');
    return new Message.fromMap(jsonBody);
  }

  @override
  Future<Message> saveArticle(String accessCode, int articleId) async{
    http.Response response=await http.post(url+accessCode+'/article'+articleId.toString()+'/save');
    final responseBody=response.body;
    final statusCode=response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || response == null) {
      //throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.error}]");
      print(statusCode);
    }
    final jsonBody=_decoder.convert(responseBody);
    print('Response Favourite$jsonBody');
    return new Message.fromMap(jsonBody);
  }
}