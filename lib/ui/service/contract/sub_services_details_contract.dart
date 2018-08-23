import 'package:flutter_lyc/ui/service/data/sub_service_details.dart';
import 'package:flutter_lyc/ui/service/data/service.dart';

abstract class SubServicesDetailsContract {
  void showServiceDetail(SubServiceDetails s);

  void showServices(List<Service> s);

  void showServicePicker();

  void showServiceDialog();

  void hideServiceDialog();
}
