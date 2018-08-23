import 'package:flutter/material.dart';
import 'package:flutter_lyc/ui/article/widget/create_article_items.dart';
import 'package:flutter_lyc/ui/home/widget/create_article_buttons.dart';
import 'package:flutter_lyc/ui/article/data/article.dart';
import 'package:flutter_lyc/base/mystyle.dart';
import 'package:flutter_lyc/base/data/pagination.dart';
import 'package:flutter_lyc/base/widget/base_widget.dart';

class ArticleLists extends StatefulWidget {
  final List<Article> articles;
  final Pagination pagination;
  final ArticleClickListener articleClickListener;

  ArticleLists(this.articles, this.pagination, this.articleClickListener);

  @override
  ArticleListsState createState() {
    return new ArticleListsState();
  }
}

class ArticleListsState extends State<ArticleLists> {
  ScrollController scrollController = new ScrollController();
  bool isPerformingRequest = false;

  Widget _buildArticleList(BuildContext context, int index) {
    if (index == widget.articles.length) {
      if (widget.pagination.currentPage == widget.pagination.lastPage) {
        return new Container(
          child: null,
        );
      } else {
        return new Container(
          padding: const EdgeInsets.symmetric(vertical:  MyStyle.double4),
          child: new Center(
            child: BaseWidgets.loadingIndicator,
          ),
        );
      }
    } else {
      var article = widget.articles[index];
      return new Stack(children: <Widget>[
        new Container(
          color: MyStyle.layoutBackground,
          margin: const EdgeInsets.only(top:  MyStyle.double16, bottom:  MyStyle.double16),
          child: new Container(
            padding: const EdgeInsets.only(bottom:  MyStyle.double32),
            child: new CreateArticleItems(article),
            decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                color: MyStyle.colorWhite,
                borderRadius: new BorderRadius.circular(5.0)),
          ),
        ),
        new Positioned(
          child: new CreateArticleButton(article, widget.articleClickListener),
          bottom: 0.0,
          right: 10.0,
          left: 20.0,
        ),
      ]);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      padding: const EdgeInsets.only(top:  MyStyle.double10),
      itemBuilder: _buildArticleList,
      itemCount: widget.articles.length + 1,
      shrinkWrap: true,
      controller: scrollController,
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
