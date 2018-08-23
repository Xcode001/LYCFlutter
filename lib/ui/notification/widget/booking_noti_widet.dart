import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_lyc/base/mystyle.dart';
import 'package:flutter_lyc/ui/notification/data/booking.dart';
import 'package:flutter_lyc/ui/utils/time_utils.dart';
import 'package:flutter_lyc/ui/doctors/page/doctor_details_page.dart';

class BookingNotificationWidget extends StatelessWidget {
  final Booking booking;

  BookingNotificationWidget(this.booking);

  @override
  Widget build(BuildContext context) {
    String _youHave = "You have ";
    String _requested = "requested";
    String _bookingFor = " booking for ";
    String _yourBookingFor = "Your booking for ";
    String _with = " with ";
    String _is = " is ";
    String _fullStop = ".";

    String _date;
    String _doctor;
    var networkImage = new NetworkImage(booking.image);
    var localImage = new AssetImage('assets/images/lyc.png');

    var status = [
      "approved",
      "pending",
      "unavailable",
      "completed",
      "cancelled"
    ];

    var mNormalSpan =
        new TextStyle(color: MyStyle.colorBlack, fontSize: MyStyle.font14);
    var mBoldSpan = new TextStyle(
        color: MyStyle.colorBlack,
        fontSize: MyStyle.font14,
        fontWeight: FontWeight.bold);
    var mRequestedSpan = new TextStyle(
        color: MyStyle.colorPrimary,
        fontSize: MyStyle.font14,
        fontWeight: FontWeight.bold);
    var mUnavailableSpan = new TextStyle(
        color: MyStyle.colorRed,
        fontSize: MyStyle.font14,
        fontWeight: FontWeight.bold);
    var mConfirmSpan = new TextStyle(
        color: MyStyle.colorGreen,
        fontSize: MyStyle.font14,
        fontWeight: FontWeight.bold);
    var mDateSpan = new TextStyle(
      color: MyStyle.colorDarkGrey,
      fontWeight: FontWeight.bold,
    );
    var mDoctorSpan = new TextStyle(
        color: MyStyle.colorDarkGrey,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline);

    var tapRecognizer = new TapGestureRecognizer()
      ..onTap = () {
        print('Doctor Link');
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (_) => new DoctorDetailsPage(booking.doctor)));
      };

    Widget showDateAndTime() {
      if (booking.timeAgo > 88640) {
        return new Text(
          TimeUtils.getDateWithoutHours(booking.createDate),
          style: MyStyle.dateTimeTextStyle(),
        );
      } else {
        return new Row(
          children: <Widget>[
            new Text(
              TimeUtils.getTime(booking.timeAgo),
              style: MyStyle.dateTimeTextStyle(),
            ),
            new Text('.')
          ],
        );
      }
    }

    Widget _getSpannableString() {
      var style = [
        mConfirmSpan,
        mRequestedSpan,
        mUnavailableSpan,
        mNormalSpan,
        mUnavailableSpan
      ];
      _date = booking.time;
      _doctor = booking.doctorName;
      if (status == 1) {
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
                  text: _doctor, style: mDoctorSpan, recognizer: tapRecognizer),
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
                  text: _doctor, style: mDoctorSpan, recognizer: tapRecognizer),
              new TextSpan(
                text: _is,
                style: mNormalSpan,
              ),
              new TextSpan(
                text: status[booking.status],
                style: style[booking.status],
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

    Widget _getCustomMessage() {
      if (booking.customMesg != null && booking.customMesg != '') {
        return new Text(
          booking.customMesg,
          style: MyStyle.listItemTextStyle(),
        );
      } else {
        return _getSpannableString();
      }
    }

    return new Container(
        margin: const EdgeInsets.symmetric(
            horizontal: 0.0, vertical: MyStyle.double10),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: booking.image == "" ? localImage : networkImage,
              radius: 20.0,
            ),
            new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.only(top: 0.0, left: 10.0),
                    child: _getCustomMessage(),
                  ),
                  new Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                      child: showDateAndTime())
                ],
              ),
            )
          ],
        ));
  }
}
