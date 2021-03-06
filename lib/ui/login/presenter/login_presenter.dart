import 'package:flutter_lyc/ui/login/contract/login_contract.dart';
import 'package:flutter_lyc/ui/login/repository/login_repository.dart';
import 'package:flutter_lyc/injector.dart';

class LoginPresenter {
  LoginContract _view;
  LoginRepository _repository;

  LoginPresenter(this._view) {
    _repository = new Injector().loginRepository;
  }

  void sendAccessToken(String accessToken) {
    _repository.sendAccessToken(accessToken).then((a) {
      _view.saveDataToPrefs(a);
      _view.showLandingPage();
    }).catchError((e) => print(e.toString()));
  }
}
