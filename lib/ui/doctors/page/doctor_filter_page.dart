import 'package:flutter/material.dart';
import 'package:flutter_lyc/utils/configs.dart';
import 'package:flutter_lyc/base/mystyle.dart';
import 'package:flutter_lyc/ui/doctors/data/doctor_role.dart';
import 'package:flutter_lyc/ui/doctors/page/doctor_list_page.dart';
import 'package:flutter_lyc/ui/doctors/contract/doctor_filter_contract.dart';
import 'package:flutter_lyc/ui/doctors/presenter/doctor_filter_presenter.dart';

class DoctorFilterPage extends StatefulWidget {
  final FilterListener listener;

  DoctorFilterPage(this.listener);

  @override
  DoctorFilterPageState createState() {
    return new DoctorFilterPageState();
  }
}

class DoctorFilterPageState extends State<DoctorFilterPage>
    implements DoctorFilterContract {
  int goupValue;
  DoctorFilterPresenter mPresenter;
  List<DoctorRole> doctorRoles = new List<DoctorRole>();
  List<DoctorRole> tempList = new List<DoctorRole>();
  List<DoctorRole> selectedLit = new List<DoctorRole>();

  DoctorFilterPageState() {
    mPresenter = new DoctorFilterPresenter(this);
  }

  _clickListItem(BuildContext context) {
    List<int> catList = List<int>();
    if (selectedLit.isNotEmpty) {
      for (int i = 0; i < selectedLit.length; i++) {
        catList.add(selectedLit[i].id);
      }
    }
    Navigator.push(context,
        new MaterialPageRoute(builder: (_) => new DoctorListPage(catList)));
  }

  @override
  void initState() {
    super.initState();
    mPresenter.getDoctorRole(Configs.GUEST_CODE);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
          child: new Stack(
        children: <Widget>[
          new Column(
            children: <Widget>[
              new Flexible(
                  child: new ListView.builder(
                padding: const EdgeInsets.only(top: MyStyle.double10),
                controller: new ScrollController(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: _buildSpecialityList,
                itemCount: doctorRoles.length,
              )),
            ],
          ),
        ],
      )),
    );
  }

  Widget _buildSpecialityList(BuildContext context, int index) {
    var doctorRole = doctorRoles[index];
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new ListTile(
          title: new Text(
            doctorRole.name,
            style: new TextStyle(
                color: MyStyle.colorGrey, fontSize: MyStyle.font14),
          ),
          trailing: new Icon(Icons.chevron_right, color: MyStyle.colorGrey),
          onTap: () {
            setState(() {
              selectedLit.add(doctorRoles[index]);
              _clickListItem(context);
            });
          },
        ),
        new Padding(
          padding: const EdgeInsets.only(
              left: MyStyle.double10, right: MyStyle.double10),
          child: new Divider(
            color: MyStyle.defaultGrey,
            height: 1.0,
          ),
        )
      ],
    );
  }

  @override
  void showRoles(List<DoctorRole> r) {
    setState(() {
      doctorRoles = r;
      tempList.clear();
      tempList.addAll(r);

      /*if (DataUtils.isExist(mContext, Configs.OBJ_DOC_ROLES)) {
        if (DataUtils.ReadArraylist(mContext, Configs.OBJ_DOC_ROLES) != null) {
          val s = DataUtils.ReadArraylist(mContext, Configs.OBJ_DOC_ROLES) as ArrayList<Int>
          if (s.isNotEmpty()) {
            for (i in 0 until s.size) {
              (0 until r.size)
                  .filter { s[i] == r[it].id }
          .forEach { r[it].isSelected = true }
    }
    }
    }
    }*/
    });
    print('Doctor Role $doctorRoles');
  }
}

abstract class FilterListener {
  void onChooseFilters(List<int> roleList);
}
