import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_lyc/utils/configs.dart';
import 'package:flutter_lyc/ui/home/data/user_booking.dart';
import 'package:flutter_lyc/ui/home/repository/user_booking_repository.dart';

class UserBookingDataRepository implements UserBookingRepository {
  JsonDecoder _decoder = new JsonDecoder();
  String url = Configs.LYC_URL + Configs.VERSION_NO + "/";

  @override
  Future<UserBooking> getBookingList(
      String accessCode, int status, int page) async {
    var _status = status == null ? "" : status.toString();

    print('Booking URL${url + accessCode + '/account/booking?status=' +
        _status}');
    http.Response response = await http
        .get(url + accessCode + '/account/booking?status=' + _status);
    final jsonBody = response.body;
    final statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      print('Doctor Status code$statusCode');
    }
    final responseBody = _decoder.convert(jsonBody);
    var userBooking = new UserBooking.fromJson(responseBody);
    print('Booking Response$userBooking');
    return userBooking;
  }

  @override
  Future<UserBooking> getMoreBookingList(
      String accessCode, int status, int page) async {
    var _status = status == null ? "" : status.toString();
    http.Response response = await http
        .get(url + accessCode + '/account/booking?status=' + _status);
    final jsonBody = response.body;
    final statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      print('Doctor Status code$statusCode');
    }
    final responseBody = _decoder.convert(jsonBody);
    var userBooking = new UserBooking.fromJson(responseBody);
    print('Booking Response$userBooking');
    return userBooking;
  }
}
