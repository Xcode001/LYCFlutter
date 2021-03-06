import 'package:flutter/material.dart';
import 'package:flutter_lyc/utils/mySharedPreferences.dart';
import 'package:flutter_lyc/utils/configs.dart';
import 'package:flutter_lyc/base/mystyle.dart';
import 'package:flutter_lyc/base/data/pagination.dart';
import 'package:flutter_lyc/base/widget/base_widget.dart';
import 'package:flutter_lyc/ui/home/data/save.dart';
import 'package:flutter_lyc/ui/home/widget/create_article_buttons.dart';
import 'package:flutter_lyc/ui/home/contract/user_activity_contract.dart';
import 'package:flutter_lyc/ui/home/presenter/user_activity_presenter.dart';
import 'package:flutter_lyc/ui/doctors/data/doctor.dart';
import 'package:flutter_lyc/ui/doctors/widget/create_doctor_buttons.dart';
import 'package:flutter_lyc/ui/doctors/widget/create_doctor_item.dart';
import 'package:flutter_lyc/ui/article/data/article.dart';
import 'package:flutter_lyc/ui/article/widget/create_article_items.dart';

class UserActivityListPage extends StatefulWidget {
  @override
  UserActivityListPageState createState() {
    return new UserActivityListPageState();
  }
}

class UserActivityListPageState extends State<UserActivityListPage>
    implements UserActivityContract, DoctorClickListener, ArticleClickListener {
  UserActivityPresenter mPresenter;
  List<Save> saveList = new List<Save>();
  Pagination pagination;
  String accessCode;
  bool isLoading = true;
  MySharedPreferences mySharedPreferences = new MySharedPreferences();
  ScrollController controller = new ScrollController();

  UserActivityListPageState() {
    mPresenter = new UserActivityPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _getAccessCode();

    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        if (pagination.currentPage < pagination.lastPage)
          mPresenter.getMoreUserActivity(
              accessCode, pagination.currentPage + 1);
      }
    });
  }

  _getAccessCode() {
    mySharedPreferences
        .getStringData(Configs.PREF_USER_ACCESS_CODE)
        .then((val) => setState(() {
              accessCode = val;
              mPresenter.getUserActivity(accessCode);
            }));
  }

  Widget _buildUserActivityItem(BuildContext context, int index) {
    if(index==saveList.length){
      if (pagination.currentPage == pagination.lastPage) {
        return new Container(
          child: null,
        );
      } else {
        return new Container(
          padding: const EdgeInsets.symmetric(vertical: MyStyle.double4),
          child: new Center(
            child: BaseWidgets.loadingIndicator,
          ),
        );
      }
    }
    else{
      if (saveList[index].doctor != null) {
        return new Container(
            child: new Stack(
              children: <Widget>[
                //Doctor Item Card
                new CreateDoctorItem(saveList[index].doctor.data),
                //Floating Action Button
                new Positioned(
                  top: 0.0,
                  bottom: 5.0,
                  left: 10.0,
                  right: 10.0,
                  child: new CreateDoctorButton(saveList[index].doctor.data, this),
                )
              ],
            ));
      } else if (saveList[index].article != null) {
        return Container(
          child: new Stack(
            children: <Widget>[
              new Container(
                color: MyStyle.layoutBackground,
                margin: const EdgeInsets.only(top: MyStyle.double20, bottom: MyStyle.double20),
                child: new Container(
                  padding: const EdgeInsets.only(bottom: MyStyle.double32),
                  child: new CreateArticleItems(saveList[index].article.data),
                  decoration: new BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: MyStyle.colorWhite,
                      borderRadius: new BorderRadius.circular(5.0)),
                ),
              ),
              new Positioned(
                child:
                new CreateArticleButton(saveList[index].article.data, this),
                bottom: 0.0,
                right: 10.0,
                top: 0.0,
                left: 20.0,
              ),
            ],
          ),
        );
      } else {
        return null;
      }
    }
  }

  Widget showLoadingOrData() {
    if (!isLoading) {
      isLoading=true;
      return new SingleChildScrollView(
          controller: controller,
          scrollDirection: Axis.vertical,
          child: new Container(
              color: MyStyle.layoutBackground,
              child: new Column(
                children: <Widget>[
                  new ListView.builder(
                      itemBuilder: _buildUserActivityItem,
                      itemCount: pagination != null
                          ? saveList.length + 1
                          : saveList.length,
                      scrollDirection: Axis.vertical,
                      controller: new ScrollController(),
                      shrinkWrap: true)
                ],
              )));
    } else {
      return new Center(
        child: BaseWidgets.loadingIndicator,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: showLoadingOrData(),
    );
  }

  @override
  void setPagination(Pagination p) {
    pagination = p;
  }

  @override
  void showMoreUserActivities(List<Save> s) {
    setState(() {
      isLoading=false;
      saveList.addAll(s);
    });
  }

  @override
  void showUserActivities(List<Save> s) {
    setState(() {
      saveList.clear();
      isLoading=false;
      saveList = s;
    });
    print('Save List Data${saveList.toString()}');
  }

  @override
  void loadError(String e) {}

  @override
  void onDoctorShareClick(Doctor doctor) {}

  @override
  void onDoctorFavClick(Doctor doctor) {
    print('Doctor Fav Click ');
    mPresenter.setDoctorFav(accessCode, doctor.id);
  }

  @override
  void onDoctorSaveClick(Doctor doctor) {
    print('Doctor Save Click ');
    mPresenter.saveDoctor(accessCode, doctor.id);
  }

  @override
  void onDoctorItemClick(Doctor doctor) {
    print('Article Fav Click ');
    mPresenter.setDoctorFav(accessCode, doctor.id);
  }

  @override
  void onArticleShareClick(Article article) {
    print('Article Share Click ');
  }

  @override
  void onArticleFavClick(Article article) {
    print('Article Fav Click ');
    mPresenter.setArticleFav(accessCode, article.id);
  }

  @override
  void onArticleSaveClick(Article article) {
    print('Article Save Click ');
    mPresenter.saveArticle(accessCode, article.id);
  }

  @override
  void onArticleCommentClick(Article article) {
    print('Article Comment Click ');
  }
}
