import 'package:flutter/material.dart';
import 'package:flutter_lyc/utils/mySharedPreferences.dart';
import 'package:flutter_lyc/utils/configs.dart';
import 'package:flutter_lyc/base/mystyle.dart';
import 'package:flutter_lyc/ui/home/data/banner_data.dart';
import 'package:flutter_lyc/ui/home/widget/services_scroller.dart';
import 'package:flutter_lyc/ui/home/widget/image_banner.dart';
import 'package:flutter_lyc/ui/home/presenter/home_presenter.dart';
import 'package:flutter_lyc/ui/home/contract/home_contract.dart';
import 'package:flutter_lyc/ui/doctors/data/doctor.dart';
import 'package:flutter_lyc/ui/doctors/widget/doctor_lists.dart';
import 'package:flutter_lyc/ui/doctors/widget/create_doctor_buttons.dart';
import 'package:flutter_lyc/ui/service/data/service.dart';

class HomePage extends StatefulWidget {
  final SeeMoreClickListener listener;

  HomePage(this.listener);

  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage>
    implements HomeContract, DoctorClickListener {
  HomePresenter mPresenter;
  List<Service> serviceList = new List<Service>();
  List<Doctor> doctorList = new List<Doctor>();
  List<BannerData> bannerList = new List<BannerData>();
  String accessCode;
  bool isGuest = true;
  bool isLogin;

  MySharedPreferences mySharedPreferences = new MySharedPreferences();

  HomePageState() {
    mPresenter = new HomePresenter(this);
  }

  @override
  void initState() {
    super.initState();
    print('initial state');
    mySharedPreferences
        .getBooleanData(Configs.PREF_USER_LOGIN)
        .then((val) => setState(() {
              isLogin = val != null ? val : false;
              _getAccessCode(isLogin);
            }));
  }

  _getAccessCode(bool login) {
    if (login) {
      mySharedPreferences
          .getStringData(Configs.PREF_USER_ACCESS_CODE)
          .then((val) => setState(() {
                accessCode = val;
                isGuest = false;
                getHomeData();
              }));
    } else {
      setState(() {
        isGuest = true;
        accessCode = Configs.GUEST_CODE;
        getHomeData();
      });
    }
    print('AccessCode$accessCode And IsGuest $isGuest');
  }

  void getHomeData() {
    mPresenter.getService(accessCode);
    mPresenter.getDoctor(accessCode, 3);
    mPresenter.getBanner(accessCode);
  }

  _clickSeeMore(BuildContext context) {
    widget.listener.onSeeMoreClickListener();
    /*Navigator.pop(
        context, new MaterialPageRoute(builder: (_) => new DoctorListPage()));*/
  }

  _showImageBanner() {
    if (bannerList.length > 0) {
      return new ImageBanner(bannerList);
    } else {
      return new Container(
        child: null,
        height: 200.0,
      );
    }
  }

  Widget loadingIndicator = new Container(
      child: new CircularProgressIndicator(
    strokeWidth: 2.0,
  ));

  _showServices() {
    if (serviceList.length > 0) {
      return new ServicesScroller(serviceList);
    } else {
      return new Container(
        child: new Center(
          child: loadingIndicator,
        ),
        height: 80.0,
      );
    }
  }

  _showDoctorLists() {
    if (doctorList.length > 0) {
      return new DoctorLists(doctorList, this);
    } else {
      return new Container(
        child: new Center(
          child: loadingIndicator,
        ),
        height: 80.0,
      );
    }
  }

  _showLoadMoreButton() {
    if (doctorList.length > 0) {
      return new Padding(
          padding: const EdgeInsets.only(
              top: MyStyle.double16, bottom: MyStyle.double16),
          child: new Row(
            children: <Widget>[
              new Expanded(
                  child: new RaisedButton(
                padding: const EdgeInsets.only(
                    top: MyStyle.double16, bottom: MyStyle.double16),
                child: new Text(
                  'SEE MORE',
                  style: MyStyle.buttonTextStyle(),
                ),
                shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0)),
                onPressed: () => _clickSeeMore(context),
                color: MyStyle.colorAccent,
              )),
            ],
            crossAxisAlignment: CrossAxisAlignment.center,
          ));
    } else {
      return new Container(
        child: null,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: MyStyle.layoutBackground,
        body: new SingleChildScrollView(
          controller: new ScrollController(),
          scrollDirection: Axis.vertical,
          child: new Padding(
              padding: const EdgeInsets.all(MyStyle.double8),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _showImageBanner(),
                  new Padding(
                    padding: const EdgeInsets.only(top: MyStyle.double24),
                    child: new Text(
                      'ဝန္ေဆာင္မွုမ်ား',
                      textAlign: TextAlign.left,
                      style: MyStyle.myTextStyle(MyStyle.colorBlack,
                          MyStyle.font14, FontWeight.normal),
                    ),
                  ),
                  _showServices(),
                  new Padding(
                    padding: const EdgeInsets.only(
                        left: MyStyle.double10, top: MyStyle.double16),
                    child: new Text(
                      'ျပသေဆြးေႏြးႏိုင္ေသာဆရာဝန္မ်ား',
                      textAlign: TextAlign.left,
                      style: MyStyle.myTextStyle(MyStyle.colorBlack,
                          MyStyle.font14, FontWeight.normal),
                    ),
                  ),
                  _showDoctorLists(),
                  _showLoadMoreButton()
                ],
              )),
        ));
  }

  @override
  void hideDoctorDialog() {
    // TODO: implement hideDoctorDialog
  }

  @override
  void hideServiceDialog() {
    // TODO: implement hideServiceDialog
  }

  @override
  void onLoadError() {
    // TODO: implement onLoadError
  }

  @override
  void showDoctorDialog() {
    // TODO: implement showDoctorDialog
  }

  @override
  void showDoctors(List<Doctor> d) {
    setState(() {
      doctorList.clear();
      doctorList = d;
      print('Doctor Respone Page $doctorList');
    });
  }

  @override
  void showErrorMessage(String message) {
    // TODO: implement showErrorMessage
  }

  @override
  void showMessage(String message) {
    // TODO: implement showMessage
  }

  @override
  void showMoreDoctors() {
    // TODO: implement showMoreDoctors
  }

  @override
  void showServiceDialog() {
    // TODO: implement showServiceDialog
  }

  @override
  void showServicePicker() {
    // TODO: implement showServicePicker
  }

  @override
  void showServices(List<Service> services) {
    setState(() {
      serviceList = services;
      print("Services${serviceList[0]}");
    });
  }

  @override
  void showBanner(List<BannerData> banner) {
    setState(() {
      bannerList = banner;
    });
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
  void onDoctorItemClick(Doctor doctor) {}
}

abstract class SeeMoreClickListener {
  void onSeeMoreClickListener();
}
