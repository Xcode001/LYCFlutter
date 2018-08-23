import 'dart:async';
import 'package:flutter_lyc/ui/service/data/sub_service_details.dart';
import 'package:flutter_lyc/ui/service/data/service.dart';

abstract class SubServicesDetailsRepository {
  Future<SubServiceDetails> getServiceDetail(
      String accessCode, int serviceId, int subServiceId);

  Future<List<Service>> getServices(String accessCode);
}
