import 'package:flutter_lyc/ui/home/contract/feature_articles_contract.dart';
import 'package:flutter_lyc/ui/home/repository/feature_articles_repository.dart';
import 'package:flutter_lyc/injector.dart';

class FeatureArticlesPresenter {
  FeatureArticlesContract _view;
  FeatureArticlesRepository _repository;

  FeatureArticlesPresenter(this._view) {
    _repository = new Injector().featureArticlesRepository;
  }

  void getFeatureArticles(String accessCode) {
    _repository
        .getFeaturedArticles(accessCode)
        .then((a) => _view.showFeaturedArticle(a))
        .catchError((_) => _view.onLoadError());
  }
}
