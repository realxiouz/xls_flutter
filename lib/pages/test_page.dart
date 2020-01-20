import 'package:demo/provide/me.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
         appBar: AppBar(
           title: Text('TestPage'),
         ),
         body: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[
             Container(
               child: FlatButton(
                 child: Text('edit user provide'),
                 onPressed: () {
                   MeProvide meProvide = Provide.value<MeProvide>(context);
                   meProvide.setUserInfo({
                     "level": 2,
                     "avatar": "https://v4oss.sirme.tv/data/images_user/5dfc3c9709118.jpg",
                     "id": "10086",
                     "nickname": "啦啦啦173"
                   });
                 },
               ),
             ),
             Container(
               child: FlatButton(
                 child: Text('tim'),
                 onPressed: (){
                   Navigator.pushNamed(context, '/tim/message');
                 },
               ),
             ),
             Container(
               child: FlatButton(
                 child: Text('tim-demo'),
                 onPressed: (){
                   Navigator.pushNamed(context, '/tim/demo');
                 },
               ),
             )
           ],
         ),
       ),
    );
  }
}