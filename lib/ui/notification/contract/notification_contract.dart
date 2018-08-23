import 'package:flutter_lyc/base/data/pagination.dart';
import 'package:flutter_lyc/ui/notification/data/data.dart';

abstract class NotificationContract{
  void showNotifications( List<Data> n);
  void showMoreNotifications( List<Data> n);
  void setPagination( Pagination p);
}