import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_lyc/utils/configs.dart';
import 'package:flutter_lyc/ui/doctors/repository/doctor_filter_repository.dart';
import 'package:flutter_lyc/ui/doctors/data/doctor_role.dart';

class DoctorFilterDataRepository implements DoctorFilterRepository {
  JsonDecoder _decoder = new JsonDecoder();
  String url = Configs.LYC_URL + Configs.VERSION_NO + "/";

  @override
  Future<List<DoctorRole>> getRoles(String accessCode) async {
    http.Response response = await http.get(url + accessCode + '/doctor/role');
    final responseBody = response.body;
    final statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 300 || responseBody == null) {
      //throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.error}]");
      print(statusCode);
    }
    List jsonBody = _decoder.convert(responseBody);
    return jsonBody.map((dr) => new DoctorRole.fromMap(dr)).toList();
  }
}
