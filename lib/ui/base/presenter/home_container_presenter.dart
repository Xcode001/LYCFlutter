import 'package:flutter_lyc/injector.dart';
import 'package:flutter_lyc/utils/mySharedPreferences.dart';
import 'package:flutter_lyc/utils/configs.dart';
import 'package:flutter_lyc/ui/base/contract/home_container_contract.dart';
import 'package:flutter_lyc/ui/base/repository/home_container_repository.dart';

class HomeContainerPresenter {
  HomeContainerRepository _repository;
  HomeContainerContract _view;
  MySharedPreferences mySharedPreferences = new MySharedPreferences();

  HomeContainerPresenter(this._view) {
    _repository = new Injector().homeContainerRepository;
  }

  void getSiteInfo(String accessCode) {
    _repository.getSiteInfo(accessCode).then((si) {
      _view.showSiteInfo(si);
      mySharedPreferences.putStringData(Configs.PREF_LYC_LOGO, si.logo);
      mySharedPreferences.putStringData(
          Configs.PREF_LYC_ADDRESS, si.address.address);
      mySharedPreferences.putDoubleData(Configs.PREF_LYC_LAT, si.address.lat);
      mySharedPreferences.putDoubleData(Configs.PREF_LYC_LON, si.address.lng);
      mySharedPreferences.putStringData(Configs.PREF_PHONE_ONE, si.phone[0]);
      mySharedPreferences.putStringData(
          Configs.PREF_PHONE_TWO, si.phone.length == 2 ? si.phone[2] : "");
    }).catchError((e) => print(e.toString()));
  }

  void getUnreadStatus(String accessCode) {
    _repository.getUnreadStatus(accessCode).then((us) {
      _view.showUnreadStatus(us);
    }).catchError((e) => print(e.toString()));
  }

  void getProfileInfo(String accessCode) {
    _repository.getProfileInfo(accessCode).then((pi) {
      _view.showEnterPhoneNo();
    }).catchError((e) => print(e.toString()));
  }

  void updateUserPhoneNo(String accessCode, String phoneNo) {
    _repository.updateUserPhoneNo(accessCode, phoneNo).then((pi) {
      //_view.showEnterPhoneNo();
    }).catchError((e) => print(e.toString()));
  }
}
