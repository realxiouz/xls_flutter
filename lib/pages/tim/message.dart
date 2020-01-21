import 'dart:convert';

import 'package:demo/common/const.dart';
import 'package:demo/provide/tim.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:dim/dim.dart';

import 'dart:math';

import 'package:provide/provide.dart';

class MessagePage extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MessagePage> {
  Dim _dim = Dim();

  int appid = Const.TIM_APPID;

  StreamSubscription<dynamic> _messageStreamSubscription;

  @override
  void initState() {
    super.initState();

    initListener();
  }

  Future<void> initListener() async {
    if (!mounted) return;

    if (_messageStreamSubscription == null) {
      _messageStreamSubscription = _dim.onMessage.listen((dynamic onData) {
        List a = json.decode(onData);
        if (a.length == 0) {
          print('这个是会话');
        } else {
          print('消息列表');
        }
        print(onData);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _messageStreamSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {

    TimProvide tim = Provide.value<TimProvide>(context);

    // _dim.init(Const.TIM_APPID)
    //   .then((r){
    //     print('--->' + 'tim init done!');
    //     return _dim.imLogin('2434830', 'eJxNjVFvgjAURv8LryyzLSCwxAfmeBBw6hjhxaQBWklrLF0tTln87*uIZr6ec8-9fqzPLH*umqbrhcb6Iqn1YgHracSMUKHZjlFlIHIdN3DuqpKSEVxp7CjyUBzJHo-KMOgCAJADgvAm6VkyRXG10*ND6HkeMic3e6LqyDrxtwSgB00I-qVmBzomfugBH7r*fY*1Bi-jYr6I5ijdThaKZygd2g7ZIq170nThdLonHyuaF5tBcHs4tEkbsTjqm5Nqvot1IKMvwTd2WfecJ*tXZGflarjE28l7Up-f4LLMwcy6-gJWdFgd');
    //   })
    //   .then((r){
    //     print('--->' + 'login success!');
    //   })
    //   .catchError((e){
    //     print(e);
    //     print('--->' + 'login error!');
    //   })
    //   .whenComplete((){
    //     return _dim.getConversations();
    //   })
    //   .then((r){
    //     print('--->' + 'getConversations!');
    //     print(r);
    //     var res = r != null ? json.decode(r) : [];
    //     tim.updateAllConversation(res);
    //   })
    //   ;

    // _dim.init(Const.TIM_APPID).then((r){
    //   return _dim.getConversations();
    // }).then((r){
    //   // print(r);
    //   var res = json.decode(r);
    //   tim.updateAllConversation(res);
    // });
    
    _dim.init(Const.TIM_APPID).then((r){
      _dim.imLogin(tim.currentPeer, 'eJxNjVFvgjAURv8LryyzLSCwxAfmeBBw6hjhxaQBWklrLF0tTln87*uIZr6ec8-9fqzPLH*umqbrhcb6Iqn1YgHracSMUKHZjlFlIHIdN3DuqpKSEVxp7CjyUBzJHo-KMOgCAJADgvAm6VkyRXG10*ND6HkeMic3e6LqyDrxtwSgB00I-qVmBzomfugBH7r*fY*1Bi-jYr6I5ijdThaKZygd2g7ZIq170nThdLonHyuaF5tBcHs4tEkbsTjqm5Nqvot1IKMvwTd2WfecJ*tXZGflarjE28l7Up-f4LLMwcy6-gJWdFgd')
        .then((r){}, onError: (e){
          _dim.getConversations().then((r){
            var res = json.decode(r);
            tim.updateAllConversation(res);
          });
        });
    }, onError: (e){})
    ;
    return new MaterialApp(
      home: new Scaffold(
        appBar: AppBar(
          title: Text('tim'),
          leading: InkWell(
            child: Icon(Icons.arrow_back),
            onTap: (){
              Navigator.pop(context);
            },
          ),
        ),
        body: new Center(
          child: ListView.builder(
            itemCount: tim.allConversation.length,
            itemBuilder: (context1, inx) {
              return InkWell(
                child: Text(tim.allConversation[inx]['peer'], style: TextStyle(color: Colors.black),),
                onTap: (){
                  _dim.getMessages(tim.allConversation[inx]['peer'])
                    .then((r){
                      tim.setMessageList(json.decode(r));
                      print(tim.currentMessageList);
                      Navigator.pushNamed(context, '/tim/chat', arguments: {
                        'peer': tim.allConversation[inx]['peer']
                      });
                    })
                    .catchError((e){
                      print(e);
                    });
                },
              );
            },
          ),
        ),
      ),
    );
  }
}