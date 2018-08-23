import 'package:flutter/material.dart';
import 'package:flutter_lyc/base/mystyle.dart';
import 'package:flutter_lyc/ui/doctors/data/schedule.dart';

class SessionItems extends StatefulWidget {
  final List<String> scheduleArr = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];
  final List<Schedule> scheduleList;

  SessionItems(this.scheduleList);

  @override
  SessionItemState createState() {
    return new SessionItemState();
  }
}

class SessionItemState extends State<SessionItems> {
  List<Widget> widgets;
  int i = 0;
  int j = 4;

  _scheduleWidget() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        new Flexible(child: new Column(
          children: <Widget>[
            _getScheduleWidget(MyStyle.blankSchedule, i),
            _getScheduleWidget(MyStyle.blankSchedule, j),
          ],
        ),),
        new Flexible(child: new Column(
          children: <Widget>[
            _getScheduleWidget(MyStyle.blankSchedule, i + 1),
            _getScheduleWidget(MyStyle.blankSchedule, j + 1),
          ],
        ),),
        new Flexible(child: new Column(
          children: <Widget>[
            _getScheduleWidget(MyStyle.blankSchedule, i + 2),
            _getScheduleWidget(MyStyle.blankSchedule, j + 2),
          ],
        ),),
        new Flexible(child: new Column(
          children: <Widget>[
            _getScheduleWidget(MyStyle.blankSchedule, i + 3),
            new Opacity(
              opacity: 0.0,
              child: _getScheduleWidget(MyStyle.blankSchedule, i + 3),
            )
          ],
        ))
      ],
    );
  }

  _scheduleWidgetItems(bool status, String title, String subTitle) {
    Color mColor = status ? MyStyle.defaultGrey : MyStyle.colorDarkGrey;
    return new Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Icon(Icons.date_range, color: mColor, size: 20.0),
                new Icon(
                  Icons.access_time,
                  color: mColor,
                  size: 20.0,
                ),
              ],
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(title,
                    style: new TextStyle(fontSize: 12.0, color: mColor)),
                new Text(subTitle,
                    style: new TextStyle(fontSize: 12.0, color: mColor))
              ],
            )
          ],
        ));
  }

  _getScheduleWidget(String subTitle, int i) {
    Iterable<Schedule> temp;
    String time;
    if (i == 6) {
      temp = widget.scheduleList.where((s) => s.range == (i - 5));
    } else {
      temp = widget.scheduleList.where((s) => s.range == (i + 2));
    }
    time = temp.isNotEmpty ? temp.elementAt(0).time : subTitle;
    return _scheduleWidgetItems(temp.isEmpty, widget.scheduleArr[i], time);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.all(5.0),
      child: _scheduleWidget(),
    );
  }
}
