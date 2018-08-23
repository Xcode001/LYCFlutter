import 'package:flutter_lyc/injector.dart';
import 'package:flutter_lyc/ui/service/contract/services_contract.dart';
import 'package:flutter_lyc/ui/service/repository/services_repository.dart';

class ServicePresenter {
  ServicesContract _view;
  ServicesRepository _repository;

  ServicePresenter(this._view) {
    _repository = new Injector().servicesRepository;
  }

  void getSubServices(String accessCode,int catId) {
    _repository
        .getSubServices(accessCode,catId)
        .then((s) => _view.showServices(s.subservice))
        .catchError((e) => print(e.toString()));
  }
}
