import 'dart:async';
import 'package:flutter_lyc/ui/article/data/category.dart';

abstract class HealthEducationFilterRepository{
  Future<List<Category>> getCategoryList( String accessCode);
  //void getContentType(int contentType);
}