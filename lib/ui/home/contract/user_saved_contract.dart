import 'package:flutter_lyc/base/data/pagination.dart';
import 'package:flutter_lyc/ui/home/data/save.dart';

abstract class UserSavedContract{
  void onLoadError(String err);
  void showSavedList(  List<Save> s);
  void showMoreSavedList(  List<Save> s);
  void setPagination(  Pagination p);
}