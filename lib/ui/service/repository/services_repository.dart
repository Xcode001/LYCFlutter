import 'dart:async';
import 'package:flutter_lyc/ui/service/data/health_service.dart';

abstract class ServicesRepository{
  Future<HealthService> getSubServices(String accessCode,int catId);
}