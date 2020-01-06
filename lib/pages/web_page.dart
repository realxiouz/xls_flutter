import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatelessWidget {
  // String url;

  // String title;
  // WebPage(this.url, this.title);

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   height: double.infinity ,
    //   child: Scaffold(
    //     appBar: AppBar(title: Text('web_view'),),
    //     body: WebView(
    //       initialUrl: url,
    //       javascriptMode: JavascriptMode.unrestricted,
    //       onWebViewCreated: (c){
    //         print('111');
    //       },
    //       onPageStarted: (s){
    //         print(s);
    //       },
    //     ),
    //   ),
    // );
    dynamic args = ModalRoute.of(context).settings.arguments;
    return WebviewScaffold(
      withJavascript: true,
      url: args['url'],
      appBar: AppBar(title: Text(args['title']??'web_view'),),
      javascriptChannels: <JavascriptChannel>[
        JavascriptChannel(
          name: 'test',
          onMessageReceived: (msg) {
            Fluttertoast.showToast(msg: msg.message);
          }
        )
      ].toSet(),
      initialChild: Container(
        alignment: Alignment.center,
        child: CupertinoActivityIndicator(),
      ),
      
    );
  }
}