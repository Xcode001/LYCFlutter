import 'dart:async';
import 'package:flutter_lyc/ui/base/data/site_info.dart';
import 'package:flutter_lyc/ui/base/data/unread_status.dart';
import 'package:flutter_lyc/ui/home/data/profile_info.dart';

abstract class HomeContainerRepository {
  Future<SiteInfo> getSiteInfo(String accessCode);

  Future<UnreadStatus> getUnreadStatus(String accessCode);

  Future<ProfileInfo> getProfileInfo(String accessCode);

  Future<ProfileInfo> updateUserPhoneNo(String accessCode, String phone);
}
