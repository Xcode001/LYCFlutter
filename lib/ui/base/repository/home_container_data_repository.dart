import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_lyc/utils/configs.dart';
import 'package:flutter_lyc/ui/base/repository/home_container_repository.dart';
import 'package:flutter_lyc/ui/base/data/site_info.dart';
import 'package:flutter_lyc/ui/base/data/unread_status.dart';
import 'package:flutter_lyc/ui/home/data/profile_info.dart';

class HomeContainerDataRepository implements HomeContainerRepository {
  JsonDecoder _decoder = new JsonDecoder();
  String url = Configs.LYC_URL + Configs.VERSION_NO + "/";

  @override
  Future<SiteInfo> getSiteInfo(String accessCode) async {
    http.Response response = await http.get(url + accessCode + '/siteinfo');
    var responseBody = response.body;
    var statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 300 || responseBody == null) {
      //throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.error}]");
      print(statusCode);
    }

    var jsonBody = _decoder.convert(responseBody);
    print(jsonBody);
    return SiteInfo.fromJson(jsonBody);
  }

  @override
  Future<ProfileInfo> updateUserPhoneNo(String accessCode, String phone) async {
    http.Response response =
        await http.post(url + accessCode + '/account/update/phone?$phone');
    var responseBody = response.body;
    var statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 300 || responseBody == null) {
      //throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.error}]");
      print(statusCode);
    }

    var jsonBody = _decoder.convert(responseBody);
    return ProfileInfo.fromMap(jsonBody);
  }

  @override
  Future<ProfileInfo> getProfileInfo(String accessCode) async {
    http.Response response = await http.get(url + accessCode + '/account/info');
    var responseBody = response.body;
    var statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 300 || responseBody == null) {
      //throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.error}]");
      print(statusCode);
    }

    var jsonBody = _decoder.convert(responseBody);
    return ProfileInfo.fromMap(jsonBody);
  }

  @override
  Future<UnreadStatus> getUnreadStatus(String accessCode) async {
    http.Response response =
        await http.get(url + accessCode + '/notification/checkunread');
    var responseBody = response.body;
    var statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 300 || responseBody == null) {
      //throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.error}]");
      print(statusCode);
    }

    var jsonBody = _decoder.convert(responseBody);
    return UnreadStatus.fromMap(jsonBody);
  }
}
