import 'package:flutter/material.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_lyc/base/mystyle.dart';
import 'package:flutter_lyc/ui/article/data/article.dart';
import 'package:flutter_lyc/ui/comment/data/comment.dart';

class ArticleDetailsItem extends StatefulWidget {
  final Article article;
  final Comment comment;
  final String html =
      '<h1>This is heading 1</h1> <h2>This is heading 2</h2><h3>This is heading 3</h3><h4>This is heading 4</h4><h5>This is heading 5</h5><h6>This is heading 6</h6>';

  ArticleDetailsItem(this.article, this.comment);

  @override
  ArticleDetailsItemState createState() {
    return new ArticleDetailsItemState();
  }
}

class ArticleDetailsItemState extends State<ArticleDetailsItem> {
  showContent(){
    if(widget.article.id!=null){
      return new MarkdownBody(
        data: html2md.convert(widget.article.content),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          showContent(),
          new Container(
              color: MyStyle.colorWhite,
              child: new SizedBox.fromSize(
                size: new Size.fromHeight(20.0),
                child: null,
              )),
        ],
      ),
    );
  }
}
