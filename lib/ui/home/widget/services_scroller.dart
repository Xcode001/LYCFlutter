import 'package:flutter/material.dart';
import 'package:flutter_lyc/base/mystyle.dart';
import 'package:flutter_lyc/ui/service/data/service.dart';
import 'package:flutter_lyc/ui/service/page/sub_services_list_page.dart';

class ServicesScroller extends StatelessWidget {
  ServicesScroller(this.services);

  final List<Service> services;

  _clickServiceItem(BuildContext context, int catId, String catName) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (_) => new SubServiceListPage(catId, catName)));
  }

  Widget _buildServiceScroller(BuildContext context, int index) {
    var service = services[index];
    return new Padding(
        padding: const EdgeInsets.only(right: MyStyle.double12),
        child: new InkWell(
            onTap: () => _clickServiceItem(context, service.id, service.name),
            child: new Column(
              children: <Widget>[
                new ClipRRect(
                  child: new Image.network(service.image,
                      fit: BoxFit.fill,
                      height: 130.0,
                      width: 130.0,
                      scale: 6.0),
                  borderRadius: new BorderRadius.circular(3.0),
                ),
                new Container(
                    width: 130.0,
                    child: new Text(
                      service.name,
                      textAlign: TextAlign.left,
                      maxLines: 3,
                      style: new TextStyle(letterSpacing: 0.5),
                    ))
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new SizedBox.fromSize(
            size: const Size.fromHeight(220.0),
            child: new ListView.builder(
              itemBuilder: _buildServiceScroller,
              itemCount: services.length,
              scrollDirection: Axis.horizontal,
              padding: new EdgeInsets.only(top: 15.0, left: 0.0),
            ))
      ],
    );
  }
}
