import 'package:demo/pages/auth/user_info.dart';
import 'package:demo/provide/me.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

import 'login.dart';



class MePage extends StatefulWidget {
  MePage({Key key}) : super(key: key);

  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  @override
  Widget build(BuildContext context) {
    return UserInfo();
  }
}