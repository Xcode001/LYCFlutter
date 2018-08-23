import 'package:flutter/material.dart';
import 'package:flutter_lyc/utils/mySharedPreferences.dart';
import 'package:flutter_lyc/utils/configs.dart';
import 'package:flutter_lyc/base/mystyle.dart';
import 'package:flutter_lyc/base/data/pagination.dart';
import 'package:flutter_lyc/ui/home/widget/create_article_buttons.dart';
import 'package:flutter_lyc/ui/home/widget/article_lists.dart';
import 'package:flutter_lyc/ui/home/presenter/health_education_presenter.dart';
import 'package:flutter_lyc/ui/home/contract/health_education_contract.dart';
import 'package:flutter_lyc/ui/article/data/article.dart';
import 'package:flutter_lyc/ui/article/widget/create_feature_article_items.dart';

class HealthEducationPage extends StatefulWidget {
  final String selectedCategory;

  HealthEducationPage(this.selectedCategory);

  @override
  HealthEducationPageState createState() {
    return new HealthEducationPageState();
  }
}

class HealthEducationPageState extends State<HealthEducationPage>
    implements HealthEducationContract, ArticleClickListener {
  HealthEducationPresenter mPresenter;
  List<Article> articles = new List<Article>();
  String accessCode;
  bool isGuest = false;
  bool isLogin = false;
  int scrollDirection = 0;
  ScrollController scrollController = new ScrollController();
  Pagination paginationData;
  MySharedPreferences mySharedPreferences = new MySharedPreferences();

  HealthEducationPageState() {
    mPresenter = new HealthEducationPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(listen);
    mySharedPreferences
        .getBooleanData(Configs.PREF_USER_LOGIN)
        .then((val) => setState(() {
              isLogin = val;
              _getAccessCode(isLogin);
            }));
  }

  _getAccessCode(bool login) {
    if (login) {
      isGuest = false;
      mySharedPreferences
          .getStringData(Configs.PREF_USER_ACCESS_CODE)
          .then((val) => setState(() {
                isGuest = false;
                accessCode = val;
                mPresenter.getArticles(accessCode, 0, null, null);
              }));
    } else {
      isGuest = true;
      accessCode = Configs.GUEST_CODE;
      mPresenter.getArticles(accessCode, 1, null, null);
    }
    print('islogin>>$isLogin And isGuest>>$isGuest');
  }

  Widget loadingIndicator = new Container(
      child: new CircularProgressIndicator(
    strokeWidth: 2.0,
  ));

  void _clickFilterButton(BuildContext context) async {
    await showDialog(
        context: this.context,
        builder: (BuildContext context) {
          return new SimpleDialog(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.only(
                    left: MyStyle.double20, top: MyStyle.double20),
                child: new GestureDetector(
                  child: new Text(
                    "All",
                    style: MyStyle.captionTextStyle(),
                    textAlign: TextAlign.start,
                  ),
                  onTap: () {
                  },
                ),
              ),
              new Padding(
                padding: const EdgeInsets.only(
                    left: MyStyle.double20, top: MyStyle.double20),
                child: new GestureDetector(
                  child: new Text(
                    "Article",
                    style: MyStyle.captionTextStyle(),
                    textAlign: TextAlign.left,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              new Padding(
                padding: const EdgeInsets.only(
                    left: MyStyle.double20, top: MyStyle.double20),
                child: new GestureDetector(
                  child: new Text(
                    "Video",
                    style: MyStyle.captionTextStyle(),
                    textAlign: TextAlign.left,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          );
        });
    setState(() {});
  }

  Widget showArticleList() {
    if (articles.length > 0) {
      return new ArticleLists(articles, paginationData, this);
    } else {
      return new Container(
        child: Center(child: loadingIndicator),
        height: 100.0,
      );
    }
  }

  void listen() {
    setState(() {
      scrollDirection = scrollController.position.userScrollDirection.index;
    });
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (paginationData.currentPage < paginationData.lastPage)
        mPresenter.getMoreArticles(
            accessCode, 0, null, paginationData.currentPage + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: MyStyle.colorWhite,
        title: new Text(widget.selectedCategory,style: MyStyle.appbarTitleStyle(),),
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context)),
      ),
      body: new Container(
        color: MyStyle.layoutBackground,
        padding: const EdgeInsets.all(MyStyle.double10),
        child: new Stack(
          children: <Widget>[
            new SingleChildScrollView(
              controller: scrollController,
              scrollDirection: Axis.vertical,
              child: new Container(
                margin: const EdgeInsets.only(top: MyStyle.double32),
                child: new Column(
                  children: <Widget>[
                    new CreateFeatureArticles(),
                    showArticleList()
                  ],
                ),
              ),
            ),
            new Opacity(
                //opacity: scrollDirection == 1 ? 1.0 : 0.0,
                opacity: 1.0,
                child: new Align(
                  alignment: FractionalOffset.topRight,
                  child: new Padding(
                    padding: const EdgeInsets.all(MyStyle.double10),
                    child: new Row(
                      children: <Widget>[
                        new Text('Featured'),
                        new Expanded(
                            child: new Row(
                          children: <Widget>[],
                        )),
                        new RaisedButton.icon(
                            color: Colors.white,
                            onPressed: () => _clickFilterButton(context),
                            icon: new Icon(
                              Icons.filter_list,
                              color: Colors.grey,
                            ),
                            label: new Text(
                              "FILTER",
                              style: new TextStyle(
                                  fontSize: MyStyle.font14, color: Colors.grey),
                            ),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0))),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  @override
  void setPagination(Pagination p) {
    paginationData = p;
  }

  @override
  void removeFeaturedArticles() {}

  @override
  void showFeaturedArticles(List<Article> a) {}

  @override
  void showMoreArticles(List<Article> a) {
    setState(() {
      articles.addAll(a);
    });
  }

  @override
  void showArticles(List<Article> a) {
    setState(() {
      articles.clear();
      articles = a;
    });
  }

  @override
  void showFilter() {}

  @override
  void onLoadError() {
    // TODO: implement onLoadError
  }

  @override
  void onChooseFilters(List<int> roleList) {
    mPresenter.getArticles(accessCode, 0, roleList, null);
  }

  @override
  void onArticleShareClick(Article article) {
    mPresenter.setShare(accessCode, article.id);
  }

  @override
  void onArticleFavClick(Article article) {
    mPresenter.setFavourite(accessCode, article.id);
  }

  @override
  void onArticleSaveClick(Article article) {
    mPresenter.saveArticle(accessCode, article.id);
  }

  @override
  void onArticleCommentClick(Article article) {}
}
