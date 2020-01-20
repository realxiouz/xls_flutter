import 'package:flutter/material.dart';

class MeProvide extends ChangeNotifier {
  bool hasLogin = false;
  Map userInfo = {};

  void setHasLogin(isLogin) {
    hasLogin = isLogin;
    notifyListeners();
  }

  void setUserInfo(info) {
    userInfo = info;
    setHasLogin(true);
    notifyListeners();
  }
}