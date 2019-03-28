import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_demo/controller/HttpController.dart';
import 'package:flutter_demo/bean/BannerInfoResponse.dart';
import 'package:flutter_demo/bean/FictionHomeInfoResponse.dart';
import 'package:flutter_demo/FictionManFeatured.dart';
import 'package:flutter_demo/FictionDetailPage.dart';

class mainFiction extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new mainFictionState();
  }
}

class mainFictionState extends State<mainFiction> with AutomaticKeepAliveClientMixin{
  HttpController mHttpController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mHttpController=new HttpController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Theme(
        data: ThemeData(
          primaryColor: Colors.white
        ),
        child: Scaffold(
          appBar: AppBar(
            leading: Container(
                padding: EdgeInsets.only(left: 10.0),
                child: ClipOval(
                  child: Image.asset('images/fiction_header_icon.png'),
                )
            ),
            title: DecoratedBox(
              decoration: BoxDecoration(
                  color: Color.fromARGB(150, 235, 235, 235),
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
                    padding: EdgeInsets.fromLTRB(10.0, 5.0, 100.0, 5.0),
                    child: Text('搜索书名或者作者名',style: TextStyle(fontSize: 14.0,color: Colors.black),),
                  )
                ],
              ),
            ),
          ),

          body: ListView(
            children: <Widget>[
              getHeadView(),
              FutureBuilder<FictionHomeInfoResponse>(
                  future: mHttpController.getFictionHomePageInfo(),
                  builder: (BuildContext context, AsyncSnapshot snapshot){
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      case ConnectionState.done:
                        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                        return getFictionHomeContent(snapshot.data);
                      default:
                        return null;
                    }
                  }
              ),
            ],
          )
        ),
    );
  }

  Widget getHeadView(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 142.0,
          child: FutureBuilder<List<DataBean>>(
              future: mHttpController.getBannerInfo('BookTop'),
              builder: _buildFuture
          ),
        ),
        Padding(
           padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: <Widget>[
               Column(
                 mainAxisSize: MainAxisSize.min,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: <Widget>[
                    Image.asset('images/fiction_1.png',width: 42.0,height: 42.0,),
                    Padding(
                      padding: EdgeInsets.only(top: 3.0),
                      child: Text('书架',style: TextStyle(fontSize: 14.0,color: Color(0xFF333333)),),
                    )
                 ],
               ),
               Column(
                 mainAxisSize: MainAxisSize.min,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: <Widget>[
                   Image.asset('images/fiction_2.png',width: 42.0,height: 42.0,),
                   Padding(
                     padding: EdgeInsets.only(top: 3.0),
                     child: Text('排行',style: TextStyle(fontSize: 14.0,color: Color(0xFF333333)),),
                   )
                 ],
               ),
               Column(
                 mainAxisSize: MainAxisSize.min,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: <Widget>[
                   Image.asset('images/fiction_3.png',width: 42.0,height: 42.0,),
                   Padding(
                     padding: EdgeInsets.only(top: 3.0),
                     child: Text('专题',style: TextStyle(fontSize: 14.0,color: Color(0xFF333333)),),
                   )
                 ],
               ),
               Column(
                 mainAxisSize: MainAxisSize.min,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: <Widget>[
                   Image.asset('images/fiction_4.png',width: 42.0,height: 42.0,),
                   Padding(
                     padding: EdgeInsets.only(top: 3.0),
                     child: Text('书库',style: TextStyle(fontSize: 14.0,color: Color(0xFF333333)),),
                   )
                 ],
               ),
             ],
           ),
        ),
        Container(
          height: 15.0,
          color: Color.fromARGB(150, 235, 235, 235),
        )

      ],
    );
  }

  ///snapshot就是_calculation在时间轴上执行过程的状态快照
  Widget _buildFuture(BuildContext context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        print('还没有开始网络请求');
        return Text('还没有开始网络请求');
      case ConnectionState.active:
        print('active');
        return Text('ConnectionState.active');
      case ConnectionState.waiting:
        print('waiting');
        return Center(
          child: CircularProgressIndicator(),
        );
      case ConnectionState.done:
        print('done');
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        return getBannerView(snapshot.data);
      default:
        return null;
    }
  }

  Widget getBannerView(List<DataBean> banners){
    return Swiper(
      itemCount: banners.length,
      itemBuilder: (context,index){
        return Image.network(banners[index].pictureUrl,fit:BoxFit.fill);
      },
        pagination: new SwiperPagination(
            builder: DotSwiperPaginationBuilder(
              color: Colors.black54,
              activeColor: Colors.white,
            )),
        control: new SwiperControl(),
        scrollDirection: Axis.horizontal,
        autoplay: true,
        onTap: (index) => print('点击了第$index个'),
    );
  }

  Widget getFictionHomeContent(FictionHomeInfoResponse response){
    List<FictionIntroduction> hotPushLists=response.hotPush.data;
    List<FictionIntroduction> editPushLists=response.editerPush.data;
    List<FictionIntroduction> manLists=response.other[0].data;
    List<FictionIntroduction> girlLists=response.other[1].data;
    return Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getHotPushWidgets(hotPushLists),
            getEditPushWidgets(editPushLists),
            FictionManFeatured(manLists:manLists,isMan: true,),
            FictionManFeatured(manLists:girlLists,isMan: false,),
          ],
        ),
    );
  }

  //获取热门推荐
  Widget getHotPushWidgets(List<FictionIntroduction> hotPushLists){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('热门精选',style: TextStyle(fontSize: 16.0,color: Colors.black,fontWeight: FontWeight.bold),),
        getFictionDetailStyle(hotPushLists[0]),
        Container(
          padding: EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: hotPushLists.sublist(1,4).map((FictionIntroduction fictionIntroduction){
              return getFictionNormalStyle(fictionIntroduction);
            }).toList(),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10.0),
          height: 15.0,
          color: Color.fromARGB(150, 235, 235, 235),
        )

      ],
    );
  }

  //获取主编力推
  Widget getEditPushWidgets(List<FictionIntroduction> editPushLists){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 10.0),
          child: Text('主编力推',style: TextStyle(fontSize: 16.0,color: Colors.black,fontWeight: FontWeight.bold),),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: editPushLists.map((FictionIntroduction fictionIntroduction){
            return getFictionDetailStyle(fictionIntroduction);
          }).toList(),
        ),
        Container(
          margin: EdgeInsets.only(top: 10.0),
          height: 15.0,
          color: Color.fromARGB(150, 235, 235, 235),
        )
      ],
    );
  }

  Widget getFictionDetailStyle(FictionIntroduction fictionIntroduction){
    return InkWell(
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context){
              return FictionDetailPage(fictionId : fictionIntroduction.bookId);
//              return ImagePickerPage();
//              return ScannerPage();
            }));
      },
      child: Container(
        padding: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.network(fictionIntroduction.picture,width: 90.0,height: 120.0,),
            Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(fictionIntroduction.name,style: TextStyle(fontSize: 16.0,color: Colors.black,fontWeight: FontWeight.w500),),
                      Container(
                        padding: EdgeInsets.only(top: 15.0,bottom: 15.0),
                        child: Text(fictionIntroduction.description,style: TextStyle(fontSize: 14.0,color: Color(0xFF999999)),maxLines: 2,overflow: TextOverflow.ellipsis,),
                      ),

                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Image.asset('images/fiction_author.png',width: 18.0,height: 18.0,),
                          Container(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(fictionIntroduction.author,style: TextStyle(fontSize: 14.0,color: Color(0xFF999999))),
                          )
                        ],
                      )
                    ],
                  ),
                )
            ),

          ],
        ),
      ),
    );
  }

  Widget getFictionNormalStyle(FictionIntroduction fictionIntroduction){
    return InkWell(
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context){
              return FictionDetailPage(fictionId : fictionIntroduction.bookId);
            }));
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(fictionIntroduction.picture,width: 90.0,height: 120.0,),
          Container(
            width: 90.0,
            margin: EdgeInsets.only(top: 5.0,bottom: 3.0),
            child: Text(fictionIntroduction.name,style: TextStyle(fontSize: 14.0,color: Color(0xFF333333)),softWrap: false,overflow: TextOverflow.ellipsis,),
          ),
          Container(
            width: 90.0,
            child: Text(fictionIntroduction.author,style: TextStyle(fontSize: 14.0,color: Color(0xFF999999)),softWrap: false,overflow: TextOverflow.ellipsis,),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}