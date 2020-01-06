import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class CommunityPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LocalState();
  }
}

class LocalState extends State<CommunityPage> {
  String txt = 'hello world';
  String input = '';
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            TextField(
              // controller: TextEditingController(),
              onChanged: (val){
                setState(() {
                  input = val;
                });
              },
              decoration: InputDecoration(
                helperText: 'pls input',
                
              ),
            ),
            Divider(),
            RaisedButton(
              child: Text('get data'),
              onPressed: (){
                _getData(input);
              },
            ),
            Container(
              height: 300.0,
              child: SingleChildScrollView(
                child: Text(txt),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _getData(String val) async {
    Response r;
    r = await Dio().get('https://a.sirme.tv/mobile/v3/index/top');
    setState(() {
      txt = r.toString();
    });
  }
}