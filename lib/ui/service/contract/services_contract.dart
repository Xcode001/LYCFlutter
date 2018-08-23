import 'package:flutter_lyc/ui/service/data/sub_service.dart';

abstract class ServicesContract{
  void showServices( List<SubService> services);
  void showServiceDetails();
}