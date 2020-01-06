import 'package:flutter/material.dart';
import './pages/index_page.dart';
import './pages/auth/register.dart';
import './pages/web_page.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.pink),
      home: Center(child: IndexPage(),),
      routes: {
        '/register': (context) => Register(),
        '/web_view': (context) => WebPage()
      },
    );
  }
}