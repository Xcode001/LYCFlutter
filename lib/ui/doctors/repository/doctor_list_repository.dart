import 'dart:async';
import 'package:flutter_lyc/ui/doctors/data/doctors.dart';
import 'package:flutter_lyc/base/data/message.dart';

abstract class DoctorListRepository {
  Future<Doctors> getDoctorList(
      String accessCode, List<int> roles, int perPage, String keyword);

  Future<Doctors> getMoreDoctorList(String accessCode, List<int> roles, int perpage,
      int page, String keyword);

  Future<Message> saveDoctor(String accessCode, int doctorId);

  Future<Message> setDoctorAsFavorite(String accessCode, int doctorId);

  Future<Doctors> getMostRecentActiveDoctorList(
      String accessCode, List<int> roles, int perPage);

  void searchDoctor(String accessCode, String keyword);

  Future<Message> setShareClick(String accessCode, int doctorId);
}
