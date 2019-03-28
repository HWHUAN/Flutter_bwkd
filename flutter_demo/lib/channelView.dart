import 'package:flutter/material.dart';
import 'bean/ChannelResponse.dart';
import 'bean/NewsResData.dart';
import 'controller/HttpController.dart';
import 'news_detail_page.dart';
import 'videoListPage.dart';

class NewsListView extends StatefulWidget{
  final String mChannelCode;
  final String mSearchText;
  NewsListView({this.mChannelCode,this.mSearchText});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new NewsListViewState();
  }

}

class NewsListViewState extends State<NewsListView> with AutomaticKeepAliveClientMixin{

  HttpController mHttpController;
  NewsResData mNewsResData;
  List<News> mNewsList = <News>[];
  Map<int,News> newsDataMap=new Map();
  ScrollController _scrollController=new ScrollController();
  bool isLoadMore=false;//是否正在加载更多数据
  bool isFirstLoadData=true; //是否是第一次加载数据

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    assert(widget.mChannelCode!=null);
    mHttpController=new HttpController();
    getData(widget.mChannelCode,widget.mSearchText,2,0);
    _scrollController.addListener((){
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        if(!isLoadMore && mNewsList.length>1){
          setState(() {
            isLoadMore=true;
          });
          getData(widget.mChannelCode,widget.mSearchText,mNewsResData.data.currentpage,mNewsResData.data.currentindex);
        }

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return layout(context);
  }

  Widget layout(BuildContext context){
      if(isFirstLoadData){
        return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
              strokeWidth: 4,
            )
        );
      }else{
        return Container(
          child: RefreshIndicator(
                    child: ListView.builder(itemCount:mNewsList.length,itemBuilder: itemView,controller: _scrollController,padding: EdgeInsets.only(top: 0.0), ),
                    onRefresh: _onRefresh),
        );
      }
  }


  Future<Null> _onRefresh() async{
    if(mNewsResData!=null){
      await getData(widget.mChannelCode,widget.mSearchText,mNewsResData.data.currentpage,mNewsResData.data.currentindex);
    }
  }

  void getData(String tag,String searchText,int page,int currentIndex) async{
    Map<String,String> dataMap = new Map();
    dataMap["tag"]=tag;
    dataMap["search"]=searchText;
    dataMap["page"]=page.toString();
    dataMap["currentindex"]=currentIndex.toString();
    await mHttpController.getNewsList("https://app.tenyou0574.com/App/Info/InfoList",(data){
      if(data!=null){
        setState(() {
          isLoadMore=false;
          isFirstLoadData=false;
          mNewsResData=data;
          mNewsList.addAll(mNewsResData.data.list);
          for(News news in mNewsResData.data.list){
            newsDataMap[news.id]=news;
          }
        });
      }
    },params: dataMap);
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
    // Routes, by convention, are split on slashes, like filesystem paths.
    final List<String> path = settings.name.split('/');
    if (path[0] != '')
      return null;
    if (path[1].startsWith('newsDetail:')) {
      if (path.length != 3)
        return null;
      final String infoId = path[1].substring(11);
      final String index = path[2];
      return MaterialPageRoute<void>(
    settings: settings,
    builder: (BuildContext context) => NewsDetailPage(mNews:mNewsList[int.parse(index)]),
    );
  }
    // The other paths we support are in the routes table.
    return null;
  }


  Widget itemView(BuildContext context,int index){
    News news=this.mNewsList[index];

    if(news.pictureList==null){
      return Expanded(child: Text(news.title));
    }

    if(news.pictureList.length>=1 && news.pictureList.length<3){
      return InkWell(
        onTap: (){
//          Navigator.pushNamed(context, '/newsDetail:${news.id}/${index}');
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context){
                if(news.infoType=="Article"){
                  return NewsDetailPage(mNews:mNewsList[index]);
                }else{
                  return VideoListPage(mNews:mNewsList[index]);
                }
              })
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(news.title,style: TextStyle(
                  fontSize: 16.0
              ),),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                    child: Image.network(news.pictureList[0],height: 199.0,fit: BoxFit.cover,) ,
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 8.0),
              child: Divider(height: 2.0,),
            ),

          ],
        ),
      );
    }

    if(news.pictureList.length>=3){
      return InkWell(
        onTap: (){
//          Navigator.pushNamed(context, '/newsDetail:${news.id}/${index}');
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context){
                if(news.infoType=="Article"){
                  return NewsDetailPage(mNews:mNewsList[index]);
                }else{
                  return VideoListPage(mNews:mNewsList[index]);
                }
              })
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(news.title,style: TextStyle(
                fontSize: 16.0,
              ),),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(right: 5.0),
                          child: Image.network(news.pictureList[0],height: 78.0,fit: BoxFit.cover,) ,
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(right: 5.0),
                          child: Image.network(news.pictureList[1],height: 78.0,fit: BoxFit.cover,) ,
                        )
                    ),
                    Expanded(
                      flex: 1,
                      child: Image.network(news.pictureList[2],height: 78.0,fit: BoxFit.cover,) ,
                    ),
                  ],
                )
            ),
            Container(
              margin: EdgeInsets.only(top: 8.0),
              child: Divider(height: 2.0,),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}