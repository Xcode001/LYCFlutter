import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_lyc/ui/home/repository/feature_articles_repository.dart';
import 'package:flutter_lyc/utils/configs.dart';
import 'package:flutter_lyc/ui/article/data/article.dart';

class FeatureArticlesDataRepository implements FeatureArticlesRepository {
  JsonDecoder _decoder = new JsonDecoder();
  String url = Configs.LYC_URL + Configs.VERSION_NO + "/";

  @override
  Future<List<Article>> getFeaturedArticles(String accessCode) async {
    http.Response response =
        await http.get(url + accessCode + '/article/feature');
    final responseBody = response.body;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || responseBody == null) {
      //throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.error}]");
      print(statusCode);
    }

    List jsonBody = _decoder.convert(responseBody);
    print('Feature Article Data$jsonBody');
    return jsonBody.map((a) => new Article.fromMap(a)).toList();
  }
}
