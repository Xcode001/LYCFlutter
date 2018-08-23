import 'package:flutter_lyc/ui/about/contract/about_contract.dart';
import 'package:flutter_lyc/ui/about/repository/about_repository.dart';
import 'package:flutter_lyc/injector.dart';

class AboutPresenter {
  AboutContract _view;
  AboutRepository _repository;

  AboutPresenter(this._view) {
    _repository = new Injector().aboutRepository;
  }

  void getContent(String accessCode) {
    _repository
        .getContent(accessCode)
        .then((c) => _view.showContent(c))
        .catchError((e) => print(e.toString()));
  }
}
