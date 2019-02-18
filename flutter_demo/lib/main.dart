import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'homePage.dart';
import 'PersonalPage.dart';
import 'fiction/mainFiction.dart';

void main() => runApp(AppHome());

class AppHome extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: MainPage()
    );
  }
}


class MainPage extends StatefulWidget{
    @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new MainPageState();
  }
}

class MainPageState extends State<MainPage>{
  int _tabIndex = 0;
  var _pageList;
  var tabImages;
  var appBarTitles= ['新闻','小说','中心'];

  var _pageController = new PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
      _initData();
      return Scaffold(
        body: PageView(
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: _pageList,
        ),
        bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: getTabIcon(0),
                title: getTabTitle(0)
              ),
              BottomNavigationBarItem(
                  icon: getTabIcon(1),
                  title: getTabTitle(1)
              ),
              BottomNavigationBarItem(
                  icon: getTabIcon(2),
                  title: getTabTitle(2)
              ),
            ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _tabIndex,
          iconSize: 24.0,
          onTap: (index){
              if(index==_tabIndex)
                return;

              setState(() {
                _tabIndex=index;
              });

              _pageController.jumpToPage(index);
          },
        ),
      );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _initData(){
    _pageList = [
      new HomePage(),
      new mainFiction(),
      new PersonalPage(),
    ];

    tabImages=[
      [getTabImage('images/icon_main_tab_news_normal.png'),getTabImage('images/icon_main_tab_news_selected.png')],
      [getTabImage('images/icon_main_tab_micro_normal.png'),getTabImage('images/icon_main_tab_micro_select.png')],
      [getTabImage('images/icon_main_tab_person_normal.png'),getTabImage('images/icon_main_tab_person_selected.png')],

    ];
  }

  Image getTabImage(path) {
    return new Image.asset(path, width: 24.0, height: 24.0,fit: BoxFit.contain,);
  }

  Image getTabIcon(int index){
    if(index==_tabIndex){
      return tabImages[index][1];
    }else{
      return tabImages[index][0];
    }
  }

  //获取tab的文字
  Text getTabTitle(int index){
    if(index == _tabIndex){
      return Text(
        appBarTitles[index],
        style: TextStyle(fontSize: 14.0,color: Color(0xFFFFCA12)),
      );
    }else{
      return Text(
        appBarTitles[index],
        style: TextStyle(fontSize: 14.0,color: Color(0xFF999999)),
      );
    }
  }

}


