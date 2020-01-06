import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('my'),),
      body: Container(
        child: RaisedButton(
          child: Text('Register'),
          onPressed: (){
            Navigator.pushNamed(context, '/register');
          },
        ),
      ),
    );  
  }
}