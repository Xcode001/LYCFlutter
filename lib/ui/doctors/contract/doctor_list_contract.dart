import 'package:flutter_lyc/base/data/pagination.dart';
import 'package:flutter_lyc/ui/doctors/data/search_result.dart';
import 'package:flutter_lyc/ui/doctors/data/doctor.dart';

abstract class DoctorListContract {
  void onLoadError();

  void showDoctorList(List<Doctor> doctors);

  void showDoctorProfile(int doctorId);

  void showPagination(Pagination pagination);

  void showMoreDoctorList(List<Doctor> doctors);

  void showMostRecentActiveDoctorList(List<Doctor> doctors);

  void showSearchResults(List<SearchResult> r);
}
