import 'dart:convert';
import 'package:demo/common/base.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/cupertino.dart';

class ShopPage extends StatefulWidget {
  ShopPage({Key key}) : super(key: key);

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> with Base, AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
         body: FutureBuilder(
           future: _getData(),
           builder: (ctx, snapshot){
             if (snapshot.hasData) {
               var data = json.decode(snapshot.data.toString());
              //  print(data['data']['ad_list']);
               List<Map> swiper = (data['data']['ad_list'] as List).cast();
               List<Map> topics = (data['data']['topics'] as List).cast();
               List<Map> ads = (data['data']['topic_ad_list'] as List).cast();
               List<Map> articles = (data['data']['article_top'] as List).cast();

               return SingleChildScrollView(
                 child: Column(
                  children: <Widget>[
                    Container(
                      height: Base.h(270),
                      child: Swiper(
                        itemCount: swiper.length,
                        itemBuilder: (ctx, inx) => Image.network(swiper[inx]['image'], fit: BoxFit.fill),
                        containerHeight: 300.0,
                        duration: 1500,
                        pagination: SwiperPagination(),
                        autoplay: true,
                        onTap: (inx) {
                          Navigator.pushNamed(ctx, '/web_view', arguments: {'url': swiper[inx]['ad_link'], 'title': swiper[inx]['ad_name']});
                        },
                      ),
                    ),
                    Ad(ads),
                    Topic(topics:topics,),
                    Article(articles)
                  ],
                ),
               ); 
               
             } else {
               return Container(
                 alignment: Alignment.center,
                 child: CupertinoActivityIndicator(radius: 20.0,),
               );
             }
           },
         ),
       ),
    );
  }

  Future _getData() async {
    Response r;
    r = await Dio().get('https://a.sirme.tv/mobile/v3/index/top');
    return r;
  }

  @override
  bool get wantKeepAlive => true;
}


class Topic extends StatelessWidget {
  final List topics;
  const Topic({Key key, this.topics}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Base.w(315),
      child: GridView.count(
        crossAxisCount: 3,
        padding: EdgeInsets.symmetric(horizontal: Base.w(10)),
        children: _renderItems(),
        mainAxisSpacing: Base.w(1.5),
        crossAxisSpacing: Base.w(1.5),
        childAspectRatio: 0.75,
        physics: NeverScrollableScrollPhysics(),
      )
    );
  }

  List<Widget> _renderItems() {
    return topics.map((i) {
      return Container(
        decoration: BoxDecoration(
          // border: Border.all(
          //   color: Colors.black,
          // ),
          borderRadius: BorderRadius.circular(3.0)
        ),
        // alignment: Alignment.topLeft,
        child: Image.network(
          i['file_url'], 
          fit: BoxFit.fill, 
          // width: ScreenUtil.getInstance().setWidth(115),
          // height: ScreenUtil.getInstance().setHeight(200),
        ),
      );
    }).toList();
  }
}

class Ad extends StatelessWidget {
  final List ads;
  const Ad(this.ads);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: GridView.count(
        crossAxisCount: ads.length,
        children: _renderAds(context),
      ),
    );
  }

  List<Widget> _renderAds(context) {
    return ads.map((i){
      return InkWell(
        onTap: (){
          Navigator.pushNamed(context, '/web_view', arguments: {'url': i['ad_link'], 'title': i['ad_name']});
        },
        child: Column(
          children: [
            Container(
              width: Base.w(45),
              height: Base.w(45),
              child: Image.network(i['image'], fit: BoxFit.fill,),
            ),
            Text(i['ad_name'])
          ],
        ),
      );
    }).toList();
  }
}

class Article extends StatelessWidget {
  final List articles;
  const Article(this.articles);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: articles.map((i){
        return _renderArticle(i);
      }).toList(),
    );
  }

  Widget _renderArticle(i) {

    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: Base.h(160),
            child: Image.network(i['file_url']),
          ),
          Container(
            height: Base.h(200),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: i['goods_list'].length,
              itemBuilder: (ctx, inx){
                return InkWell(
                  onTap: (){
                    Navigator.of(ctx).pushNamed('/goods', arguments: i['goods_list'][inx]);
                  },
                  child: Container(
                    height: Base.h(200),
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                              height: Base.h(100),
                              width: Base.w(100),
                              child: Image.network(i['goods_list'][inx]['goods_img']),
                            ),
                            Positioned(
                              top: Base.h(25),
                              left: Base.w(25),
                              child: Container(
                                width: Base.w(50),
                                height: Base.h(50),
                                child: Image.asset('img/sell_out.png', fit: BoxFit.fill,),
                              ),
                            )
                          ],
                        ),
                        Container(
                          width: Base.w(100),
                          height: Base.h(50),
                          child: Text(
                            i['goods_list'][inx]['goods_name'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          
        ],
      ),
    );
  }
}