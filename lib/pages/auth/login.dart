// import 'dart:async';
import 'dart:convert';

import 'package:demo/common/base.dart';
import 'package:demo/common/sp_util.dart';
import 'package:demo/provide/me.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:demo/common/request.dart';
import 'package:provide/provide.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:demo/common/const.dart';

import 'package:crypto/crypto.dart';

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

  var imgs = [
    'https://v4oss.sirme.tv/data/attached/qrcode/20200317/user_share_vip_98592_150.jpg',
    'https://v4oss.sirme.tv/data/attached/qrcode/20200317/user_share_vip_98592_151.jpg',
    'https://v4oss.sirme.tv/data/attached/qrcode/20200317/user_share_vip_98592_152.jpg'
  ];

  int curInx = 0;

  String qrCodePath;

  @override
  void initState() {
    super.initState();
    fluwx.registerWxApi(appId: Const.WECHAT_APPID).then((data) {
      if (data) {
        print('fluwx init success!');
      }
    });

    // fluwx.onAuthGotQRCode.listen((img) {
    //   print(img);
    //   setState(() {
    //     qrCodePath = img.toString();
    //   });
    // });

    fluwx.weChatResponseEventHandler.listen((r) async{
      // print(r.errStr);
      // print(r.errCode);
      if (r is fluwx.WeChatAuthResponse) {
        print(r.code);
        // print('https://api.weixin.qq.com/sns/oauth2/access_token?appid=${Const.WECHAT_APPID}&secret=${Const.WECHAT_APPSECRECT}&code=${r.code}&grant_type=authorization_code');
        dynamic data = await Dio().get('https://api.weixin.qq.com/sns/oauth2/access_token?appid=${Const.WECHAT_APPID}&secret=${Const.WECHAT_APPSECRECT}&code=${r.code}&grant_type=authorization_code');
        print(data);
      }
      
    });
    
    // fluwx.auth

    // fluwx.responseFromAuth.listen((data) {
    //   print(data.toString());
    // }, onError: (e) {
    //   print(e);
    // }, onDone: () {
    //   print('done');
    // });
  }

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
                keyboardType: TextInputType.datetime,
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
                        borderRadius: BorderRadius.circular(Base.w(20))),
                  ),
                ),
              ),
              Container(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Text('去注册'),
                ),
              ),
              InkWell(
                onTap: _handleWechat,
                child: Text('wechat'),
              ),
              InkWell(
                onTap: _handleGit,
                child: Icon(
                  Icons.cake,
                  size: Base.w(50),
                ),
              ),
              Container(
                width: Base.w(375),
                height: Base.w(200),
                child: PageView.builder(
                  itemBuilder: (ctx, inx) {
                    return Container(
                      // child: Image.network(imgs[inx], fit: BoxFit.fill,),
                      margin: EdgeInsets.symmetric(horizontal: Base.w(6)),
                      // padding: EdgeInsets.symmetric(horizontal: Base.w(6)),
                      decoration: BoxDecoration(
                        // border: Border.all(),
                        borderRadius: BorderRadius.all(Radius.circular(Base.w(10))),
                        image: DecorationImage(
                          image: NetworkImage(imgs[inx]),
                          fit: BoxFit.fill
                        )
                      ),
                      // height: Base.w(400),
                    );
                  },
                  itemCount: imgs.length,
                  controller: PageController(
                    viewportFraction: 0.8,
                    
                  ),
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (inx) {
                    setState(() {
                      curInx = inx;
                    });
                  },
                  // physics: PageScrollPhysics(),
                ),
              ),
              Container(
                child: FlatButton(child: Text('map'), onPressed: (){
                  Navigator.pushNamed(context, '/map/demo');
                },),
              ),
              Container(
                padding: EdgeInsets.all(Base.w(20)),
                child: FlatButton(child: Text('wechat-share-img'), onPressed: (){
                  fluwx.WeChatShareImageModel model = fluwx.WeChatShareImageModel(
                    fluwx.WeChatImage.network('http://imgcache.gtimg.cn/ACT/svip_act/act_img/public/202003/1584585682_477x266.jpg'),
                    title: '呵呵',
                    description: 'miaoshu',
                    scene: fluwx.WeChatScene.SESSION
                  );
                  fluwx.shareToWeChat(model);
                },),
              ),
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

  void _handleWechat() async {
    // fluwx.authWeChatByQRCode(appId: Const.WECHAT_APPID, scope: 'noncestr', nonceStr: 'noncestr', timeStamp: null, signature: null);
    // dynamic access_token = await DioUtils.get('https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=${Const.WECHAT_APPID}&secret=${Const.WECHAT_APPSECRECT}');
    // print(access_token);
    // String access_token = '31_1FyNLWcnfTzxbQUCp2zjlqq4Oq7njPpkhen7aYYzI-HhinZwCVmEO_8plYGO4WLw-rPu3LX9I4TzaaL00q2R869p0DgVvXOmwlrejnwiwgWZKCuSV5fjZe00H-s2PPxFoWzgWwIVSE9YHZcfOCCiADAYMM';

    // dynamic ticket = await DioUtils.get('https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=$access_token&type=2');
    // print(ticket);

    // String ticket =
    //     'ZIBfsbn4HgG7s18-ojtsIpstjfjzZrtso4QmkP5kXTgS2bm4XJObQdi0MCiae_ByEcHzRkMN1WWj1gsFyGfaKQ';

    // int timestamp = DateTime.now().microsecondsSinceEpoch ~/ 1000;

    // Map<String, dynamic> map = {
    //   'appid': Const.WECHAT_APPID,
    //   'noncestr': 'helloworld',
    //   'sdk_ticket': ticket,
    //   'timestamp':  timestamp
    // };

    // String temp =
    //     'appid=${Const.WECHAT_APPID}&noncestr=helloworld&sdk_ticket=$ticket&timestamp=$timestamp';
    // var bytes = utf8.encode(temp);
    // var res = sha1.convert(bytes);
    // print(res);

    // dynamic data = await fluwx.authWeChatByQRCode(
    //     appId: Const.WECHAT_APPID,
    //     scope: 'noncestr',
    //     nonceStr: 'helloworld',
    //     timeStamp: timestamp.toString(),
    //     signature: res.toString());
    // print(data);

    dynamic d = await fluwx.sendWeChatAuth(
        // openId: Const.WECHAT_APPID,
        scope: 'snsapi_userinfo',
        state: "wechat_sdk_demo_test");

    // print(d);
    // 'wxb7c5a84d2e6663db'
    // fluwx.launchWeChatMiniProgram(username: 'gh_a95feff0db46');
  }

  void _handleGit() {
    String username = 'realxiouz@gmail.com';
    String pw = 'real20050607';
    String temp = '$username:$pw';

    var bytes = utf8.encode(temp);
    print(bytes);
    var res = base64Encode(bytes);
    print(res);
    var opt = BaseOptions(headers: {'Authorization': 'Basic $res'});
    var dio = Dio(opt);

    // auth token
    // dio.post('https://api.github.com/authorizations', data: {
    //   "scopes": ['user', 'repo', 'gist', 'notifications'],
    //   "note": "admin_script",
    //   "client_id": '14e0e049eb3fd4e101bb',
    //   "client_secret": 'a1a4fe6f3d2de4a48a6fa57da39136aa15486988'
    // }).then((r){
    //   print(r);

    // })
    // .catchError((e){

    //   print(e);
    // });

    // event
    dio.get('https://api.github.com/events').then((r) {
      print(r);
    }).catchError((e) {
      print(e);
    });
  }
}
