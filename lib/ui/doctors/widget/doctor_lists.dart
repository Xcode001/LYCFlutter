import 'package:flutter/material.dart';
import 'package:flutter_lyc/base/mystyle.dart';
import 'package:flutter_lyc/base/data/pagination.dart';
import 'package:flutter_lyc/base/widget/base_widget.dart';
import 'package:flutter_lyc/ui/doctors/data/doctor.dart';
import 'package:flutter_lyc/ui/doctors/widget/create_doctor_buttons.dart';
import 'package:flutter_lyc/ui/doctors/widget/create_doctor_item.dart';

class DoctorLists extends StatelessWidget {
  final List<Doctor> doctors;
  final DoctorClickListener listener;
  final Pagination pagination;

  DoctorLists(this.doctors, this.listener, [this.pagination]);

  Widget _buildDoctorLists(BuildContext context, int index) {
    if (index == doctors.length) {
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
      var doctor = doctors[index];
      return new Stack(
        children: <Widget>[
          //Doctor Item Card
          new CreateDoctorItem(doctor),
          //Floating Action Button
          new Positioned(
            top: 0.0,
            bottom: 5.0,
            left: 10.0,
            right: 10.0,
            child: new CreateDoctorButton(doctor, listener),
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Doctor List ${doctors.length}');
    return new Container(
      child: new Padding(
          padding: const EdgeInsets.only(top: MyStyle.double10),
          child: new ListView.builder(
            shrinkWrap: true,
            controller: new ScrollController(),
            itemBuilder: _buildDoctorLists,
            itemCount: pagination != null ? doctors.length + 1 : doctors.length,
            scrollDirection: Axis.vertical,
          )),
    );
  }
}
