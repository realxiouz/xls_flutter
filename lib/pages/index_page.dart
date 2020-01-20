import 'package:flutter/material.dart';
import './community_page.dart';
import './shop/index.dart';
import './around/index.dart';
import './auth/me.dart';
import './test_page.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return IndexState();
  }
}

class IndexState extends State<IndexPage> {
  final List<BottomNavigationBarItem>  tabs = [
    BottomNavigationBarItem(title: Text('社区'), icon: Icon(Icons.music_video)),
    BottomNavigationBarItem(title: Text('商城'), icon: Icon(Icons.shop)),
    BottomNavigationBarItem(title: Text('周边'), icon: Icon(Icons.android)),
    BottomNavigationBarItem(title: Text('我的'), icon: Icon(Icons.my_location)),
    BottomNavigationBarItem(title: Text('test'), icon: Icon(Icons.event_busy))
  ];

  final List tabPages = [
    CommunityPage(),
    ShopPage(),
    CommendPage(ScrollController()),
    MePage(),
    TestPage()
  ];

  var _index = 0;
  var _currentPage;
  PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
    _currentPage = tabPages[_index];
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        items: tabs,
        onTap: (inx) {
          setState(() {
            _index = inx;
            // _currentPage = tabPages[_index];
            _controller.jumpToPage(inx);
          });
        },
      ),
      body: _getCurrentPage(),
    );
  }

  Widget _getCurrentPage() {
    return PageView.builder(
      itemBuilder: (context, index) {
        return tabPages[index];
      },
      itemCount: tabPages.length,
      physics: NeverScrollableScrollPhysics(),
      controller: _controller,
      
    );
  }
}
