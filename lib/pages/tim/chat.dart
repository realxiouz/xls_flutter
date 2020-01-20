import 'package:demo/common/base.dart';
import 'package:demo/provide/tim.dart';
import 'package:dim/dim.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provide/provide.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String _inputVal = '';
  String _peer = '';
  TimProvide tim;
  Dim _dim = Dim();
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    tim = Provide.value<TimProvide>(context);
    dynamic params = ModalRoute.of(context).settings.arguments;
    _peer = params['peer'];

    return Container(
       child: Scaffold(
         appBar: AppBar(
           title: Text('与$_peer聊天中'),
           leading: InkWell(
             child: Icon(Icons.arrow_back),
             onTap: (){
               Navigator.pop(context);
             },
           ),
         ),
         body: ListView.builder(
           itemCount: tim.currentMessageList.length,
           itemBuilder: (context, inx) {
             return renderChatRow(tim.currentMessageList[inx]);
           },
         ),
         bottomNavigationBar: Container(
           decoration: BoxDecoration(
             color: Colors.cyan
           ),
           height: Base.w(50),
           child: renderBottomInput(),
          ),
                  ),
               );
             }
           
  Widget renderChatRow(dynamic bean) {
    // print(tim.currentPeer);
    print(tim.currentPeer == bean['sender']);
    return Row(
      mainAxisAlignment: tim.currentPeer == bean['sender'] ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Text(bean['sender']),
        getRowContent(bean)
      ],
    );
  }

  Widget getRowContent(dynamic bean) {
    switch (bean['message']['type']) {
      case 'Text':
        return Text(bean['message']['text']);
      case 'Image':
        return Container(
          child: Image.network(bean['message']['imageList'][1]['url']),
        );
      default:
        return Text('unsupport-type');
    }
  }

  Widget renderBottomInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            onChanged: (val){
              _inputVal = val;
            },
          ),
        ),
        FlatButton(
          onPressed: (){
            if (_inputVal.trim() != '') {
              _dim.sendTextMessages(_peer, _inputVal)
                .then((r){
                  _controller.clear();
                })
                .catchError((e){
                  print('--->err');
                });
            } else {
              Fluttertoast.showToast(msg: 'Empty!!!');
            }
          },
          child: Text('发送'),
        )
      ],
    );
  }
}