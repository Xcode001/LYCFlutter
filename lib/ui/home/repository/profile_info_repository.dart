import 'dart:async';
import 'package:flutter_lyc/ui/home/data/profile_info.dart';

abstract class ProfileInfoRepository{
  Future<ProfileInfo> getProfileInfo( String accessCode);
  Future<ProfileInfo> updateProfileInfo( String accessCode,  ProfileInfo profileInfo);
  Future<ProfileInfo> uploadProfilePhoto( String accessCode,  String filePath);
  void removeAllData();
}