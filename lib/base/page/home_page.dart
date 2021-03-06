import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_lyc/base/mystyle.dart';
import 'package:flutter_lyc/base/data/drawer_item.dart';
import 'package:flutter_lyc/base/widget/base_widget.dart';
import 'package:flutter_lyc/utils/configs.dart';
import 'package:flutter_lyc/utils/mySharedPreferences.dart';
import 'package:flutter_lyc/ui/base/data/site_info.dart';
import 'package:flutter_lyc/ui/base/data/unread_status.dart';
import 'package:flutter_lyc/ui/base/contract/home_container_contract.dart';
import 'package:flutter_lyc/ui/base/presenter/home_container_presenter.dart';
import 'package:flutter_lyc/ui/home/page/home_container_fragment.dart';
import 'package:flutter_lyc/ui/home/page/home_page.dart';
import 'package:flutter_lyc/ui/home/page/profile_data_page.dart';
import 'package:flutter_lyc/ui/doctors/page/doctor_filter_page.dart';
import 'package:flutter_lyc/ui/notification/page/notification_list_page.dart';
import 'package:flutter_lyc/ui/about/page/about_page.dart';
import 'package:flutter_lyc/ui/chat/page/chat_list_page.dart';

class MainPage extends StatefulWidget {
  final List<DrawerItem> afterLoginDrawerItems = [
    new DrawerItem("HOME", Icons.home),
    new DrawerItem("က်န္းမာေရးပညာေပး", Icons.library_books),
    new DrawerItem(
        "ျပသေဆြးေႏြးႏိုင္ေသာဆရာဝန္မ်ား", FontAwesomeIcons.stethoscope),
    new DrawerItem("BOOKINGS", Icons.event_available),
    new DrawerItem("MY PROFILE", Icons.account_box),
  ];

  final List<DrawerItem> beforeLoginDrawerItems = [
    new DrawerItem("HOME", Icons.home),
    new DrawerItem("က်န္းမာေရးပညာေပး", Icons.library_books),
    new DrawerItem(
        "ျပသေဆြးေႏြးႏိုင္ေသာဆရာဝန္မ်ား", FontAwesomeIcons.stethoscope),
    new DrawerItem("LOGIN/ REGISTER", Icons.account_box),
  ];

  @override
  MainPageState createState() {
    return new MainPageState();
  }
}

