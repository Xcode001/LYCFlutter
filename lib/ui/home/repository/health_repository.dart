import 'dart:async';
import 'package:flutter_lyc/ui/service/data/service.dart';
import 'package:flutter_lyc/ui/service/data/health_service.dart';
import 'package:flutter_lyc/ui/service/data/sub_service_details.dart';

abstract class HealthRepository {
  Future<List<Service>> getServices(String accessCode);
  Future<List<HealthService>> getSubServices(String accessCode,int serviceId);
  Future<List<SubServiceDetails>> getServiceDetail(String accessCode,int serviceId,int subServiceId);
}
