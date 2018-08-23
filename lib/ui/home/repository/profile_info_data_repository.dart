import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_lyc/utils/configs.dart';
import 'package:flutter_lyc/ui/home/repository/profile_info_repository.dart';
import 'package:flutter_lyc/ui/home/data/profile_info.dart';

class ProfileInfoDataRepository implements ProfileInfoRepository {
  JsonDecoder _decoder = new JsonDecoder();
  String url = Configs.LYC_URL + Configs.VERSION_NO + "/";

  @override
  Future<ProfileInfo> getProfileInfo(String accessCode) async {
    http.Response response = await http.get(url + accessCode + '/account/info');
    final jsonBody = response.body;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      //throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.error}]");
      print(statusCode);
    }

    final responseBody = _decoder.convert(jsonBody);
    print('Get Profile Info >>$responseBody');
    return new ProfileInfo.fromMap(responseBody);
  }

  @override
  Future<ProfileInfo> updateProfileInfo(
      String accessCode, ProfileInfo profileInfo) async {
    Map lmap = {
      "name": profileInfo.name,
      "phone": profileInfo.phone,
      "location": profileInfo.locationId.toString(),
      "subLocation": profileInfo.subLocationId.toString(),
      "gender": profileInfo.gender.toString(),
      "birthday": profileInfo.dob
    };
    //String bodyData = JSON.encode(lmap);

    http.Response response = await http.post(
      url + accessCode + '/account/update',
      body: lmap,
    );
    final responseBody = response.body;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || responseBody == null) {
      //throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.error}]");
      print(statusCode);
    }
    var jsonBody = _decoder.convert(responseBody);
    print('Update Profile Image $responseBody');
    return new ProfileInfo.fromMap(jsonBody);
  }

  @override
  // ignore: missing_return
  Future<ProfileInfo> uploadProfilePhoto(
      String accessCode, String filePath) async {
    bool complete = false;
    var profileInfo;
    if (!complete) {
      var responseBody;
      String strUrl = url + accessCode + '/account/image';
      var uri = Uri.parse(strUrl);
      var request = new http.MultipartRequest("POST", uri);
      var multipartFile = await http.MultipartFile.fromPath("image", filePath);
      request.files.add(multipartFile);
      http.StreamedResponse response = await request.send();
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
        responseBody = _decoder.convert(value);
        profileInfo = new ProfileInfo.fromMap(responseBody);
        complete=true;
        return profileInfo;
      });
    } else {
      return profileInfo;
    }

    /*http.MultipartFile.fromPath("image", filePath).then((m) {
      request.files.add(m);
      request.send().then((res) {
        http.StreamedResponse response =res;
        response.stream.transform(utf8.decoder).listen((value) {
          print(value);
          responseBody = _decoder.convert(value);
          return new ProfileInfo.fromMap(responseBody);
        });
      });
    });*/
  }

  @override
  void removeAllData() {
    //MySharedPreferences.clear();
  }
}
