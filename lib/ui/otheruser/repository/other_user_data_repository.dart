import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_lyc/utils/configs.dart';
import 'package:flutter_lyc/ui/home/data/user_saved.dart';
import 'package:flutter_lyc/base/data/message.dart';
import 'package:flutter_lyc/ui/otheruser/repository/other_user_repository.dart';

class OtherUserDataRepository implements OtherUserRepository {
  JsonDecoder _decoder = new JsonDecoder();
  String url = Configs.LYC_URL + Configs.VERSION_NO + "/";

  @override
  Future<UserSaved> getUserActivities(String accessCode, int userId) async {
    http.Response response =
        await http.get(url + accessCode + '/user/' + userId.toString());
    final responseBody = response.body;
    final statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 300 || responseBody == null) {
      //throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.error}]");
      print('UserActivities Status code$statusCode');
    }
    final jsonBody = _decoder.convert(responseBody);

    return new UserSaved.fromJson(jsonBody);
  }

  @override
  Future<Message> setFavoriteDocotr(String accessCode, int doctorId) async {
    http.Response response = await http
        .get(url + accessCode + '/doctor/' + doctorId.toString() + '/favorite');
    final responseBody = response.body;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || responseBody == null) {
      //throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.error}]");
      print('Other User Doctor Favourite Status code$statusCode');
    }
    final jsonBody = _decoder.convert(responseBody);
    return new Message.fromMap(jsonBody);
  }

  @override
  Future<Message> saveDoctor(String accessCode, int doctorId) async{
    http.Response response = await http
        .get(url + accessCode + '/doctor/' + doctorId.toString() + '/save');
    final responseBody = response.body;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || responseBody == null) {
      //throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.error}]");
      print('Other User Doctor Save Status code$statusCode');
    }
    final jsonBody = _decoder.convert(responseBody);
    return new Message.fromMap(jsonBody);
  }

  @override
  Future<Message> setFavoriteArticle(String accessCode, int articleId) async{
    http.Response response = await http
        .get(url + accessCode + '/article/' + articleId.toString() + '/favorite');
    final responseBody = response.body;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || responseBody == null) {
      //throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.error}]");
      print('Other User Article Favourite Status code$statusCode');
    }
    final jsonBody = _decoder.convert(responseBody);
    return new Message.fromMap(jsonBody);
  }

  @override
  Future<Message> saveArticle(String accessCode, int articleId) async{
    http.Response response = await http
        .get(url + accessCode + '/article/' + articleId.toString() + '/save');
    final responseBody = response.body;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || responseBody == null) {
      //throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.error}]");
      print('Other User Article Save Status code$statusCode');
    }
    final jsonBody = _decoder.convert(responseBody);
    return new Message.fromMap(jsonBody);
  }

  @override
  Future<UserSaved> getMoreUserActivities(
      String accessCode, int userId, int page) async {
    http.Response response = await http.get(url +
        accessCode +
        '/user/' +
        userId.toString() +
        '?page=' +
        page.toString());
    final responseBody = response.body;
    final statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 300 || responseBody == null) {
      //throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.error}]");
      print('More UserActivities Status code$statusCode');
    }
    final jsonBody = _decoder.convert(responseBody);

    return new UserSaved.fromJson(jsonBody);
  }
}
