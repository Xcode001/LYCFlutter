import 'package:flutter/material.dart';
import 'package:flutter_lyc/base/widget/vertical_divider.dart';
import 'package:flutter_lyc/base/mystyle.dart';
import 'package:flutter_lyc/ui/home/data/booking.dart';

class BookingItems extends StatefulWidget {
  final Booking booking;

  BookingItems(this.booking);

  @override
  BookingItemsState createState() {
    return new BookingItemsState();
  }
}

class BookingItemsState extends State<BookingItems> {
  //String _doctor;
  //String _boking_date;
  var status = ["unavailable", "pending", "approved", "completed", "cancelled"];

  Widget _getVerticalDivider(int status) {
    Color _bookingStatusLineColor;
    switch (status) {
      case 0:
        _bookingStatusLineColor = MyStyle.colorRed;
        break;
      case 1:
        _bookingStatusLineColor = MyStyle.colorAccent;
        break;
      case 2:
        _bookingStatusLineColor = MyStyle.colorGreen;
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
        height: 50.0,
        width: 3.0,
        leftMargin: 0.0,
        rightMargin: 10.0);
  }

  Widget _getSpannableString(BuildContext mContext) {
    return new RichText(
      text: new TextSpan(
        style: new TextStyle(
          fontSize: 14.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          new TextSpan(text: 'Hello'),
          new TextSpan(
              text: 'World', style: new TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(0.0),
        padding: const EdgeInsets.all(0.0),
        child: new Row(children: <Widget>[
          _getVerticalDivider(4),
          _getSpannableString(context)
        ]));
  }
}
