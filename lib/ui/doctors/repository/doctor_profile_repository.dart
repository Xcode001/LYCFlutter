import 'dart:async';
import 'package:flutter_lyc/base/data/message.dart';
import 'package:flutter_lyc/ui/doctors/data/doctor_profile.dart';

abstract class DoctorProfileRepository{
  Future<DoctorProfile> getDoctorProfile( String accessCode,int  doctorId);
  Future<Message> setFavorite(String accessCode, int doctorId);
  Future<Message> save(String accessCode,int  doctorId);
  Future<Message> cancelBooking(String accessCode, int doctorId, int bookingId);
  void deleteReview(String accessCode, int doctorID, int reviewid);
  Future<Message> setShareClick(String accessCode,int doctorid);
  void getComments(String accessCode, int doctorID,int perPage);
}