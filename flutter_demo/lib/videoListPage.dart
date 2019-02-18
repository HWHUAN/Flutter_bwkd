import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'controller/HttpController.dart';
import 'bean/RelativeInfoResponse.dart';
import 'bean/NewsResData.dart';
import 'bean/NewsDetailResponse.dart';

class VideoListPage extends StatefulWidget {
  final News mNews;

  VideoListPage({this.mNews});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return new VideoListPageState();
  }
}

class VideoListPageState extends State<VideoListPage> with AutomaticKeepAliveClientMixin{
  TargetPlatform _platform;
  VideoPlayerController _controller;

  HttpController _httpController;

  bool _isLoading=true;
  RelativeInfoResponse mRelativeInfoResponse;
  NewsDetail mNewsDetail;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    assert(widget.mNews!=null);
    _httpController=new HttpController();
    _platform=TargetPlatform.iOS;

    getNewsDetail();
  }

  void getRelativeInfo() async{
    await _httpController.getRelativeInfo(widget.mNews.id,(data){
      if(data!=null){
        setState(() {
          _isLoading=false;
          mRelativeInfoResponse=data;
        });
      }
    });
  }

  void getNewsDetail() async{
    await _httpController.getNewsDetail(widget.mNews.id,(data){
      if(data!=null){
        setState(() {
          mNewsDetail=data;
          _controller = new VideoPlayerController.network(mNewsDetail.videoSrc);
          getRelativeInfo();
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        /*appBar: new AppBar(
          title: new Text(widget.mNews.title),
        ),*/
        body: Theme(
          data: new ThemeData.light().copyWith(
//            platform: _platform ?? Theme.of(context).platform,
            platform: TargetPlatform.android,
            //视频播放器的底部的控制布局的背景色获取的是dialogBackgroundColor的颜色，所以
            //要想改变视频控制栏的背景颜色的话只能通过修改dialogBackgroundColor 的值来修改
            dialogBackgroundColor: Color.fromRGBO(41, 41, 41, 0.7),
          ),
          child: getView(),
        )
    );
  }

  Widget getView(){
    if(_isLoading){
      return Center(
        child: CircularProgressIndicator(),
      );
    }else{
//      return _getRelativeWidgets(mRelativeInfoResponse);
        return Stack(
          children: <Widget>[
            Positioned(
                top: 0.0,
                left: 0.0,
                child: Container(
                  color: Colors.black,
                  height: MediaQuery.of(context).padding.top,
                  width: MediaQuery.of(context).size.width,
                )
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top,
              left: 0.0,
              child: new Container(
                child: new Chewie(
                  _controller,
                  aspectRatio: 1.6,
                  autoPlay: true,
                  looping: true,

                  // Try playing around with some of these other options:

//                   showControls: false,
                   materialProgressColors: new ChewieProgressColors(
                     playedColor: Colors.red,
                     handleColor: Colors.blue,
                     backgroundColor: Colors.grey,
                     bufferedColor: Colors.lightGreen,
                   ),
                   placeholder: new Container(
//                     color: Colors.grey,
                     child: Image.network(widget.mNews.pictureList[0]),
                   ),
                   autoInitialize: true,
                ),
              ),
            ),
            Positioned(
                top: MediaQuery.of(context).padding.top,
                left: 0.0,
                child: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10.0,top: 10.0),
                    child: Image.asset('images/icon_back_pressed.png',width: 20.0,height: 20.0,),
                  )
                )
            ),
            Positioned(
                left: 0.0,
                top: 230.0+MediaQuery.of(context).padding.top,
                height: MediaQuery.of(context).size.height-230-MediaQuery.of(context).padding.top,
                width: MediaQuery.of(context).size.width,
                child: _getRelativeWidgets(mRelativeInfoResponse)
            )
          ],
        );
    }
  }

  ListView _getRelativeWidgets(RelativeInfoResponse relativeInfoResponse){
    List<RelativeNews> resources=relativeInfoResponse.data;

    return ListView.builder(
      itemCount: resources.length,
      padding: EdgeInsets.only(top: 0.0),  //ListView 的paddingTop 默认是有会有30左右的高度，所以这里一定要记得设置为0，一开始不知道的时候搞了好久都没明白
      itemBuilder: (context,index){
        String type=resources[index].infoType;
        if(type=="videoTitle"){
            return _getTitleWidget();
        }else{
          return _getRelativeWidget(resources[index]);
        }
      }
    );

  }

  Widget _getTitleWidget(){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: <Widget>[
          /*new Container(
            child: new Chewie(
              _controller,
              aspectRatio: 1.6,
              autoPlay: true,
              looping: true,

              // Try playing around with some of these other options:

              // showControls: false,
              // materialProgressColors: new ChewieProgressColors(
              //   playedColor: Colors.red,
              //   handleColor: Colors.blue,
              //   backgroundColor: Colors.grey,
              //   bufferedColor: Colors.lightGreen,
              // ),
              // placeholder: new Container(
              //   color: Colors.grey,
              // ),
              // autoInitialize: true,
            ),
          ),*/

          Container(
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
            child: Text(mNewsDetail.title,style: TextStyle(color: Colors.black,fontSize: 15.0),),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                  Text(mNewsDetail.author,style: TextStyle(fontSize: 13.0,color: Color(0xFF999999)),),
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(mNewsDetail.addTimeStr,style: TextStyle(fontSize: 13.0,color: Color(0xFF999999)),),
                  ),
                  Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 70.0),
                        child: Text(mNewsDetail.readcount.toString() +"次阅读",style: TextStyle(fontSize: 13.0,color: Color(0xFF999999)),),
                      ),
                    ],
                  )
              ],
            ),
          ),

        ],
      );
  }

  Widget _getRelativeWidget(RelativeNews relativeNews){
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 3.0, 10.0, 3.0),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: Image.network(relativeNews.pictureList[0],height: 78.0,width: 113,fit: BoxFit.cover,) ,
          ),

          Expanded(
              child: Container(
                child: Text(relativeNews.title,style: TextStyle(color: Color(0xFF032F62),fontSize: 16.0),),
              )
          )

        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  
}