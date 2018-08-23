import 'dart:async';
import 'package:flutter_lyc/ui/article/data/article.dart';

abstract class FeatureArticlesRepository {
  Future<List<Article>> getFeaturedArticles(String accessCode);
}
