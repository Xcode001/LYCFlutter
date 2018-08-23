import 'package:flutter/material.dart';
import 'package:flutter_lyc/base/mystyle.dart';
import 'package:flutter_lyc/ui/doctors/data/doctor.dart';
import 'package:flutter_lyc/ui/doctors/page/doctor_details_page.dart';
import 'package:flutter_lyc/ui/doctors/widget/create_session_items.dart';

class CreateDoctorItem extends StatelessWidget {
  CreateDoctorItem(this.doctor);

  final Doctor doctor;
  final List<String> scheduleArr = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];

  _navigatorToDoctorDetails(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => new DoctorDetailsPage(doctor.id)));
  }

  @override
  Widget build(BuildContext context) {

    //Return Widget
    return new Container(
      margin: const EdgeInsets.only(top: MyStyle.double8),
        child: new Column(
      children: <Widget>[
        new InkWell(
          onTap: () => _navigatorToDoctorDetails(context),
          child: new Card(
            color: Colors.white,
            child: new Container(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Container(
                    padding: const EdgeInsets.only(left: MyStyle.double4, right: MyStyle.double4),
                    color: MyStyle.colorLightGrey,
                    child: new Center(
                      child: new Text(
                        doctor.role,
                        style: new TextStyle(
                          fontSize: MyStyle.font16,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    height: 40.0,
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(left: MyStyle.double4),
                    child: new Text(
                      doctor.name,
                      style: new TextStyle(
                        fontSize: MyStyle.font16,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(left: MyStyle.double4),
                    child: new Text(
                      doctor.degree,
                      style: new TextStyle(
                          fontSize: MyStyle.font12,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  new Padding(
                    padding: const EdgeInsets.all(MyStyle.double4),
                    child: new Divider(
                      height: 2.0,
                      color: Colors.grey,
                    ),
                  ),
                  new SessionItems(doctor.schedule),
                  new Container(
                    height: 15.0,
                    color: MyStyle.colorWhite,
                  ),
                ],
              ),
            ),
          ),
        ),
        new Container(
          height: 20.0,
          color: MyStyle.layoutBackground,
        ),
      ],
    ));
  }
}
