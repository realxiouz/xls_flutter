import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isPassword = true;
  IconData iconData = Icons.location_off;
  Timer codeTimer;
  String codeText = '获取验证码';
  int maxTime = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SafeArea(
         child: Container(
           width: double.infinity,
           height: double.infinity,
           color: Colors.white,
           child: Column(children: <Widget>[
            Padding(
              child: Text('注册', style: TextStyle(
                fontSize: 60.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                
              ), textAlign: TextAlign.left,),
              padding: EdgeInsets.all(10.0),
            ),
            TextFormField(
              maxLength: 16,
              validator: (val) {
                if (val.length < 4) {
                  return '至少4个字符';
                }
                return null;
              },
              autovalidate: true,
              decoration: InputDecoration(
                prefix: Text('+86')
              ),
            ),
            TextField(
              
              maxLength: 4,
              obscureText: false,
              decoration: InputDecoration(
                helperText: '请输入验证码',
                // labelText: '验证码',
                suffix: FlatButton(
                  child: Text('$codeText'),
                  onPressed: _getCode,
                ),
                
              ),
            ),
            TextField(
              maxLength: 16,
              obscureText: isPassword,
              decoration: InputDecoration(
                helperText: '请输入密码',
                // labelText: '密码',
                suffixIcon: IconButton(
                  icon: Icon(iconData),
                  onPressed: _toggleType,
                )
              ),
            ),
            FlatButton(
              onPressed: _submit,
              color: Colors.pink,
              
              child: Text(
                '确定',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
           ],),
         ),
       ),
    );
  }

  void _toggleType() {
    setState(() {
      isPassword = !isPassword;
      iconData = isPassword ? Icons.location_off : Icons.location_on;
    });
  }

  void _submit() {

  }

  void _getCode() {
    if (codeTimer != null) {
      Fluttertoast.showToast(
        msg: '请勿重复获取',
        backgroundColor: Colors.pink,
        textColor: Colors.white
      );
      return;
    }
    codeTimer = Timer.periodic(Duration(seconds: 1), (timer){
      setState(() {
        maxTime--;
        codeText = '剩余$maxTime秒';
        if (maxTime < 1) {
          codeTimer.cancel();
          codeTimer = null;
          maxTime = 10;
          codeText = '重新获取';
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    codeTimer?.cancel();
    codeTimer = null;
  }
}