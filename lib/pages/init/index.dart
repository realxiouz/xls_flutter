import 'dart:convert';

import 'package:demo/common/sp_util.dart';
import 'package:demo/provide/me.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

class InitPage extends StatefulWidget {
  InitPage({Key key}) : super(key: key);

  @override
  _InitPageState createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 375,height: 667)..init(context);
    MeProvide meProvide = Provide.value<MeProvide>(context);

    SP.getString(SPs.USER).then((s){
      if (s != null) {
        meProvide.setUserInfo(jsonDecode(s));
      }
    });

    return Container(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
           FlatButton(
             child: Text('go!', style: TextStyle(color: Colors.white),),
             onPressed: (){
               String path = meProvide.hasLogin ? '/index' : '/login';
               Navigator.of(context).pushReplacementNamed(path);
             },
           )
         ],
       ),
    );
  }
}