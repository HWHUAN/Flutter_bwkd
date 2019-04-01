import 'package:flutter/material.dart';
import 'package:flutter_demo/SearchPage.dart';
import 'controller/HttpController.dart';
import 'bean/ChannelResponse.dart';
import 'channelView.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{

  HttpController mHttpController;
  bool isLoadChannel=true;//是否在加载channel

  List<Channel> channels=<Channel>[];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return layout(context);
    /* return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => layout(context),
      },
    );*/
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mHttpController=new HttpController();
    getChannel();
  }

  void getChannel() async{
    await mHttpController.getChannelList((data){
      if(data!=null){
        setState(() {
          isLoadChannel=false;
          channels.addAll(data);
          print("channel data="+channels.toString());
        });
      }
    });
  }


  Widget layout(BuildContext context){

    if(isLoadChannel){
      return Theme(
          data: ThemeData(
              primaryColor: Colors.white
          ),
          child: Scaffold(
            appBar: AppBar(
              leading: Container(
                padding: EdgeInsets.only(left: 5.0),
                child: Image.asset('images/icon_logo.png',width: 63.0,height: 15.0,),
              ),
              title:DecoratedBox(
                decoration: BoxDecoration(
                    color: Color.fromARGB(150, 245, 245, 245),
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Color(0xFFC90E),width: 1.0)
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Image.asset('images/icon_function_search.png',width: 14.0,height: 14.0,),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 5.0, 80.0, 5.0),
                      child: Text('搜索你感兴趣的内容',style: TextStyle(fontSize: 14.0,color: Colors.black),),
                    ),
                  ],
                ),
              ),
            ),
            body: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.blue,
                  strokeWidth: 4,
                )
            ),
          )
      );
    }

    return Theme(
        data: ThemeData(
            primaryColor: Colors.white
        ),
        child: DefaultTabController(
          length: channels.length,
          child: Scaffold(
            appBar: AppBar(
              leading: Container(
                padding: EdgeInsets.only(left: 5.0),
                child: Image.asset('images/icon_logo.png',width: 63.0,height: 15.0,),
              ),
              title: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color.fromARGB(150, 245, 245, 245),
                  borderRadius: BorderRadius.circular(20.0),
//                border: Border.all(color: Color(0xFFFFC90E),width: 1.0)
                ),
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context){
                           return SearchPage();
                        })
                    );

                  },

                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Image.asset('images/icon_function_search.png',width: 14.0,height: 14.0,),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 5.0, 80.0, 5.0),
                        child: Text('搜索你感兴趣的内容',style: TextStyle(fontSize: 14.0,color: Colors.black),),
                      ),
                    ],
                  ),
                ),
              ),
              bottom: TabBar(
                isScrollable: true,
                indicatorColor: Color(0xFFFFB40C),
                labelColor: Colors.black,
                labelStyle: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),
                unselectedLabelColor: Color(0xFF666666),
                unselectedLabelStyle: TextStyle(fontSize: 14.0),
                tabs: channels.map((Channel channel){
                  return Tab(
                    text: channel.name,
                  );
                }).toList(),
              ),
            ),
            body: TabBarView(
              children: channels.map((Channel channel){
                return Container(
                  /*child: RefreshIndicator(
                    child: ListView.builder(itemCount:mNewsList.length,itemBuilder: itemView,controller: _scrollController, ),
                    onRefresh: _onRefresh),*/
                  child: _buildChannelTab(context,channel),
                );
              }).toList(),
            ),
          ),
        )
    );
  }

  Widget _buildChannelTab(BuildContext context,Channel channel){
    return NewsListView(mChannelCode: channel.code.toString(),mSearchText: "",);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;


}