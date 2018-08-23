import 'package:flutter/material.dart';
import 'package:flutter_lyc/utils/configs.dart';
import 'package:flutter_lyc/base/mystyle.dart';
import 'package:flutter_lyc/ui/home/presenter/health_education_filter_presenter.dart';
import 'package:flutter_lyc/ui/home/contract/health_education_filter_contract.dart';
import 'package:flutter_lyc/ui/home/page/health_education_page.dart';
import 'package:flutter_lyc/ui/article/data/category.dart';

class FilterHealthEducationDialogFragment extends StatefulWidget {
  //final FilterListener filterListener;

  FilterHealthEducationDialogFragment();

  @override
  FilterHealthEducationDialogFragmentState createState() {
    return new FilterHealthEducationDialogFragmentState();
  }
}

class FilterHealthEducationDialogFragmentState
    extends State<FilterHealthEducationDialogFragment>
    implements HealthEducationFilterContract {
  static const Key contentKey = const Key('content');
  HealthEducationFilterPresenter mPresenter;
  List<Category> categoryList = new List<Category>();
  List<Category> selectedLit = new List<Category>();
  int filterStatus = 0;

  FilterHealthEducationDialogFragmentState() {
    mPresenter = new HealthEducationFilterPresenter(this);
  }




  _contentTypeClick(int id) {
    setState(() {
      filterStatus = id;
    });
  }

  Widget _categoryBuilder(BuildContext context, int index) {
    Category category = categoryList[index];
    return new Container(
        child: new Column(children: <Widget>[
      new ListTile(
        title: new Text(category.name),
        onTap: () {
          setState(() {
            selectedLit.add(categoryList[index]);
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (_) =>
                    new HealthEducationPage(categoryList[index].name)));
          });
        },
        trailing: new Icon(Icons.chevron_right),
      ),
      new Padding(
        padding: const EdgeInsets.only(
            left: MyStyle.double10, right: MyStyle.double10),
        child: new Divider(color: Colors.grey, height: 0.5),
      )
    ]));
  }

  @override
  void initState() {
    super.initState();
    mPresenter.getCategory(Configs.TEST_CODE);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Container(
            child: new Stack(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new Container(
                    child: new ListView.builder(
                  controller: new ScrollController(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(bottom: MyStyle.double8),
                  itemCount: categoryList.length,
                  itemBuilder: _categoryBuilder,
                )),
              ],
            ),
          ],
        )),
      ),
    );
  }

  @override
  void showContentType(int contentType) {}

  @override
  void showCategoryList(List<Category> c) {
    setState(() {
      categoryList = c;
    });
  }
}
