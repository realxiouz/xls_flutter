import 'package:demo/pages/auth/login.dart';
import 'package:demo/pages/shop/goods/index.dart';
import 'package:demo/provide/me.dart';
import 'package:demo/provide/tim.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provide/provide.dart';
import './pages/index_page.dart';
import './pages/auth/register.dart';
import './pages/web_page.dart';
import './pages/init/index.dart';
import './pages/tim/message.dart';
import './pages/tim/chat.dart';
import 'pages/tim/demo.dart';

void main() {
  Providers providers = Providers();
  MeProvide meProvide = MeProvide();
  TimProvide timProvide = TimProvide();
  providers..provide(Provider<MeProvide>.value(meProvide))
    ..provide(Provider<TimProvide>.value(timProvide));
  runApp(
    ProviderNode(
      child: MyApp(),
      providers: providers,
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // debugPaintSizeEnabled = true;
    // debugPaintPointersEnabled = true;
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.pink),
      home: Center(child: InitPage(),),
      routes: {
        '/init': (context) => InitPage(),
        '/index': (context) => IndexPage(),
        '/register': (context) => Register(),
        '/login': (context) => Login(),
        '/web_view': (context) => WebPage(),
        '/goods': (context) => GoodsPage(),
        '/tim/message': (context) => MessagePage(),
        '/tim/chat': (context) => ChatPage(),
        '/tim/demo': (context) => DemoPage(),
      },
    );
  }
}