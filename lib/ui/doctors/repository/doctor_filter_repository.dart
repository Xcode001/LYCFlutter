import 'dart:async';
import 'package:flutter_lyc/ui/doctors/data/doctor_role.dart';

abstract class DoctorFilterRepository{
  Future<List<DoctorRole>> getRoles(String accessCode);
}