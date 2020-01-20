import 'dart:async';
import 'dart:convert';

import 'package:demo/common/base.dart';
import 'package:demo/common/sp_util.dart';
import 'package:demo/provide/me.dart';
import 'package:flutter/material.dart';
import 'package:demo/common/request.dart';
import 'package:provide/provide.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isPassword = true;
  IconData iconData = Icons.location_off;

  Map<String, dynamic> formData = {
    'username': '',
    'password': '',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: Base.w(375),
          height: double.infinity,
          color: Colors.white,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text('您好，请登录',
                    style: TextStyle(
                      fontSize: Base.f(30),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.left),
                // padding: EdgeInsets.all(10.0),
              ),
              TextFormField(
                maxLength: 11,
                validator: (val) {
                  if (val.length != 11) {
                    return '11个字符';
                  }
                  return null;
                },
                autovalidate: true,
                decoration: InputDecoration(prefix: Text('+86')),
                onChanged: (val) {
                  formData['username'] = val;
                },
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
                    )),
                onChanged: (val) {
                  formData['password'] = val;
                },
              ),
              Center(
                child: Container(
                  width: Base.w(300),
                  height: Base.w(40),
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(Base.w(20)),
                  // ),
                  child: FlatButton(
                    onPressed: () {
                      _submit(context);
                    },
                    color: Colors.pink,
                    child: Text(
                      '登 录',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Base.w(20))
                    ),
                  ),
                ),
              )
            ],
          ),
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

  void _submit(context) {
    DioUtils.post('login', data: this.formData)
        .then((res) {
          print(res.data['data']);
          Provide.value<MeProvide>(context).setUserInfo(res.data['data']);
          Navigator.pushReplacementNamed(context, '/index');
          SP.saveString(SPs.USER, jsonEncode(res.data['data']));
        })
        .catchError((e) {})
        .whenComplete(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }
}
