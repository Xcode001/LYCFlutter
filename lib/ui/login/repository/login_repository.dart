import 'dart:async';
import 'package:flutter_lyc/ui/login/data/account.dart';

abstract class LoginRepository{
  Future<Account> sendAccessToken(String accessToken);
}