import 'package:flutter_lyc/ui/home/data/save.dart';
import 'package:flutter_lyc/base/data/pagination.dart';

abstract class UserActivityContract{
  void loadError(String e);
  void showUserActivities( List<Save> s);
  void showMoreUserActivities( List<Save> s);
  void setPagination( Pagination p);
}