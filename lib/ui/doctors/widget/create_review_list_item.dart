import 'package:flutter/material.dart';
import 'package:flutter_lyc/base/mystyle.dart';
import 'package:flutter_lyc/ui/comment/data/comment.dart';
import 'package:flutter_lyc/ui/comment/data/review.dart';
import 'package:flutter_lyc/ui/comment/page/comment_page.dart';
import 'package:flutter_lyc/ui/comment/widget/comment_item_widget.dart';

class ReviewListItem extends StatefulWidget {
  final Comment comment;
  final int doctorId;
  final bool isArticle;
  final bool isLogin;

  ReviewListItem(this.comment, this.doctorId, this.isArticle, this.isLogin);

  @override
  ReviewListItemState createState() {
    return new ReviewListItemState();
  }
}

class ReviewListItemState extends State<ReviewListItem>
    with SingleTickerProviderStateMixin {
  int reviewCount = 0;
  List<Review> reviewList = new List<Review>();
  AnimationController aniController;

  @override
  void initState() {
    super.initState();
    aniController = new AnimationController(
        vsync: this, duration: new Duration(microseconds: 500));
    reviewCount = widget.comment.pagination.total;
    reviewList = widget.comment.data;
  }

  _clickReview(BuildContext context) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (_) =>
                new CommentPage(null, widget.isArticle, widget.doctorId)));
  }

  _clickCommentCount(BuildContext context) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (_) =>
                new CommentPage(null, widget.isArticle, widget.doctorId)));
  }

  Widget _getFloatButton(IconData ic, Color bgColor, Color icColor) {
    return new Container(
      width: 40.0,
      height: 40.0,
      decoration:
          new BoxDecoration(shape: BoxShape.circle, color: bgColor, boxShadow: [
        new BoxShadow(
            color: MyStyle.defaultGrey,
            blurRadius: 4.0,
            offset: new Offset(1.0, 4.0)),
      ]),
      child: new Icon(
        ic,
        color: icColor,
      ),
    );
  }

  Widget _roundButton(BuildContext context) {
    print("Login ${widget.isLogin}");

    return new Opacity(
        opacity: widget.isLogin ? 1.0 : 0.0,
        child: new RaisedButton(
            color: MyStyle.colorGrey,
            onPressed: () => _clickReview(context),
            child: new Text(
              "Review ေပးရန္",
              style: new TextStyle(fontSize: MyStyle.font14, color: MyStyle.colorWhite),
            ),
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0))));
  }

  Widget _buildReviewItem(BuildContext context, int index) {
    Review c = reviewList[index];
    return new CommentItemWidget(c, reviewCount, index, aniController);
  }

  Widget _showSeeCommentWidget(int commentCount) {
    if (commentCount > 0) {
      return new InkWell(
        onTap: () => _clickCommentCount(context),
        child: new Padding(
          padding: const EdgeInsets.all(MyStyle.double4),
          child: commentCount > 2
              ? new Text(
                  'See all $commentCount comments',
                  style: new TextStyle(color: Colors.black, fontSize: 14.0),
                )
              : new Text(""),
        ),
      );
    } else {
      return null;
    }
  }

  Widget _showSeeCommentItems() {
    if (widget.comment.data.length > 0) {
      return new Padding(
        padding: const EdgeInsets.only(top: MyStyle.double32),
        child: new Card(
          child: new Column(
            children: <Widget>[
              new ListView.builder(
                  padding: const EdgeInsets.only(top: MyStyle.double20),
                  itemBuilder: _buildReviewItem,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: reviewCount > 3 ? 3 : reviewList.length,
                  controller: new ScrollController()),
              new Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: MyStyle.double4, horizontal: MyStyle.double4),
                child: new Divider(
                  color: MyStyle.colorBlack,
                  height: 2.0,
                ),
              ),
              _showSeeCommentWidget(reviewCount),
            ],
          ),
        ),
      );
    } else {
      return new Padding(
          padding: const EdgeInsets.only(top: MyStyle.double32),
          child: new Card(
              child: new Column(
            children: <Widget>[
              new SizedBox.fromSize(
                child: null,
                size: new Size.fromHeight(50.0),
              )
            ],
          )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.only(top: 0.0),
      child: new Stack(
        children: <Widget>[
          _showSeeCommentItems(),
          new Align(
              alignment: FractionalOffset.topLeft,
              child: new Padding(
                padding: const EdgeInsets.symmetric(horizontal: MyStyle.double4),
                child: new Row(
                  children: <Widget>[
                    new InkWell(
                      child: new Padding(
                        padding: const EdgeInsets.only(
                            top: MyStyle.double10, left: MyStyle.double10, right: 0.0),
                        child: _getFloatButton(Icons.rate_review, Colors.white,
                            MyStyle.defaultGrey),
                      ),
                      onTap: () => _clickReview(context),
                    ),
                    new Expanded(
                        child: new Row(
                      children: <Widget>[],
                    )),
                    _roundButton(context)
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
