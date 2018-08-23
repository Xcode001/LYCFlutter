import 'dart:async';
import 'package:flutter_lyc/ui/about/data/about.dart';

abstract class AboutRepository {
  Future<About> getContent(String accessCode);
}
