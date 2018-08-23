import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_lyc/utils/configs.dart';
import 'package:flutter_lyc/ui/home/repository/health_education_repository.dart';
import 'package:flutter_lyc/ui/article/data/health_edu.dart';
import 'package:flutter_lyc/ui/article/data/article.dart';

class HealthEducationDataRepository implements HealthEducationRepository {
  JsonDecoder _decoder = new JsonDecoder();
  String url = Configs.LYC_URL + Configs.VERSION_NO + "/";

  @override
  Future<HealthEducation> getArticles(
      String accessCode, int type, List<int> category, int page) async {
    String catList =
        category != null ? "&category[]=" + category.toString() : "";
    http.Response response = await http.get(url +
        accessCode +
        '/article' +
        '?type=' +
        type.toString() +
        catList +
        '&page=' +
        page.toString());
    final responseBody = response.body;
    final statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 300 || responseBody == null) {
      print(statusCode);
    }
    print('Article Response String$responseBody');
    final jsonBody = _decoder.convert(responseBody);
    var healthEducation = new HealthEducation.fromJson(jsonBody);
    return healthEducation;
  }

  @override
  Future<HealthEducation> getMoreArticle(
      String accessCode, int type, List<int> category, int page) async {
    http.Response response = await http.get(url +
        accessCode +
        '/article' +
        '?type=' +
        type.toString() +
        '&page=' +
        page.toString());
    final responseBody = response.body;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || responseBody == null) {
      //throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.error}]");
      print(statusCode);
    }

    print('Article Response String$responseBody');
    final jsonBody = _decoder.convert(responseBody);
    var healthEducation = new HealthEducation.fromJson(jsonBody);
    return healthEducation;
  }

  @override
  Future<List<Article>> getFeaturedArticles(String accessCode) {
    return null;
  }

  @override
  void setShareClick(String accessCode, int articleid) async {
    http.Response response = await http
        .post(url + accessCode + '/article/' + articleid.toString() + '/save');
    final responseBody = response.body;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || responseBody == null) {
      //throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.error}]");
      print(statusCode);
      return;
    }
    print('Article Share Response' + responseBody);
  }

  @override
  void setFavorite(String accessCode, int articleId) async {
    http.Response response = await http.post(
        url + accessCode + '/article/' + articleId.toString() + '/favorite');
    final responseBody = response.body;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || responseBody == null) {
      //throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.error}]");
      print(statusCode);
      return;
    }
    print('Article Favourite Response' + responseBody);
  }

  @override
  void saveArticle(String accessCode, int articleId) async {
    http.Response response = await http
        .post(url + accessCode + '/article/' + articleId.toString() + '/save');
    print('response Body$response');
    final responseBody = response.body;
    print('response Body$responseBody');
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || responseBody == null) {
      //throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.error}]");
      print(statusCode);
      return;
    }
    print('Article Save Response' + responseBody);
  }
}
