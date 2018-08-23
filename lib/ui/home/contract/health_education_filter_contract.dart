import 'package:flutter_lyc/ui/article/data/category.dart';

abstract class HealthEducationFilterContract {
  void showCategoryList(List<Category> c);

  void showContentType(int contentType);
}
