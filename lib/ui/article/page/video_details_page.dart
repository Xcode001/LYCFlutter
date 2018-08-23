import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_lyc/base/mystyle.dart';
import 'package:flutter_lyc/base/widget/base_widget.dart';
import 'package:flutter_lyc/base/widget/custom_bottom_navigation_bar.dart';
import 'package:flutter_lyc/utils/mySharedPreferences.dart';
import 'package:flutter_lyc/utils/configs.dart';
import 'package:flutter_lyc/ui/article/contract/video_details_contract.dart';
import 'package:flutter_lyc/ui/article/presenter/video_details_presenter.dart';
import 'package:flutter_lyc/ui/article/widget/video_details_item.dart';
import 'package:flutter_lyc/ui/article/data/article.dart';
import 'package:flutter_lyc/ui/comment/page/comment_page.dart';
import 'package:flutter_lyc/ui/comment/widget/create_comment_items.dart';
import 'package:flutter_lyc/ui/comment/data/comment.dart';

class VideoDetailsPage extends StatefulWidget {
  final int id;
  final bool isFeature;

  VideoDetailsPage(this.id, {this.isFeature = false});

  @override
  VideoDetailsPageState createState() {
    return new VideoDetailsPageState();
  }
}

class VideoDetailsPageState extends State<VideoDetailsPage>
    implements VideoDetailsContract {
  VideoDetailsPresenter mPresenter;
  Article article;
  Comment comment;
  bool isBookmark = false;
  bool isFav = false;
  bool isGuest = true;
  bool isLoading = true;
  bool isLogin = false;
  String accessCode;
  MySharedPreferences mySharedPreferences = new MySharedPreferences();
  String html =
      "<iframe height=\"300\" scr=\"https://www.youtube.com/embed/zzAabT7I0d0\"/>";

  //"<iframe width=\"300\" height=\"200\" src=\"https://www.youtube.com/embed/zzAabT7I0d0\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe>";

  VideoDetailsPageState() {
    mPresenter = new VideoDetailsPresenter(this);
  }

  _clickBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  _clickBookmark(BuildContext context) {
    if (!isGuest) {
      setState(() {
        isBookmark = !isBookmark;
      });
      mPresenter.saveArticle(accessCode, article.id);
    } else {
      BaseWidgets.showLoginDialog(context);
    }
  }

  _clickShare(BuildContext context) {
    Share.share(article.shareUrl);
  }

  _clickFloatingButton(BuildContext context) {
    if (!isGuest) {
      setState(() {
        isFav = !isFav;
      });
      mPresenter.setFavorite(accessCode, article.id);
    } else {
      BaseWidgets.showLoginDialog(context);
    }
  }

  _clickComment(BuildContext context) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (_) => new CommentPage(article.id, true, null)));
  }

  @override
  void initState() {
    super.initState();
    mySharedPreferences
        .getBooleanData(Configs.PREF_USER_LOGIN)
        .then((val) => setState(() {
              isLogin = val != null ? val : false;
              getAccessCode(isLogin);
            }));
  }

  void getAccessCode(bool login) {
    if (login) {
      isGuest = false;
      mySharedPreferences
          .getStringData(Configs.PREF_USER_ACCESS_CODE)
          .then((v) {
        accessCode = v;
        getData();
      });
    } else {
      isGuest = true;
      accessCode = Configs.GUEST_CODE;
      getData();
    }
  }

  void getData() {
    mPresenter.getArticleDetail(accessCode, widget.id);
    mPresenter.getComment(accessCode, widget.id, 3);
  }

  Widget _buildAppBar(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new Positioned(
          left: 0.0,
          top: 10.0,
          child: new IconButton(
            icon: new Icon(
              Icons.arrow_back,
              color: MyStyle.colorBlack,
            ),
            iconSize: 30.0,
            onPressed: () => _clickBack(context),
          ),
        ),
        new Positioned(
          right: 60.0,
          top: 10.0,
          child: new IconButton(
            icon: new Icon(
              isBookmark ? Icons.bookmark : Icons.bookmark_border,
              color: MyStyle.colorBlack,
            ),
            iconSize: 30.0,
            onPressed: () => _clickBookmark(context),
          ),
        ),
        new Positioned(
          right: 0.0,
          top: 10.0,
          child: new IconButton(
            icon: new Icon(
              Icons.share,
              color: MyStyle.colorBlack,
            ),
            iconSize: 30.0,
            onPressed: () => _clickShare(context),
          ),
        ),
      ],
    );
  }

  Widget _getFloatButton(IconData ic, Color bgColor, Color icColor) {
    return new Container(
      width: 40.0,
      height: 40.0,
      decoration:
          new BoxDecoration(shape: BoxShape.circle, color: bgColor, boxShadow: [
        new BoxShadow(
            color: Colors.grey, blurRadius: 4.0, offset: new Offset(1.0, 4.0)),
      ]),
      child: new Icon(
        ic,
        color: icColor,
      ),
    );
  }

  Widget _floatingBar() {
    return new Container(
        alignment: FractionalOffset.bottomCenter,
        child: new Row(
          children: <Widget>[
            new InkWell(
              child: new Padding(
                padding: const EdgeInsets.only(right: MyStyle.double10),
                child: _getFloatButton(
                    Icons.chat_bubble_outline, Colors.white, MyStyle.colorGrey),
              ),
              onTap: null,
            ),
            new Padding(
                padding: const EdgeInsets.only(
                    bottom: MyStyle.double8, left: MyStyle.double4),
                child: new Text(
                  '2',
                  style: new TextStyle(
                      fontSize: MyStyle.font12, color: MyStyle.colorGrey),
                )),
            new Expanded(
                child: new Row(
              children: <Widget>[],
            )),
            new RaisedButton(
              onPressed: () => _clickComment(context),
              color: MyStyle.colorAccent,
              child: new Text(
                'Comment  ေပးရန္',
                style: new TextStyle(
                  color: Colors.white,
                ),
              ),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
            )
          ],
        ));
  }

  Widget _buildBody(BuildContext context) {
    if (!isLoading) {
      return new SingleChildScrollView(
          controller: new ScrollController(),
          scrollDirection: Axis.vertical,
          child: new Padding(
            padding: const EdgeInsets.only(bottom: MyStyle.double4),
            child: new Container(
              child: new Column(
                children: <Widget>[
                  _showHeaderImage(),
                  _buildTitle(context),
                  new Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: MyStyle.double10),
                    child: new VideoDetailsItem(article),
                  ),
                  new Stack(
                    children: <Widget>[
                      new Container(
                        margin: const EdgeInsets.only(top: MyStyle.double20),
                        //color: MyStyle.layoutBackground,
                        child: new CommentItem(comment, article.id, true),
                      ),
                      new Positioned(
                        child: _floatingBar(),
                        top: 0.0,
                        left: 5.0,
                        right: 5.0,
                      )
                    ],
                  )
                ],
              ),
            ),
          ));
    } else {
      return new Container(
        child: Center(child: BaseWidgets.loadingIndicator),
      );
    }
  }

  _showHeaderImage() {
    if (article.id != null) {
      return new Container(
        constraints: new BoxConstraints.expand(
          height: 250.0,
        ),
        padding: new EdgeInsets.only(
            left: MyStyle.double16,
            bottom: MyStyle.double8,
            right: MyStyle.double16),
        child: new Markdown(
          data: html2md.convert(html),
        ),
      );
    } else {
      return new Container(
        child: null,
      );
    }
  }

  Widget _buildTitle(BuildContext context) {
    if (article.id != null) {
      return new Container(
        padding: const EdgeInsets.only(top: MyStyle.double16),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.symmetric(horizontal: MyStyle.double10),
              child: new Text(
                article.title,
                textAlign: TextAlign.start,
                style: new TextStyle(
                    fontSize: MyStyle.font18, fontWeight: FontWeight.bold),
              ),
            ),
            new Padding(
              padding: const EdgeInsets.all(MyStyle.double4),
              child: new Row(
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Padding(
                          padding: const EdgeInsets.all(MyStyle.double4),
                          child: new Icon(Icons.favorite,
                              color: MyStyle.colorGrey, size: MyStyle.font18)),
                      new Padding(
                          padding:
                              const EdgeInsets.only(right: MyStyle.double4),
                          child: new Text(
                            article.favCount.toString(),
                            style: new TextStyle(
                                color: MyStyle.colorGrey,
                                fontSize: MyStyle.font12),
                          )),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: new Icon(Icons.chat_bubble,
                              color: MyStyle.colorGrey, size: MyStyle.font18)),
                      new Padding(
                          padding:
                              const EdgeInsets.only(right: MyStyle.double4),
                          child: new Text(
                            article.commentCount.toString(),
                            style: new TextStyle(
                                color: MyStyle.colorGrey,
                                fontSize: MyStyle.font12),
                          )),
                    ],
                  ),
                  new Row(children: <Widget>[
                    new Padding(
                        padding: const EdgeInsets.all(MyStyle.double4),
                        child: new Icon(Icons.share,
                            color: MyStyle.colorGrey, size: MyStyle.font18)),
                    new Padding(
                        padding: const EdgeInsets.only(right: MyStyle.double4),
                        child: new Text(
                          article.share.toString(),
                          style: new TextStyle(
                              color: MyStyle.colorGrey,
                              fontSize: MyStyle.font12),
                        )),
                  ])
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return new Container(
        child: null,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        color: MyStyle.colorWhite,
        padding: const EdgeInsets.only(top: MyStyle.double24),
        child: new Stack(
            children: <Widget>[_buildBody(context), _buildAppBar(context)]),
      ),
      floatingActionButton: new FloatingActionButton(
          onPressed: () => _clickFloatingButton(context),
          elevation: 10.0,
          child: new Icon(isFav ? Icons.favorite : Icons.favorite_border,
              color: isFav ? MyStyle.colorWhite : MyStyle.colorGrey),
          backgroundColor: isFav ? MyStyle.colorAccent : MyStyle.colorWhite),
      backgroundColor: MyStyle.colorWhite,
      bottomNavigationBar: new Material(child: new CustomBottomNavigationBar()),
    );
  }

  @override
  void showComments(Comment c) {
    setState(() {
      comment = c;
    });
    print('Comment List ${comment.toString}');
  }

  @override
  void showArticle(Article a, int commentCount) {
    print('Article list${a.toString()}');
    setState(() {
      article = a;
      isBookmark = a.save;
      isFav = a.fav;
      isLoading = false;
    });
  }
}
