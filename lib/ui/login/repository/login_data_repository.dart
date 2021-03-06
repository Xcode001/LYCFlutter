import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_lyc/utils/configs.dart';
import 'package:flutter_lyc/ui/login/data/account.dart';
import 'package:flutter_lyc/ui/login/repository/login_repository.dart';

class LoginDataRepository implements LoginRepository {
  JsonDecoder _decoder = new JsonDecoder();
  String url = Configs.LYC_URL + Configs.VERSION_NO + "/";

  @override
  Future<Account> sendAccessToken(String accessToken) async {
    http.Response response =
        await http.get(url + 'account/check?code=' + accessToken);
    final jsonBody = response.body;
    final statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      //throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.error}]");
      print('Send Token Status code$statusCode');
    }
    final responseBody = _decoder.convert(jsonBody);
    print('Response Access Token$responseBody');
    return new Account.fromMap(responseBody);
  }
}
