import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_lyc/base/mystyle.dart';
import 'package:flutter_lyc/ui/notification/data/review.dart';
import 'package:flutter_lyc/utils/configs.dart';
import 'package:flutter_lyc/ui/utils/time_utils.dart';
import 'package:flutter_lyc/ui/doctors/page/doctor_details_page.dart';

class ReviewNotificationWidget extends StatelessWidget {
  final Review review;


  ReviewNotificationWidget(this.review);

  Widget showDateAndTime() {
    if (review.timeAgo > 88640) {
      return new Text(
        TimeUtils.getDateWithoutHours(review.createDate),
        style: MyStyle.dateTimeTextStyle(),
      );
    } else {
      return new Row(
        children: <Widget>[
          new Text(
            TimeUtils.getTime(review.timeAgo),
            style: MyStyle.dateTimeTextStyle(),
          ),
          new Text('.')
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var image;
    var mNormalSpan = new TextStyle(
        color: MyStyle.colorBlack, fontSize: MyStyle.font14);
    var mDoctorSpan = new TextStyle(
        color: MyStyle.colorDarkGrey,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline);

    if (review.userId == 0 || review.user == Configs.ADMIN_NAME) {
      image = new AssetImage('assets/images/lyc.png');
    } else if (review.image == '') {
      image = new AssetImage('assets/images/lyc.png');
    } else {
      image = new NetworkImage(review.image);
    }

    Widget _getSpannableString() {
      return new RichText(
        text: new TextSpan(
          //style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            new TextSpan(
              text: review.user + ' ',
              style: mNormalSpan,
            ),
            new TextSpan(
              text: review.mesg + ' ',
              style: mNormalSpan,
            ),
            new TextSpan(
              text: review.doctor,
              style: mDoctorSpan,
              recognizer: new TapGestureRecognizer()
                ..onTap = () {
                  print('Doctor Link');
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (_) =>
                          new DoctorDetailsPage(review.doctorId)));
                },
            ),
          ],
        ),
      );
    }

    return new Container(
        margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: image,
              radius: 20.0,
            ),
            new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.only(top: 0.0, left: 10.0),
                    child: _getSpannableString(),
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
