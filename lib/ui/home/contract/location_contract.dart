import 'package:flutter_lyc/ui/home/data/region.dart';
import 'package:flutter_lyc/ui/home/data/location.dart';
import 'package:flutter_lyc/ui/home/data/sublocation.dart';

abstract class LocationContract{
  void showLocationList(List<Region> l);
  void getCityList(List<Location> l);
  void matchLocation(List<SubLocation> sl);
}