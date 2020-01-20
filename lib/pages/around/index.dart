/**
 * @discripe: 推荐
 */
import 'package:flutter/material.dart';

class CommendPage extends StatefulWidget {
  final _scrollController;
  CommendPage(this._scrollController);

  @override
  _CommendPage createState() => _CommendPage(this._scrollController);
}

class _CommendPage extends State<CommendPage> with AutomaticKeepAliveClientMixin  {
  final _scrollController;
  final navList ='123456789abcdefghijklmnopqrstuvwxyz'.split('').toList();
  _CommendPage(this._scrollController);

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // ScreenUtil.instance = ScreenUtil(width: DYBase.dessignWidth)..init(context);
    return Scaffold(
      body: navList.length == 0 ? null : DefaultTabController(
        length: navList.length,
        child: NestedScrollView(  // 嵌套式滚动视图
          controller: _scrollController,
          headerSliverBuilder: (context, innerScrolled) => <Widget>[
            /// 使用[SliverAppBar]组件实现下拉收起头部的效果
            SliverAppBar(
              backgroundColor: Colors.white,
              brightness: Brightness.light,
              pinned: true,
              floating: true,
              snap: true,
              expandedHeight: 55.0 + 49,
              actions: <Widget>[
                // DyHeader(
                //   decoration: BoxDecoration(
                //     color: Colors.transparent,
                //   ),
                //   gray: true,
                // ),
              ],
              flexibleSpace: FlexibleSpaceBar(  // 下拉渐入背景
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.0, 1),
                      end: Alignment(0.0, -0.7),
                      colors: <Color>[
                        Color(0xffffffff),
                        Color(0xffff9b7a)
                      ],
                    ),
                  ),
                ),
              ),
              bottom: TabBar(
                isScrollable: true,
                labelStyle: TextStyle(
                  fontSize: 15,
                ),
                labelColor: Colors.yellow,
                indicatorColor: Colors.yellow,
                indicatorPadding: EdgeInsets.only(bottom: 7.0),
                unselectedLabelColor: Color(0xff333333),
                indicatorSize: TabBarIndicatorSize.label,
                tabs: navList.map((e) => Tab(text: e)).toList(),
              ),
              forceElevated: innerScrolled,
            ),
          ],
          body: TabBarView(
            children: navList.asMap().map((i, tab) => MapEntry(i, Builder(
                builder: (context) => CustomScrollView(
                    // physics: BouncingScrollPhysics(),
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: Container(
                          child: i == 0 ? Column(
                            children: [
                              // SWwiperWidgets(),
                              // LiveListWidgets(indexState),
                            ],
                          ) : null,
                        ),
                      )
                    ],
                  ),
              ),),
            ).values.toList(),
          ),
        ),
      ),
    );
      
  }

}