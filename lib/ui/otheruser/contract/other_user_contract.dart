import 'package:flutter_lyc/base/data/pagination.dart';
import 'package:flutter_lyc/ui/home/data/save.dart';
import 'package:flutter_lyc/base/contract/basecontract.dart';

abstract class OtherUserContract extends BaseContract{
  void showUserActivities(  List<Save> s);
  void showMoreUserActivities(  List<Save> s);
  void pagination(  Pagination p);
}