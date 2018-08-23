import 'package:flutter_lyc/injector.dart';
import 'package:flutter_lyc/ui/service/contract/sub_services_details_contract.dart';
import 'package:flutter_lyc/ui/service/repository/sub_services_details_repository.dart';

class SubServicesDetailsPresenter {
  SubServicesDetailsContract _view;
  SubServicesDetailsRepository _repository;

  SubServicesDetailsPresenter(this._view) {
    _repository = new Injector().subServicesDetailsRepository;
  }

  void getSubServicesDetails(
      String accessCode, int serviceId, int subServiceId) {
    _repository
        .getServiceDetail(accessCode, serviceId, subServiceId)
        .then((sd) => _view.showServiceDetail(sd))
        .catchError((e) => print(e.toString()));
  }

  void getServices(String accessCode) {
    _repository
        .getServices(accessCode)
        .then((s) => _view.showServices(s))
        .catchError((e) => print(e.toString()));
  }

}
