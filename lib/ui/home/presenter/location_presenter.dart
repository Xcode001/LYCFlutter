import 'package:flutter_lyc/injector.dart';
import 'package:flutter_lyc/ui/home/data/location.dart';
import 'package:flutter_lyc/ui/home/data/sublocation.dart';
import 'package:flutter_lyc/ui/home/repository/location_repository.dart';
import 'package:flutter_lyc/ui/home/contract/location_contract.dart';

class LocationPresenter {
  LocationRepository _repository;
  LocationContract _view;

  LocationPresenter(this._view) {
    _repository = new Injector().locationRepository;
  }

  void getRegion(String accessCode) {
    _repository.getRegionList(accessCode).then((l) {
      _view.getCityList(l);
    }).catchError((e) => print(e.toString()));
  }

  void matchLocations(List<Location> regions, List<SubLocation> cities) {
    _repository
        .matchLocations(regions, cities)
        .then((s) => _view.showLocationList(s));
  }

  void getCityList(String accessCode, List<Location> regions) {
    _repository.getCityList(accessCode, regions).then((l) {
      _view.matchLocation(l);
    }).catchError((e) => print(e.toString()));
  }
}
