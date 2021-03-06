import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_lyc/utils/configs.dart';
import 'package:flutter_lyc/base/data/message.dart';
import 'package:flutter_lyc/ui/doctors/repository/doctor_profile_repository.dart';
import 'package:flutter_lyc/ui/doctors/data/doctor_profile.dart';

class DoctorProfileDataRepository implements DoctorProfileRepository {
  JsonDecoder _decoder = new JsonDecoder();
  String url = Configs.LYC_URL + Configs.VERSION_NO + "/";

  @override
  Future<DoctorProfile> getDoctorProfile(
      String accessCode, int doctorId) async {
    http.Response response =
        await http.get(url + accessCode + '/doctor/' + doctorId.toString());

    final responseBody = response.body;
    final statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 300 || responseBody == null) {
      //throw new FetchDataException("Error while getting contacts [statusCode:$statusCode, Error:${response.error}]");
      print('Doctor Status code$statusCode');
    }
    final jsonBody = _decoder.convert(responseBody);
    //print('Response pDoctor Profile${new DoctorProfile.fromJson(json)}');
    var dp = new DoctorProfile.fromJson(jsonBody);
    print('Booking Profile Data $dp');
    //return responseBody((dp) => new DoctorProfile.fromJson(dp));
    return dp;
  }

  @override
  void getComments(String accessCode, int doctorID, int perPage) {}

  @override
  Future<Message> setShareClick(String accessCode, int doctorid) async {
    http.Response response = await http
        .post(url + accessCode + '/doctor/' + doctorid.toString() + '/share');
    final responseBody = response.body;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || responseBody == null) {
      //throw new FetchDataException("Error while getting contacts [statusCode:$statusCode, Error:${response.error}]");
      print('Doctor Status code$statusCode');
    }
    final jsonBody = _decoder.convert(responseBody);
    return new Message.fromMap(jsonBody);
  }

  @override
  void deleteReview(String accessCode, int doctorId, int reviewid) async {
    http.Response response = await http
        .post(url + accessCode + '/doctor/' + doctorId.toString() + '/share');
    final responseBody = response.body;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || responseBody == null) {
      //throw new FetchDataException("Error while getting contacts [statusCode:$statusCode, Error:${response.error}]");
      print('Doctor Status code$statusCode');
    }
  }

  @override
  Future<Message> cancelBooking(
      String accessCode, int doctorId, int bookingId) async {
    http.Response response = await http.delete(url +
        accessCode +
        '/doctor/' +
        doctorId.toString() +
        '/booking/' +
        bookingId.toString());
    final responseBody = response.body;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || responseBody == null) {
      //throw new FetchDataException("Error while getting contacts [statusCode:$statusCode, Error:${response.error}]");
      print('Doctor Status code$statusCode');
    }
    final jsonBody = _decoder.convert(responseBody);
    return new Message.fromMap(jsonBody);
  }

  @override
  Future<Message> save(String accessCode, int doctorId) async {
    http.Response response = await http
        .post(url + accessCode + '/doctor/' + doctorId.toString() + '/save');
    final responseBody = response.body;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || responseBody == null) {
      //throw new FetchDataException("Error while getting contacts [statusCode:$statusCode, Error:${response.error}]");
      print('Doctor Status code$statusCode');
    }
    final jsonBody = _decoder.convert(responseBody);
    return new Message.fromMap(jsonBody);
  }

  @override
  Future<Message> setFavorite(String accessCode, int doctorId) async {
    http.Response response = await http.post(
        url + accessCode + '/doctor/' + doctorId.toString() + '/favorite');
    final responseBody = response.body;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || responseBody == null) {
      //throw new FetchDataException("Error while getting contacts [statusCode:$statusCode, Error:${response.error}]");
      print('Doctor Status code$statusCode');
    }
    final jsonBody = _decoder.convert(responseBody);
    return new Message.fromMap(jsonBody);
  }
}
