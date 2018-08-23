import 'package:flutter_lyc/ui/notification/contract/notification_contract.dart';
import 'package:flutter_lyc/ui/notification/repository/notification_repository.dart';
import 'package:flutter_lyc/injector.dart';

class NotificationPresenter {
  NotificationContract _view;
  NotificationRepository _repository;

  NotificationPresenter(this._view) {
    _repository = new Injector().notificationRepository;
  }

  void getNoti(String accessCode) {
    _repository.getNotifications(accessCode).then((n) {
      _view.showNotifications(n.data);
      _view.setPagination(n.pagination);
    }).catchError((e) => print(e.toString()));
  }

  void getMoreNoti(String accessCode, int page) {
    _repository.getMoreNotifications(accessCode, page).then((n) {
      _view.showMoreNotifications(n.data);
      _view.setPagination(n.pagination);
    }).catchError((e) => print(e.toString()));
  }
}
