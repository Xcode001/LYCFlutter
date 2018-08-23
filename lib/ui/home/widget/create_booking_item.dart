import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_lyc/base/widget/vertical_divider.dart';
import 'package:flutter_lyc/base/mystyle.dart';
import 'package:flutter_lyc/ui/home/data/booking.dart';
import 'package:flutter_lyc/ui/doctors/page/doctor_details_page.dart';

class BookingItems extends StatefulWidget {
  final Booking booking;
  final int status;

  BookingItems(this.booking, this.status);

  @override
  BookingItemsState createState() {
    return new BookingItemsState();
  }
}

class BookingItemsState extends State<BookingItems> {
  String _youHave = "You have ";
  String _requested = "requested";
  String _bookingFor = " booking for ";
  String _yourBookingFor = "Your booking for ";
  String _with = " with ";
  String _is = " is ";
  String _date;
  String _doctor;
  String _bookingDate;
  String _fullStop = ".";

  var status = ["approved", "pending", "unavailable", "completed", "cancelled"];

  var mNormalSpan = new TextStyle(
      color: MyStyle.colorBlack, fontSize: MyStyle.font16);
  var mBoldSpan = new TextStyle(
      color: MyStyle.colorBlack,
      fontSize: MyStyle.font16,
      fontWeight: FontWeight.bold);
  var mRequestedSpan = new TextStyle(
      color: MyStyle.colorPrimary,
      fontSize: MyStyle.font16,
      fontWeight: FontWeight.bold);
  var mUnavailableSpan = new TextStyle(
      color: MyStyle.colorRed,
      fontSize: MyStyle.font16,
      fontWeight: FontWeight.bold);
  var mConfirmSpan = new TextStyle(
      color: MyStyle.colorGreen,
      fontSize: MyStyle.font16,
      fontWeight: FontWeight.bold);
  var mDateSpan = new TextStyle(
    color: MyStyle.colorDarkGrey,
    fontWeight: FontWeight.bold,
  );
  var mDoctorSpan = new TextStyle(
      color: MyStyle.colorDarkGrey,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline);

  Widget _getSpannableString() {
    var style = [
      mConfirmSpan,
      mRequestedSpan,
      mUnavailableSpan,
      mNormalSpan,
      mUnavailableSpan
    ];
    _date = widget.booking.time;
    _doctor = widget.booking.doctorName;
    if (widget.booking.status == 1) {
      return new RichText(
        text: new TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            new TextSpan(
              text: _youHave,
              style: mNormalSpan,
            ),
            new TextSpan(
              text: _requested,
              style: mBoldSpan,
            ),
            new TextSpan(
              text: _bookingFor,
              style: mNormalSpan,
            ),
            new TextSpan(
              text: _date,
              style: mDateSpan,
            ),
            new TextSpan(
              text: _with,
              style: mNormalSpan,
            ),
            new TextSpan(
              text: _doctor,
              style: mDoctorSpan,
              recognizer: new TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (_) =>
                              new DoctorDetailsPage(widget.booking.doctor)));
                },
            ),
            new TextSpan(
              text: _fullStop,
              style: mNormalSpan,
            ),
          ],
        ),
      );
    } else {
      return new RichText(
        text: new TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            new TextSpan(
              text: _yourBookingFor,
              style: mNormalSpan,
            ),
            new TextSpan(
              text: _date,
              style: mDateSpan,
            ),
            new TextSpan(
              text: _with,
              style: mNormalSpan,
            ),
            new TextSpan(
                text: _doctor,
                style: mDoctorSpan,
                recognizer: new TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (_) =>
                                new DoctorDetailsPage(widget.booking.doctor)));
                  }),
            new TextSpan(
              text: _is,
              style: mNormalSpan,
            ),
            new TextSpan(
              text: status[widget.status],
              style: style[widget.status],
            ),
            new TextSpan(
              text: _fullStop,
              style: mNormalSpan,
            ),
          ],
        ),
      );
    }
  }

  Widget _getVerticalDivider(int status) {
    _bookingDate = widget.booking.time;
    _doctor = widget.booking.doctorName;
    Color _bookingStatusLineColor;
    switch (status) {
      case 0:
        _bookingStatusLineColor = MyStyle.colorGreen;
        break;
      case 1:
        _bookingStatusLineColor = MyStyle.colorAccent;
        break;
      case 2:
        _bookingStatusLineColor = MyStyle.colorRed;
        break;
      case 3:
        _bookingStatusLineColor = MyStyle.colorBlack;
        break;
      case 4:
        _bookingStatusLineColor = MyStyle.colorRed;
        break;
    }
    return new VerticalDivider(
        color: _bookingStatusLineColor,
        height: 70.0,
        width: 3.0,
        leftMargin: 0.0,
        rightMargin: 10.0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top:  MyStyle.double8, bottom:  MyStyle.double8),
        padding: const EdgeInsets.all(0.0),
        child: new Row(children: <Widget>[
          _getVerticalDivider(widget.status),
          new Expanded(child: _getSpannableString())
        ]));
  }
}
