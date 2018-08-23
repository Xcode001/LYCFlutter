import 'package:flutter/material.dart';
import 'package:material_search/material_search.dart';
import 'package:flutter_lyc/utils/configs.dart';
import 'package:flutter_lyc/utils/mySharedPreferences.dart';
import 'package:flutter_lyc/base/mystyle.dart';
import 'package:flutter_lyc/base/data/pagination.dart';
import 'package:flutter_lyc/ui/doctors/contract/doctor_list_contract.dart';
import 'package:flutter_lyc/ui/doctors/presenter/doctor_list_presenter.dart';
import 'package:flutter_lyc/ui/doctors/data/doctor.dart';
import 'package:flutter_lyc/ui/doctors/data/search_result.dart';
import 'package:flutter_lyc/ui/doctors/widget/doctor_lists.dart';
import 'package:flutter_lyc/ui/doctors/widget/create_doctor_buttons.dart';
import 'package:flutter_lyc/ui/doctors/page/doctor_filter_page.dart';
import 'package:flutter_lyc/ui/doctors/page/doctor_details_page.dart';

class DoctorListPage extends StatefulWidget {
  final List<int> catList;

  DoctorListPage(this.catList);

  @override
  DoctorListPageState createState() {
    return new DoctorListPageState();
  }
}

class DoctorListPageState extends State<DoctorListPage>
    implements DoctorListContract, FilterListener, DoctorClickListener {
  DoctorListPresenter mPresenter;
  List<Doctor> doctorsList;
  Pagination paginationData;
  String accessCode;
  bool isGuest = false;
  bool isLogin = false;
  bool isLoading = true;
  int scrollDirection = 0;
  String filterText = '';
  MySharedPreferences mySharedPreferences = new MySharedPreferences();
  ScrollController controller = new ScrollController();

  DoctorListPageState() {
    mPresenter = new DoctorListPresenter(this);
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
    controller.addListener(listen);
  }

  void listen() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      if (paginationData.currentPage < paginationData.lastPage)
        mPresenter.getMoreDoctorList(
            accessCode, null, null, paginationData.currentPage + 1, '');
    }
  }

  void getAccessCode(bool login) {
    if (login) {
      isGuest = false;
      mySharedPreferences
          .getStringData(Configs.PREF_USER_ACCESS_CODE)
          .then((val) => setState(() {
                accessCode = val;
                mPresenter.getDoctorList(accessCode, null, null, '');
              }));
    } else {
      isGuest = true;
      accessCode = Configs.GUEST_CODE;
      mPresenter.getDoctorList(accessCode, null, null, '');
    }
  }

  showLoadingOrData() {
    if (isLoading) {
      return new Container(
        child: new Center(
          child: new Container(
            child: new CircularProgressIndicator(
              strokeWidth: 2.0,
            ),
          ),
        ),
      );
    } else {
      return new SingleChildScrollView(
          controller: controller,
          scrollDirection: Axis.vertical,
          child: new Container(
              padding: const EdgeInsets.only(top: MyStyle.double20),
              child: new DoctorLists(doctorsList, this, paginationData)));
    }
  }

  _buildMaterialSearchPage(BuildContext context) {
    return new MaterialPageRoute<String>(
        settings: new RouteSettings(
          name: 'material_search',
          isInitialRoute: false,
        ),
        builder: (BuildContext context) {
          return new Material(
            child: new MaterialSearch<String>(
              placeholder: 'Search',
              results: doctorsList
                  .map((Doctor v) => new MaterialSearchResult<String>(
                icon: Icons.info,
                value: v.name,
                text: v.name,
              ))
                  .toList(),
              filter: (dynamic value, String criteria) {
                return value.toLowerCase().trim().contains(
                    new RegExp(r'' + criteria.toLowerCase().trim() + ''));
              },
              onSelect: (dynamic value) {
                Doctor d = doctorsList
                    .singleWhere((dl) => dl.name == value.toString());
                print('Value >>${d.name}');
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (_) => new DoctorDetailsPage(d.id)));
              },
              onSubmit: (String value) => Navigator.of(context).pop(value),
            ),
          );
        });
  }

  _showMaterialSearch(BuildContext context) {
    Navigator
        .of(context)
        .push(_buildMaterialSearchPage(context))
        .then((dynamic value) {
      setState(() {
        filterText = value as String;
        print("Filter Text$filterText");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: MyStyle.colorWhite,
          title: new Text(
            "ျပသေဆြးေႏြးႏိုင္ေသာဆရာဝန္မ်ား",
            style: MyStyle.appbarTitleStyle(),
          ),
          leading: new IconButton(
              icon: new Icon(
                Icons.arrow_back,
                color: MyStyle.colorBlack,
              ),
              onPressed: () => Navigator.pop(context)),
          actions: <Widget>[
            new IconButton(
              onPressed: () {
                _showMaterialSearch(context);
              },
              tooltip: 'Search',
              icon: new Icon(Icons.search),
            )
          ],
        ),
        body: new Container(
          padding: const EdgeInsets.symmetric(
              vertical: 0.0, horizontal: MyStyle.double4),
          color: MyStyle.layoutBackground,
          child: new Stack(children: <Widget>[
            showLoadingOrData(),
          ]),
        ));
  }

  @override
  void showSearchResults(List<SearchResult> r) {}

  @override
  void showMostRecentActiveDoctorList(List<Doctor> doctors) {}

  @override
  void showMoreDoctorList(List<Doctor> doctors) {
    setState(() {
      doctorsList.addAll(doctors);
    });
  }

  @override
  void showPagination(Pagination pagination) {
    setState(() {
      paginationData = pagination;
    });
  }

  @override
  void showDoctorProfile(int doctorId) {}

  @override
  void showDoctorList(List<Doctor> doctors) {
    setState(() {
      doctorsList = doctors;
      isLoading = false;
    });
    //widget.listener.onSendDoctorListener(doctors);
    print('Doctor List$doctorsList');
  }

  @override
  void onLoadError() {}

  @override
  void onChooseFilters(List<int> roleList) {
    print('List Role$roleList');
    //mPresenter.getDoctorList(accessCode, roleList, null, null);
  }

  @override
  void onDoctorShareClick(Doctor doctor) {
    print('Doctor Share Click');
    mPresenter.shareDoctor(accessCode, doctor.id);
  }

  @override
  void onDoctorFavClick(Doctor doctor) {
    print('Doctor Fav Click');
    mPresenter.favDoctor(accessCode, doctor.id);
  }

  @override
  void onDoctorSaveClick(Doctor doctor) {
    print('Doctor Save Click');
    mPresenter.saveDoctor(accessCode, doctor.id);
  }

  @override
  void onDoctorItemClick(Doctor doctor) {
    print('Doctor Item Click');
  }
}

abstract class SendDoctorListener {
  void onSendDoctorListener(List<Doctor> doctorList);
}
