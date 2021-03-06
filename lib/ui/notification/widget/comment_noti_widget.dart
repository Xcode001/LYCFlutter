import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_lyc/base/mystyle.dart';
import 'package:flutter_lyc/ui/notification/data/comment.dart';
import 'package:flutter_lyc/utils/configs.dart';
import 'package:flutter_lyc/ui/utils/time_utils.dart';
import 'package:flutter_lyc/ui/article/page/article_details_page.dart';

class CommentNotificationWidget extends StatelessWidget {
  final Comment comment;

  CommentNotificationWidget(this.comment);

  @override
  Widget build(BuildContext context) {
    var image;
    var mNormalSpan = new TextStyle(
        color: MyStyle.colorBlack, fontSize: MyStyle.font14);
    var mArticleSpan = new TextStyle(
        color: MyStyle.colorDarkGrey,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline);

    if (comment.userId == 0 || comment.user == Configs.ADMIN_NAME) {
      image = new AssetImage('assets/images/lyc.png');
    } else if (comment.image == '') {
      image = new AssetImage('assets/images/lyc.png');
    } else {
      image = new NetworkImage(comment.image);
    }

    Widget _getSpannableString() {
      return new RichText(
        text: new TextSpan(
          //style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            new TextSpan(
              text: comment.user + ' ',
              style: mNormalSpan,
            ),
            new TextSpan(
              text: comment.mesg + ' ',
              style: mNormalSpan,
            ),
            new TextSpan(
              text: comment.article,
              style: mArticleSpan,
              recognizer: new TapGestureRecognizer()
                ..onTap = () {
                  print('Article Link');
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (_) =>
                              new ArticleDetailsPage(comment.articleId)));
                },
            ),
          ],
        ),
      );
    }

    Widget showDateAndTime() {
      if (comment.timeAgo > 88640) {
        return new Text(
          TimeUtils.getDateWithoutHours(comment.createDate),
          style: MyStyle.dateTimeTextStyle(),
        );
      } else {
        return new Row(
          children: <Widget>[
            new Text(
              TimeUtils.getTime(comment.timeAgo),
              style: MyStyle.dateTimeTextStyle(),
            ),
            new Text('.')
          ],
        );
      }
    }

    return new Container(
        margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: image,
              radius: 20.0,
            ),
            new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.only(top: 0.0, left: 10.0),
                    child: _getSpannableString(),
                  ),
                  new Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                      child: showDateAndTime())
                ],
              ),
            )
          ],
        ));
  }
}
