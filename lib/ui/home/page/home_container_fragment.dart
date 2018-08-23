import 'package:flutter/material.dart';
import 'package:flutter_lyc/base/mystyle.dart';
import 'package:flutter_lyc/base/widget/custom_bottom_navigation_bar.dart';
import 'package:flutter_lyc/ui/home/page/home_page.dart';
import 'package:flutter_lyc/ui/home/page/article_filter_dialog_page.dart';

class HomeContainerPage extends StatefulWidget {
  final SeeMoreClickListener listener;
  final int tabIndex;

  HomeContainerPage(this.listener, this.tabIndex, {Key key}) : super(key: key);

  @override
  HomeContainerFragmentState createState() => new HomeContainerFragmentState();
}

class HomeContainerFragmentState extends State<HomeContainerPage>
    with SingleTickerProviderStateMixin {
  static const String PREF_KEY_TAB_INDEX = "pref_key_tab_index";
  TabController controller;
  double screenWidth;

  HomeContainerFragmentState() {
    //controller?.dispose();
    //controller = new TabController(length: 2, initialIndex: 0);
  }

  @override
  void initState() {
    super.initState();
    controller = new TabController(
        length: 2, initialIndex: widget.tabIndex, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if ((oldWidget as HomeContainerPage).tabIndex != widget.tabIndex) {
      controller.index = widget.tabIndex;
    }
  }

  /*_saveTabIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("saveTabIndex: ${controller?.index}");
    prefs.setInt(PREF_KEY_TAB_INDEX, controller?.index);
  }

  Future<int> _restoreTabIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int tabIndex = prefs.getInt(PREF_KEY_TAB_INDEX);
    return tabIndex != null ? tabIndex : controller?.index;
  }*/

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    print("Width$screenWidth");
    print('Index Change Status>>${controller
        .indexIsChanging} and previous index>>${controller.previousIndex}');

    return new Scaffold(
      appBar: new PreferredSize(
        preferredSize: new Size(kTextTabBarHeight, screenWidth),
        child: new Material(
          color: Colors.white,
          elevation: 4.0,
          child: new TabBar(
            controller: controller,
            isScrollable: true,
            labelStyle: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: MyStyle.font16,
                fontFamily: 'Zawgyi-One'),
            tabs: <Widget>[
              new Container(
                child: new Tab(text: "Home"),
                margin: new EdgeInsets.only(
                    left: screenWidth / 6.0, right: screenWidth / 6.0),
              ),
              new Container(
                child: new Tab(
                  text: "က်န္းမာေရးပညာေပး",
                ),
                margin: new EdgeInsets.only(
                    left: screenWidth / 12.0, right: screenWidth / 12.0),
              )
            ],
            labelColor: Colors.orange,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.orange,
          ),
        ),
      ),
      body: new TabBarView(
        children: <Widget>[
          new HomePage(widget.listener),
          new FilterHealthEducationDialogFragment()
        ],
        controller: controller,
      ),
      bottomNavigationBar: new CustomBottomNavigationBar(),
    );

    /*return new DefaultTabController(
      length: 2,
      child: new Scaffold(
        primary: false,
        body: new NestedScrollViefiltw(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverAppBar(
                primary: false,
                forceElevated: innerBoxIsScrolled,
                pinned: true,
                floating: true,
                snap: true,
                bottom: new TabBar(
                  tabs: <Tab>[
                    new Tab(text: 'green'),
                    new Tab(text: 'purple'),
                  ],
                ),
              ),
            ];
          },
          body: new TabBarView(
            children: <Widget>[
              new Center(
                child: new Container(
                  height: 1000.0,
                  color: Colors.green.shade200,
                  child: new Center(
                    child: new FlutterLogo(colors: Colors.green),
                  ),
                ),
              ),
              new Center(
                child: new Container(
                  height: 1000.0,
                  color: Colors.purple.shade200,
                  child: new Center(
                    child: new FlutterLogo(colors: Colors.purple),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );*/
  }
}
