// import 'dart:html';
import 'dart:io';

import 'package:demo/common/base.dart';
import 'package:demo/provide/tim.dart';
import 'package:dim/dim.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provide/provide.dart';
import 'package:image_picker/image_picker.dart';

enum KeyboardType {
  SOUND,
  TEXT,
  FILE,
}

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
  KeyboardType type = KeyboardType.TEXT;

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
            onTap: () {
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
        bottomNavigationBar: renderBottomInput(),
      ),
    );
  }

  Widget renderChatRow(dynamic bean) {
    return Row(
      mainAxisAlignment: tim.currentPeer == bean['sender']
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: tim.currentPeer != bean['sender']
          ? [Text(bean['sender']), getRowContent(bean)]
          : [getRowContent(bean), Text(bean['sender'])],
    );
  }

  Widget getRowContent(dynamic bean) {
    switch (bean['message']['type']) {
      case 'Text':
        return Text(bean['message']['text']);
      case 'Image':
        return InkWell(
          onTap: (){
            Navigator.pushNamed(context, '/photo', arguments: {
              "photos": [
                {"image": bean['message']['imageList'][0]['url']},
              ]
            });
          },
          child: Container(
            child: Image.network(bean['message']['imageList'][1]['url']),
          ),
        );
      case 'Sound':
        return Container(
          height: Base.w(30),
          color: Colors.cyan,
          child: Text('Sound: ${bean["message"]["duration"]}s'),
        );
        case "File":
          return Container(
            child: Text(bean['message']['fileName']),
          );
      default:
        return Text('unsupport-type');
    }
  }

  Widget renderBottomInput() {
    switch (type) {
      case KeyboardType.TEXT:
        return Container(
          height: Base.w(50),
          child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                onChanged: (val) {
                  _inputVal = val;
                },
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  type = KeyboardType.FILE;
                });
              },
              child: Icon(
                Icons.email,
                size: 30,
              ),
            ),
            FlatButton(
              onPressed: () {
                if (_inputVal.trim() != '') {
                  _dim.sendTextMessages(_peer, _inputVal).then((r) {
                    _controller.clear();
                  }).catchError((e) {
                    print('--->err');
                  });
                } else {
                  Fluttertoast.showToast(msg: 'Empty!!!');
                }
              },
              child: Text('发送'),
            ),
          ],
        ),
        );
      case KeyboardType.FILE:
      return Container(
        height: Base.w(100),
        child: Column(
          children: <Widget>[
            Container(
              height: Base.w(50),
              color: Colors.yellowAccent,
            ),
            Container(
              height: Base.w(50),
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    onTap: () async {
                      print('todo-photo');
                      File f = await getImage(ImageSource.gallery);
                      _dim.sendImageMessages(_peer, f.path);
                      setState(() {
                        type = KeyboardType.TEXT;
                      });
                    },
                    child: Container(
                      child: Text('图片'),
                    ),
                  ),
                  InkWell(
                    onTap: ()async{
                      File f = await getImage(ImageSource.camera);
                      _dim.sendImageMessages(_peer, f.path);
                    },
                    child: Container(
                      child: Text('拍照'),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
      default:
        return null;
    }
  }

  Future getImage(ImageSource source) async {
    File file = await ImagePicker.pickImage(source: source);
    return file;
  }
}