class MainPageState extends State<MainPage>
    implements HomeContainerContract, SeeMoreClickListener, FilterListener {
  //SearchBar searchBar;
  bool isLogin = false;
  String name = "";
  String profilePhoto = "";
  int selectedDrawerIndex = 0;
  String filterText = '';
  String accessCode;
  HomeContainerPresenter mPresenter;
  MySharedPreferences mySharedPreferences = new MySharedPreferences();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<DrawerItem> drawerItems = new List<DrawerItem>();
  SiteInfo siteInfo;

  void onSubmitted(String value) {
    setState(() => _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text('You wrote $value!'))));
  }

  MainPageState() {
    mPresenter = new HomeContainerPresenter(this);
    mySharedPreferences
        .getBooleanData(Configs.PREF_USER_LOGIN)
        .then((val) => setState(() {
              isLogin = val != null ? val : false;
              getAccessCode(isLogin);
            }));
  }

  void getAccessCode(isLogin) async {
    if (isLogin)
      accessCode = await mySharedPreferences
          .getStringData(Configs.PREF_USER_ACCESS_CODE);
  }

  void getSharedPreferencesData() async {
    name = await mySharedPreferences.getStringData(Configs.PREF_USER_NAME);
    profilePhoto =
        await mySharedPreferences.getStringData(Configs.PREF_USER_IMAGE);
  }

  @override
  void initState() {
    super.initState();
    mPresenter.getSiteInfo(Configs.GUEST_CODE);
    getSharedPreferencesData();
  }

  _getDrawerItemWidgets(int position) {
    print('Drawer Item $position');
    switch (position) {
      case 0:
        return new HomeContainerPage(this,0);
      case 1:
        return new HomeContainerPage(this,1);
      case 2:
        return new DoctorFilterPage(this);
      case 3:
        if (isLogin) {
          return new ProfileDataPage(tabIndex: 2);
        } else {
          BaseWidgets.showLoginDialog(context);
        }
        break;
      case 4:
        return new ProfileDataPage(tabIndex: 3);
      default:
        return new Text("Eror");
    }
  }

  _onSelectedItem(int index) {
    setState(() {
      selectedDrawerIndex = index;
      Navigator.of(context).pop();
    });
    _getDrawerItemWidgets(selectedDrawerIndex);
  }

  _clickNoti(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (_) => new NotificationListPage()));
  }

  _clickEditProfile(BuildContext context) {
    setState(() {
      selectedDrawerIndex = 4;
      Navigator.pop(context);
    });
  }

  _clickBottomMenuItem(int index, BuildContext context) {
    switch (index) {
      case 0:
        /* Navigator.of(context).push(MaterialPageRoute<void>(
            builder: (_) => Scaffold(
                  appBar: AppBar(title: Text("Ma")),
                  body: PlaceMarkerPage(),
                )));*/
        break;
      case 1:
        _callPhone();
        break;
      case 2:
        if (isLogin) {
          Navigator.push(context,
              new MaterialPageRoute(builder: (_) => new ChatListPage()));
        } else {
          Navigator.of(context).pop();
          BaseWidgets.showLoginDialog(context);
        }
        break;
    }
  }

  _callPhone() async {
    const phoneNo = 'tel:09421234567';
    if (await canLaunch(phoneNo)) {
      await launch(phoneNo);
    } else {
      throw 'Colud not call $phoneNo';
    }
  }

  /*_buildMaterialSearchPage(BuildContext context) {
    return new MaterialPageRoute<String>(
        settings: new RouteSettings(
          name: 'material_search',
          isInitialRoute: false,
        ),
        builder: (BuildContext context) {
          return new Material(
            child: new MaterialSearch<String>(
              placeholder: 'Search',
              results: _doctorList
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
                Doctor d = _doctorList
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
  }*/

  AppBar _buildAppBar(BuildContext context) {
    if (selectedDrawerIndex == 2) {
      return new AppBar(
        title: new Text(
          drawerItems[selectedDrawerIndex].title,
          style: MyStyle.appbarTitleStyle(),
        ),
        backgroundColor: MyStyle.colorWhite,
        iconTheme: new IconThemeData(color: MyStyle.colorGrey),
        /*actions: <Widget>[
          new IconButton(
            onPressed: () {
              _showMaterialSearch(context);
            },
            tooltip: 'Search',
            icon: new Icon(Icons.search),
          )
        ],*/
        elevation: 2.0,
      );
    } else {
      return new AppBar(
        title: new Padding(
          padding: const EdgeInsets.only(
              top: MyStyle.double4, bottom: MyStyle.double4),
          child: new Image.asset('assets/images/lyc.png',
              scale: 2.0, alignment: FractionalOffset.center),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: new IconThemeData(color: MyStyle.colorGrey),
        actions: <Widget>[
          new Opacity(
              opacity: isLogin ? 1.0 : 0.0,
              child: new IconButton(
                icon: new Icon(Icons.notifications),
                onPressed: () => _clickNoti(context),
              ))
        ],
        elevation: 0.0,
      );
    }
  }

  Widget _getNavHeader() {
    if (isLogin) {
      return new Container(
        margin: new EdgeInsets.only(
            left: MyStyle.double8,
            top: MyStyle.double20,
            right: MyStyle.double8,
            bottom: MyStyle.double16),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new GestureDetector(
              child: new CircleAvatar(
                backgroundImage: new NetworkImage(
                    profilePhoto != null ? profilePhoto : Configs.imageUrl),
                radius: MyStyle.double48,
              ),
            ),
            new Flexible(
                child: new Container(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    padding: const EdgeInsets.only(
                        left: MyStyle.double8,
                        top: MyStyle.double4,
                        bottom: MyStyle.double4),
                    child: new Text(
                      name != null ? name : "",
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: MyStyle.myTextStyle(MyStyle.colorBlack,
                          MyStyle.font18, FontWeight.normal),
                    ),
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(left: MyStyle.double8),
                    child: new RaisedButton.icon(
                        onPressed: () => _clickEditProfile(context),
                        color: MyStyle.colorWhite,
                        textColor: MyStyle.colorGrey,
                        icon: new Icon(
                          Icons.edit,
                          color: MyStyle.colorGrey,
                        ),
                        label: new Text(
                          "Edit Profile",
                          style: new TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),
            ))
          ],
        ),
      );
    } else {
      return new Container(
        height: 20.0,
        child: new Padding(
          padding: const EdgeInsets.only(top: MyStyle.double4),
          child: null,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      drawerItems = widget.afterLoginDrawerItems;
    } else {
      drawerItems = widget.beforeLoginDrawerItems;
    }
    List<Widget> drawerOptions = new List<Widget>();
    for (var i = 0; i < drawerItems.length; i++) {
      var d = drawerItems[i];

      if (d.title == "LOGIN/ REGISTER") {
        drawerOptions.add(new Container(
            child: new ListTileTheme(
          iconColor: MyStyle.colorGreen,
          textColor: MyStyle.colorGreen,
          selectedColor: MyStyle.colorGreen,
          child: new Builder(builder: (BuildContext context) {
            return new ListTile(
                leading: new Icon(d.icon),
                title: new Text(d.title),
                selected: i == selectedDrawerIndex,
                onTap: () {
                  _onSelectedItem(i);
                });
          }),
        )));
      } else {
        drawerOptions.add(new ListTileTheme(
          iconColor: MyStyle.colorGrey,
          textColor: MyStyle.colorGrey,
          selectedColor: MyStyle.colorAccent,
          child: new Builder(builder: (BuildContext context) {
            return new ListTile(
                leading: new Icon(d.icon),
                title: new Text(d.title),
                selected: i == selectedDrawerIndex,
                onTap: () {
                  _onSelectedItem(i);
                });
          }),
        ));
      }
    }

    Widget buildBottomColumn(
        IconData icon, String label, Color color, int index) {
      return new InkWell(
          onTap: () => _clickBottomMenuItem(index, context),
          child: new Row(
            //mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              new Icon(icon, color: color),
              new Text(
                label,
                style: new TextStyle(
                  fontSize: MyStyle.font12,
                  fontWeight: FontWeight.w400,
                  color: color,
                ),
              ),
            ],
          ));
    }

    Widget buttonSection = new Container(
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildBottomColumn(
              Icons.location_on, 'Address', MyStyle.colorWhite, 0),
          buildBottomColumn(Icons.phone, 'Phone', MyStyle.colorWhite, 1),
          buildBottomColumn(Icons.message, 'Chat', MyStyle.colorWhite, 2),
        ],
      ),
    );

    var textTheme = Theme.of(context).textTheme;

    return new Scaffold(
      appBar: _buildAppBar(context),
      drawer: new Drawer(
        child: new Scaffold(
          bottomNavigationBar: new Stack(
            overflow: Overflow.visible,
            alignment: new FractionalOffset(0.5, 1.0),
            children: [
              new Container(
                height: 50.0,
                color: MyStyle.colorGreen,
                child: new Container(
                  padding: const EdgeInsets.fromLTRB(
                      0.0, MyStyle.double12, 0.0, MyStyle.double12),
                  child: new ListView(
                    children: <Widget>[buttonSection],
                  ),
                ),
              ),
            ],
          ),
          body: new Container(
            color: MyStyle.colorWhite,
            child: new Stack(children: <Widget>[
              new ListView(
                children: <Widget>[
                  _getNavHeader(),
                  new Column(children: drawerOptions),
                ],
              ),
              new Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: new Container(
                    padding: const EdgeInsets.all(MyStyle.double8),
                    height: 180.0,
                    color: MyStyle.layoutBackground,
                    alignment: FractionalOffset.bottomCenter,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        new Container(
                          alignment: FractionalOffset.centerLeft,
                          child: new Image.asset('assets/images/lyc.png',
                              scale: 2.0,
                              alignment: FractionalOffset.centerLeft),
                        ),
                        new Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec vehicula sem a malesuada rhoncus. Pellentesque ut dolor a dui porttitor porta lacinia non libero. Nunc volutpat arcu quis quam convallis molestie. Etiam ac tristique sem, id commodo justo. Phasellus congue tincidunt lectus, at dignissim ligula maximus eu. Quisque interdum nunc eget tellus bibendum suscipit. Phasellus feugiat ultricies posuere. Nullam porta accumsan velit, ut rutrum massa fermentum eu. Nunc ac bibendum nunc. Mauris eu ultricies ipsum. Ut id dolor dui. Pellentesque dictum dui vel tempus maximus. Vivamus non nisi quis libero scelerisque pretium. Ut eu tristique justo. Sed pellentesque placerat quam, ut ultricies turpis feugiat a. Aliquam a volutpat risus.',
                          maxLines: 3,
                        ),
                        new InkWell(
                            child: new Text(
                              'Learn more about us',
                              style: textTheme.subhead.copyWith(
                                  fontSize: MyStyle.font14,
                                  decoration: TextDecoration.underline),
                            ),
                            onTap: () => Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (_) => new AboutPage())))
                      ],
                    ),
                  ))
            ]),
          ),
        ),
      ),
      body: _getDrawerItemWidgets(selectedDrawerIndex),
      backgroundColor: MyStyle.colorWhite,
    );
  }

  @override
  void showSiteInfo(SiteInfo siteInfo) {
    print('Site info??${siteInfo.toString()}');
    setState(() {
      this.siteInfo = siteInfo;
    });
  }

  @override
  void showUnreadStatus(UnreadStatus u) {}

  @override
  void showEnterPhoneNo() {}

  /*@override
  void onSendDoctorListener(List<Doctor> doctorList) {
    _doctorList = doctorList;
  }*/

  @override
  void onSeeMoreClickListener() {
    setState(() {
      selectedDrawerIndex = 2;
    });
  }

  @override
  void onChooseFilters(List<int> roleList) {
    setState(() {});
  }
}
