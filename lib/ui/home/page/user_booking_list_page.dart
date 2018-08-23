import 'package:flutter/material.dart';
import 'package:flutter_lyc/base/mystyle.dart';
import 'package:flutter_lyc/base/data/pagination.dart';
import 'package:flutter_lyc/base/widget/base_widget.dart';
import 'package:flutter_lyc/utils/mySharedPreferences.dart';
import 'package:flutter_lyc/utils/configs.dart';
import 'package:flutter_lyc/ui/home/data/booking.dart';
import 'package:flutter_lyc/ui/home/widget/create_booking_item.dart';
import 'package:flutter_lyc/ui/home/presenter/user_booking_presenter.dart';
import 'package:flutter_lyc/ui/home/contract/user_booking_contract.dart';

class UserBookingListPage extends StatefulWidget {
  @override
  UserBookingListPageState createState() {
    return new UserBookingListPageState();
  }
}

class UserBookingListPageState extends State<UserBookingListPage>
    implements UserBookingContract {
  var colorList = [
    MyStyle.colorGreen,
    MyStyle.colorAccent,
    MyStyle.colorRed,
    MyStyle.colorBlack,
    MyStyle.colorRed
  ];
  int status;
  bool isGuest;
  bool isLogin;
  String accessCode;
  bool isLoading = true;
  UserBookingPresenter mPresenter;
  List<Booking> bookingList = new List<Booking>();
  Pagination pagination;
  MySharedPreferences mySharedPreferences = new MySharedPreferences();
  ScrollController controller = new ScrollController();

  UserBookingListPageState() {
    mPresenter = new UserBookingPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    mySharedPreferences
        .getBooleanData(Configs.PREF_USER_LOGIN)
        .then((val) => setState(() {
              isLogin = val != null ? val : false;
              _getAccessCode(isLogin);
            }));

    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        print('Get More');
        if (pagination.currentPage < pagination.lastPage)
          mPresenter.getMoreBookingList(
              accessCode, status, pagination.currentPage + 1);
      }
    });
  }

  _getAccessCode(bool login) {
    if (login) {
      mySharedPreferences
          .getStringData(Configs.PREF_USER_ACCESS_CODE)
          .then((val) => setState(() {
                accessCode = val;
                isGuest = false;
                mPresenter.getBookingList(accessCode, null, null);
              }));
    } else {
      setState(() {
        isGuest = true;
        accessCode = Configs.GUEST_CODE;
        mPresenter.getBookingList(accessCode, null, null);
      });
    }
    print('AccessCode$accessCode And IsGuest $isGuest');
  }

  Widget getButtonState(int status) {
    Color activeTextColor = MyStyle.colorWhite;
    Color inactiveBgColor = MyStyle.colorWhite;
    Color colorConfirmed = colorList[0];
    Color colorRequested = colorList[1];
    Color colorUnavailable = colorList[2];
    Color colorComplete = colorList[3];
    Color colorCancelled = colorList[4];

    return new SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(MyStyle.double4),
      controller: new ScrollController(),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new RaisedButton(
              onPressed: () => _clickButton(0),
              child: new Text(
                'Confirmed',
                style: MyStyle.customTextStyle(
                    status == 0 ? activeTextColor : colorConfirmed),
              ),
              color: status == 0 ? colorConfirmed : inactiveBgColor,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0))),
          new Padding(padding: const EdgeInsets.only(right: MyStyle.double4)),
          new RaisedButton(
              onPressed: () => _clickButton(1),
              child: new Text(
                'Requested',
                style: MyStyle.customTextStyle(
                    status == 1 ? activeTextColor : colorRequested),
              ),
              color: status == 1 ? colorRequested : inactiveBgColor,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0))),
          new Padding(padding: const EdgeInsets.only(right: MyStyle.double4)),
          new RaisedButton(
              onPressed: () => _clickButton(2),
              child: new Text(
                'Unavailable',
                style: MyStyle.customTextStyle(
                    status == 2 ? activeTextColor : colorUnavailable),
              ),
              color: status == 2 ? colorUnavailable : inactiveBgColor,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0))),
          new Padding(padding: const EdgeInsets.only(right: MyStyle.double4)),
          new RaisedButton(
              onPressed: () => _clickButton(3),
              child: new Text(
                'Complete',
                style: MyStyle.customTextStyle(
                    status == 3 ? activeTextColor : colorComplete),
              ),
              color: status == 3 ? colorComplete : inactiveBgColor,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0))),
          new Padding(padding: const EdgeInsets.only(right: MyStyle.double4)),
          new RaisedButton(
              onPressed: () => _clickButton(4),
              child: new Text(
                'Cancelled',
                style: MyStyle.customTextStyle(
                    status == 4 ? activeTextColor : colorCancelled),
              ),
              color: status == 4 ? colorCancelled : inactiveBgColor,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0))),
          new Padding(padding: const EdgeInsets.only(right: MyStyle.double4)),
        ],
      ),
    );
  }

  Widget showLoadingOrData(BuildContext context) {
    if (!isLoading) {
      isLoading = true;
      return new Container(
          color: MyStyle.colorWhite,
          margin: const EdgeInsets.only(left:MyStyle.double4,right: MyStyle.double4,top: MyStyle.double52,),
          padding: const EdgeInsets.all(0.0),
          child: new ListView.builder(
            itemBuilder: _buildBookingItem,
            controller: new ScrollController(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: pagination != null
                ? bookingList.length + 1
                : bookingList.length,
          ));
    } else {
      return new Container(
          child: new Center(
        child: BaseWidgets.loadingIndicator,
      ));
    }
  }

  void _clickButton(int mStatus) {
    setState(() {
      status = mStatus;
      mPresenter.getBookingList(accessCode, status, null);
    });
  }

  Widget _buildBookingItem(BuildContext context, int index) {
    if (index == bookingList.length) {
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
    } else {
      return new BookingItems(bookingList[index], bookingList[index].status);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: MyStyle.layoutBackground,
      body: new Container(
          padding: const EdgeInsets.symmetric(
              horizontal: MyStyle.double4, vertical: MyStyle.double10),
          child:
          /*new SingleChildScrollView(
            scrollDirection: Axis.vertical,
            controller: controller,
            child: */
            new Center(
                child: new Stack(
              children: <Widget>[
                new Positioned(
                  child: getButtonState(status),
                  top: 0.0,
                ),
                showLoadingOrData(context)
              ],
            )),
          ),
    );
  }

  @override
  void showNoRecordLayout(List<Booking> b) {}

  @override
  void showBookingList(List<Booking> b, int status) {
    setState(() {
      if (bookingList != null) bookingList.clear();
      bookingList = b;
      isLoading = false;
    });
    print('Booking Data ${bookingList.length}');
  }

  @override
  void setPagination(Pagination p) {
    setState(() {
      pagination = p;
    });
  }

  @override
  void showMoreBookingList(List<Booking> b) {
    setState(() {
      bookingList.addAll(b);
      isLoading = false;
    });
  }

  @override
  void showCancelledBookingList(List<Booking> b) {}

  @override
  void showCompleteBookingList(List<Booking> b) {}

  @override
  void showUnavailableBookingList(List<Booking> b) {}

  @override
  void showRequestedBookingList(List<Booking> b) {}

  @override
  void showConfirmedBookingList(List<Booking> b) {}

  @override
  void showAllBookingList(List<Booking> b) {}

  @override
  void onLoadError() {}
}
