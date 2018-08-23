import 'package:flutter_lyc/ui/login/data/account.dart';

abstract class LoginContract{
  void showLandingPage();
  void saveDataToPrefs(Account account);
}