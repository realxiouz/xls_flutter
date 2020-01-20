import 'dart:convert';

import 'package:demo/common/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_html/flutter_html.dart';

class GoodsPage extends StatefulWidget {
  GoodsPage({Key key}) : super(key: key);

  @override
  _GoodsPageState createState() => _GoodsPageState();
}

class _GoodsPageState extends State<GoodsPage> {
  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context).settings.arguments;
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {
          var data = json.decode(snapshot.data.toString());
          List<Map> pics = (data['data']['pictures'] as List).cast();
          Map info = (data['data']['goods'] as Map).cast();
          List<Map> address = (data['data']['office_list'] as List).cast();
          Widget htmlView = CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  children: <Widget>[
                    Container(height: Base.w(110),),
                    Html(data: info['goods_desc'],)
                  ],
                ),
              )
            ],
          ) ;
          return Scaffold(
            body: DefaultTabController(
              length: 2,
              child: NestedScrollView(
                headerSliverBuilder: (context, can){
                  return [
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                      child: SliverAppBar(
                        pinned: true,
                        bottom: TabBar(tabs: ['商品详情', '购买须知'].map((i) => Text(i)).toList()),
                        expandedHeight: Base.w(700),
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.pin,
                          background: Container(
                            height: Base.w(700),
                            child: Column(
                              children: <Widget>[
                                PhotoSwiper(pics),
                                GoodsInfor(info)
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ];
                },
                body: TabBarView(
                  children: <Widget>[
                    htmlView,
                    SingleChildScrollView(
                      child: Image.network('http://v4oss.sirme.tv//images/upload/20190806/15650607819114.png', width: Base.w(375),),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
              height: Base.h(60),
              color: Colors.yellow,
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return CupertinoActivityIndicator();
        } else if (snapshot.connectionState == ConnectionState.none) {
          return Text('err', style: TextStyle(color: Colors.white),);
        }
        return null;
      },
      future: _getData(args['goods_id']),
    );

  }

  Future _getData(id) async {
    Response r = await Dio().post('https://m.sirme.tv/mobile/v3/goods/index', data: {
      'id': id
    });
    return r;
  }
}

class PhotoSwiper extends StatelessWidget {
  final List<Map> pics;
  const PhotoSwiper(this.pics);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Base.w(375),
      height: Base.w(375),
      child: Swiper(
        itemCount: pics.length,
        pagination: SwiperPagination(),
        itemBuilder: (context, inx){
          return GestureDetector(
            child: Image.network(pics[inx]['img_url']),
            onTap: (){
              print('pic click at $inx');
            },
          );
        },
        autoplay: true,
      ),
    );
  }
}

class GoodsInfor extends StatelessWidget {
  final Map info;
  const GoodsInfor(this.info);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white
      ),
      padding: EdgeInsets.fromLTRB(Base.w(15), Base.w(10.5), Base.w(15), Base.w(22)),
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(info['goods_price']),
                ),
                Text('库存 ${info["goods_number"]}')
              ],
            ),
          ),
          Container(
            height: Base.w(40),
            margin: EdgeInsets.only(bottom: Base.w(12.5), top: Base.w(10)),
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.all(Radius.circular(Base.w(5)))
            ),
            child: Row(
              children: <Widget>[

              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            margin: EdgeInsets.only(bottom: Base.w(3)),
            child: Text(info['goods_name'], style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 16.0
            ),),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            child: Text(info['goods_brief'], style: TextStyle(),),
          )
        ],
      ),
    );
  }
}
