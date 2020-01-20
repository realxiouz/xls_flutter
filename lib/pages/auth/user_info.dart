import 'package:demo/common/base.dart';
import 'package:demo/provide/me.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provide/provide.dart';

class UserInfo extends StatefulWidget {
  UserInfo({Key key}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    MeProvide meProvide = Provide.value<MeProvide>(context);
    return Container(
      color: Color.fromRGBO(247, 247, 247, 1),
      child: Column(
        children: <Widget>[
          UserHeader(meProvide.userInfo),
          getMemberRow(),
          getIconsRow(),
        ],
      ),
    );
  }
}

class UserHeader extends StatelessWidget {
  final Map info;
  const UserHeader(this.info);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(Base.w(10), Base.w(35), 0, 0),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: ExactAssetImage('img/user_bg.jpg'), fit: BoxFit.fill),
      ),
      height: Base.w(210),
      width: Base.w(375),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  CircleAvatar(
                    radius: Base.w(45),
                    backgroundImage: NetworkImage(info['avatar']),
                  ),
                  info['level'] > 0
                      ? Positioned(
                          bottom: Base.w(-1),
                          left: Base.w(22.5),
                          child: Container(
                            width: Base.w(45),
                            height: Base.w(16),
                            child: Image.asset('img/vip-${info['level']}.png'),
                          ),
                        )
                      : Container()
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: Base.w(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: Base.w(3.5)),
                      child: Text(
                        info['nickname'],
                        style: TextStyle(
                            color: Colors.white, fontSize: Base.f(18)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: Base.w(8)),
                      child: Text(
                        '心灵兽ID:${info["id"]}',
                        style: TextStyle(
                            color: Colors.white, fontSize: Base.f(12)),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          height: Base.w(23),
                          padding: EdgeInsets.symmetric(horizontal: Base.w(4)),
                          margin: EdgeInsets.only(right: Base.w(6)),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 0.4),
                            borderRadius: BorderRadius.circular(Base.w(3)),
                          ),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.menu,
                                size: Base.w(10),
                                color: Colors.pink,
                              ),
                              SizedBox(
                                width: Base.w(4),
                              ),
                              Text('20',
                                  style: TextStyle(
                                      fontSize: Base.f(14),
                                      color: Colors.white)),
                            ],
                          ),
                        ),
                        Container(
                          height: Base.w(23),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: Base.w(14)),
                          margin: EdgeInsets.only(right: Base.w(6)),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 0.4),
                            borderRadius: BorderRadius.circular(Base.w(3)),
                          ),
                          child: Text('昆明',
                              style: TextStyle(
                                  fontSize: Base.f(14), color: Colors.white)),
                        ),
                        Container(
                          height: Base.w(23),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: Base.w(14)),
                          margin: EdgeInsets.only(right: Base.w(6)),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 0.4),
                            borderRadius: BorderRadius.circular(Base.w(3)),
                          ),
                          child: Text('修改资料',
                              style: TextStyle(
                                  fontSize: Base.f(14), color: Colors.white)),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: Base.w(15)),
            child: Container(
              child: Row(
                children: <Widget>[
                  // Container(),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: Base.w(48),
                      width: Base.w(200),
                      margin: EdgeInsets.only(bottom: Base.w(5)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Text(
                              '你还没有添加个性签名，点击添加...',
                              style: TextStyle(
                                  color: Colors.white, fontSize: Base.w(13)),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: Base.w(16)),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      '123',
                                      style: TextStyle(
                                          fontSize: Base.f(17),
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '关注',
                                      style: TextStyle(
                                          fontSize: Base.f(13),
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: Base.w(16)),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      '123',
                                      style: TextStyle(
                                          fontSize: Base.f(17),
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '粉丝',
                                      style: TextStyle(
                                          fontSize: Base.f(13),
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: Base.w(16)),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      '123',
                                      style: TextStyle(
                                          fontSize: Base.f(17),
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '获赞',
                                      style: TextStyle(
                                          fontSize: Base.f(13),
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: Base.w(90),
                    height: Base.w(33),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(45),
                            bottomLeft: Radius.circular(45)),
                        color: Colors.pink),
                    child: Text(
                      '商家后台',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Base.f(14),
                      ),
                      // textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget getIcon(String iconPath, String title, num width, Function f) {
  return InkWell(
    onTap: f,
    child: Column(
      children: <Widget>[
        Container(
          width: Base.w(width),
          height: Base.h(width),
          margin: EdgeInsets.only(bottom: Base.w(5)),
          child: Image.asset(
            iconPath,
            fit: BoxFit.fill,
          ),
        ),
        Container(
          child: Text(title),
        )
      ],
    ),
  );
}

Widget getMemberRow() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: Base.w(12)),
    margin: EdgeInsets.symmetric(horizontal: Base.w(10), vertical: Base.w(10)),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(Base.w(10)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        getIcon('img/mp.png', '名片', 35, (){
          Fluttertoast.showToast(msg: '点击了mp');
        }),
        getIcon('img/sy.png', '收益', 35, (){
          Fluttertoast.showToast(msg: '点击了sy');
        }),
        getIcon('img/td.png', '团队', 35, (){
          Fluttertoast.showToast(msg: '点击了td');
        }),
        getIcon('img/fq.png', '发圈', 35, (){
          Fluttertoast.showToast(msg: '点击了fq');
        }),
      ],
    ),
  );
}

Widget getIconsRow() {
  List<Map<String, dynamic>> data = [
    {"icon": "img/kb.png", "title": "卡包", "path": "", "f": (){print(1);}},
    {"icon": "img/dd.png", "title": "订单", "path": "", "f": (){}},
    {"icon": "img/zs.png", "title": "钻石", "path": "", "f": (){}},
    {"icon": "img/sc.png", "title": "收藏", "path": "", "f": (){}},
    {"icon": "img/dz.png", "title": "地址管理", "path": "", "f": (){}},
    {"icon": "img/sj.png", "title": "商家入驻", "path": "", "f": (){}},
    {"icon": "img/kf.png", "title": "客服", "path": "", "f": (){}},
    {"icon": "img/sz.png", "title": "设置", "path": "", "f": (){}}
  ];

  return Container(
    padding: EdgeInsets.symmetric(vertical: Base.w(12)),
    margin: EdgeInsets.symmetric(horizontal: Base.w(10), vertical: Base.w(10)),
    height: Base.w(130),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(Base.w(10)),
    ),
    // alignment: Alignment.center,
    child: GridView.count(
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      childAspectRatio: 1.98,
      padding: EdgeInsets.all(0),
      mainAxisSpacing: Base.w(20),
      children: data.map((i) {
        return getIcon(i['icon'], i['title'], 22, i['f']);
      }).toList(),
    ),
  );
}
