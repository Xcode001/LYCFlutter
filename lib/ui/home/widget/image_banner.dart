import 'package:flutter/material.dart';
import 'package:xbanner/xbanner.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_lyc/ui/home/data/banner_data.dart';

class ImageBanner extends StatelessWidget {
  ImageBanner(this.bannerList);

  final List<BannerData> bannerList;

  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _clickBannerImage(BuildContext context, String url) {
    _launchUrl(url);
  }

  List<Widget> _getWidget(List<BannerData> bannerData, BuildContext context) {
    List<Widget> widgets = new List();
    for (int i = 0; i < bannerData.length; i++) {
      widgets.add(new InkWell(
        child: new ClipRRect(
          child: new Image.network(
            bannerData[i].img.toString(),
            height: 120.0,
            fit: BoxFit.fill,
          ),
          borderRadius: new BorderRadius.circular(5.0),
        ),
        onTap: () => _clickBannerImage(context, bannerData[i].link),
      ));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new ClipRRect(
        child: new XBanner(_getWidget(bannerList, context)),
        borderRadius: new BorderRadius.circular(5.0),
      ),
      height: 220.0,
    );
    /*return new SizedBox.fromSize(
        size: const Size.fromHeight(200.0),
        child: new XBanner(_getWidget(bannerList, context)));*/
  }
}
