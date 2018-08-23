import 'package:flutter_lyc/ui/home/contract/user_booking_contract.dart';
import 'package:flutter_lyc/ui/home/repository/user_booking_repository.dart';
import 'package:flutter_lyc/injector.dart';

class UserBookingPresenter {
  UserBookingContract _view;
  UserBookingRepository _repository;

  UserBookingPresenter(this._view) {
    _repository = new Injector().userBookingRepository;
  }

  void getBookingList(String accessCode, int status, int page) {
    _repository.getBookingList(accessCode, status, page).then((b) {
      _view.showBookingList(b.data, status);
      _view.setPagination(b.pagination);
    }).catchError((e) => print('Error  is ${e.toString()}'));
  }

  void getMoreBookingList(String accessCode, int status, int page) {
    _repository.getMoreBookingList(accessCode, status, page).then((b) {
      _view.showMoreBookingList(b.data);
    }).catchError((e) => _view.onLoadError());
  }
}
