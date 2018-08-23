import 'package:flutter_lyc/ui/article/data/article.dart';

abstract class FeatureArticlesContract{
  void onLoadError();
  void showFeaturedArticle(List<Article> a);
  void removeFeaturedArticle();
}