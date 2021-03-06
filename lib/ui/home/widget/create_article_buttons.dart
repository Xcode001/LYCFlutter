import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:flutter_lyc/base/widget/base_widget.dart';
import 'package:flutter_lyc/base/mystyle.dart';
import 'package:flutter_lyc/utils/configs.dart';
import 'package:flutter_lyc/utils/mySharedPreferences.dart';
import 'package:flutter_lyc/ui/comment/page/comment_page.dart';
import 'package:flutter_lyc/ui/article/data/article.dart';

class CreateArticleButton extends StatefulWidget {
  final Article article;
  final ArticleClickListener articleClickListener;

  CreateArticleButton(this.article, this.articleClickListener);

  @override
  CreateArticleButtonState createState() {
    return new CreateArticleButtonState();
  }
}

class CreateArticleButtonState extends State<CreateArticleButton> {
  bool _isFavourite = false;
  bool _isBookMark = false;
  int _favCount = 0;
  bool _isCommented = false;
  int _commentCount = 0;
  ArticleClickListener listener;
  bool isLogin=true;
  MySharedPreferences mySharedPreferences=new MySharedPreferences();

  @override
  void initState() {
    super.initState();
    _favCount = widget.article.favCount;
    _isFavourite = widget.article.fav;
    _commentCount = widget.article.commentCount;
    _isCommented = widget.article.commentCount > 0 ? true : false;
    _isBookMark = widget.article.save;
    listener = widget.articleClickListener;

    mySharedPreferences
        .getBooleanData(Configs.PREF_USER_LOGIN)
        .then((val) => setState(() {
      isLogin = val!=null?val:false;
    }));
  }

  /*Widget _getFloatButton(IconData ic, Color bgColor, Color icColor) {
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
  }*/

  void _clickLikeButton() {
    if(isLogin) {
      setState(() {
        if (_isFavourite) {
          _isFavourite = false;
          _favCount -= 1;
        } else {
          _isFavourite = true;
          _favCount += 1;
        }
      });
      listener.onArticleFavClick(widget.article);
    }
    else{
      BaseWidgets.showLoginDialog(context);
    }
  }

  _clickCommentButton() {
    setState(() {
      if (!_isCommented) {
        _isCommented = true;
      }
    });
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (_) => new CommentPage(widget.article.id, true, null)));
  }

  _clickShareButton() {
    setState(() {
      Share.share(widget.article.shareUrl);
    });
    listener.onArticleShareClick(widget.article);
  }

  _clickBookMarkButton() {
    if(isLogin) {
      setState(() {
        if (_isBookMark) {
          _isBookMark = false;
        } else {
          _isBookMark = true;
        }
      });
      listener.onArticleSaveClick(widget.article);
    }else{
      BaseWidgets.showLoginDialog(context);
    }
  }

  Widget _showActivityCount(String activityCount) {
    return new Text(
      activityCount,
      style: new TextStyle(
          fontSize: MyStyle.font12, color: MyStyle.colorGrey),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color _favbgColor = _isFavourite ? Colors.orangeAccent : Colors.white;
    Color _favicColor = _isFavourite ? Colors.white : Colors.grey;
    IconData _favIcon = _isFavourite ? Icons.favorite : Icons.favorite_border;
    Color _commentbgcolor = _isCommented ? Colors.orangeAccent : Colors.white;
    Color _commenticColor = _isCommented ? Colors.white : Colors.grey;
    IconData _commentIcon =
        _isCommented ? Icons.chat_bubble : Icons.chat_bubble_outline;
    Color _bookbgColor = _isBookMark ? Colors.orangeAccent : Colors.white;
    Color _bookicColor = _isBookMark ? Colors.white : Colors.grey;
    IconData _bookMarkIcon =
        _isBookMark ? Icons.bookmark : Icons.bookmark_border;
    var favCount = _favCount > 0 ? "$_favCount" : " ";
    var commentCount = _commentCount > 0 ? '$_commentCount' : "";
    return new Container(
        alignment: FractionalOffset.bottomCenter,
        child: new Row(
          children: <Widget>[
            new InkWell(
              child: new Padding(
                padding:
                    const EdgeInsets.only(top:  MyStyle.double10, left: 0.0, right:  MyStyle.double10),
                child: BaseWidgets.getFloatButton(_favIcon, _favbgColor, _favicColor),
              ),
              onTap: _clickLikeButton,
            ),
            new Padding(
                padding:
                    const EdgeInsets.only(top: 0.0, bottom:  MyStyle.double10, right:  MyStyle.double16),
                child: _showActivityCount(favCount)),
            new InkWell(
              child: new Padding(
                padding:
                    const EdgeInsets.only(top:  MyStyle.double10, left:  MyStyle.double10, right: 0.0),
                child: BaseWidgets.getFloatButton(
                    _commentIcon, _commentbgcolor, _commenticColor),
              ),
              onTap: _clickCommentButton,
            ),
            new Padding(
                padding:
                    const EdgeInsets.only(top: 0.0, bottom:  MyStyle.double10, right:  MyStyle.double16),
                child: _showActivityCount(commentCount)),
            new InkWell(
              child: new Padding(
                  padding:
                      const EdgeInsets.only(top:  MyStyle.double10, left:  MyStyle.double10, right: 0.0),
                  child:
                      BaseWidgets.getFloatButton(Icons.share, Colors.white, Colors.grey)),
              onTap: _clickShareButton,
            ),
            new Expanded(
                child: new Row(
              children: <Widget>[],
            )),
            new InkWell(
              child: new Padding(
                padding: const EdgeInsets.only(top:  MyStyle.double10, right:  MyStyle.double10),
                child:
                    BaseWidgets.getFloatButton(_bookMarkIcon, _bookbgColor, _bookicColor),
                /*new FloatingActionButton(
                    heroTag: 'ArticleBookMark',
                    onPressed: _clickBookMarkButton,
                    child: new Icon(
                        _bookMarkIcon, size: 20.0, color: _bookicColor),
                    mini: true,
                    backgroundColor: _bookbgColor,)
              ),*/
              ),
              onTap: _clickBookMarkButton,
            ),
          ],
        ));
  }
}

abstract class ArticleClickListener {
  void onArticleSaveClick(Article article);

  void onArticleFavClick(Article article);

  void onArticleShareClick(Article article);

  void onArticleCommentClick(Article article);
}
