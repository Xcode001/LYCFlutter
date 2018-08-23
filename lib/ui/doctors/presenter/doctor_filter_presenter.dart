import 'package:flutter_lyc/injector.dart';
import 'package:flutter_lyc/ui/doctors/contract/doctor_filter_contract.dart';
import 'package:flutter_lyc/ui/doctors/repository/doctor_filter_repository.dart';

class DoctorFilterPresenter {
  DoctorFilterContract _view;
  DoctorFilterRepository _repository;

  DoctorFilterPresenter(this._view) {
    _repository = new Injector().doctorFilterRepository;
  }

  void getDoctorRole(String accessCode) {
    _repository
        .getRoles(accessCode)
        .then((dr) => _view.showRoles(dr))
        .catchError((e) => print(e.toString()));
  }
}
