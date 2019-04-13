import 'package:flutter/material.dart';
import 'controller/HttpController.dart';
import 'bean/FictionDetailResponse.dart';
import 'view/StaticRatingBar.dart';

class FictionDetailPage extends StatefulWidget{
  final int fictionId;

  FictionDetailPage({this.fictionId});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new FictionDetailPageState();
  }

}

class FictionDetailPageState extends State<FictionDetailPage>{
  HttpController mHttpController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    assert(widget.fictionId!=null);
    mHttpController=new HttpController();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Theme(
        data: ThemeData(
            primaryColor: Color(0xFFF5F5F5)
        ),
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              Positioned(
                  top: 0.0,
                  left: 0.0,
                  child: Container(
                    height: MediaQuery.of(context).padding.top,
                    width: MediaQuery.of(context).size.width,
                  )
              ),
              Positioned(
                  left: 0.0,
                  top: MediaQuery.of(context).padding.top,
                  width: MediaQuery.of(context).size.width,
                  height: 45.0,
                  child: Container(
                    color: Color(0xFFF5F5F5),
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Image.asset('images/icon_back.png',width: 24.0,height: 24.0,),
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Image.asset('images/icon_share.png',width: 20.0,height: 20.0,)
                        ),
                      ],
                    ),
                  )
              ),
              Positioned(
                  left: 0.0,
                  top: MediaQuery.of(context).padding.top+45.0,
                  width: MediaQuery.of(context).size.width,
                  height:MediaQuery.of(context).size.height- MediaQuery.of(context).padding.top-45.0-48.0,
                  child: ListView(
                    padding: EdgeInsets.only(top: 0.0),    //ListView 的paddingTop 默认是有会有30左右的高度，所以这里一定要记得设置为0，一开始不知道的时候搞了好久都没明白
                    children: <Widget>[
                      FutureBuilder<FictionDetailResponse>(
                          future: mHttpController.getFictionDetail(widget.fictionId),
//                          future: mHttpController.getFictionDetail(434),
                          builder: (BuildContext context, AsyncSnapshot snapshot){
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              case ConnectionState.done:
                                if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                                return getFictionHomeContent(snapshot.data,context);
                              default:
                                return null;
                            }
                          }
                      ),
                    ],
                  ),
              ),
              Positioned(
                  left: 0.0,
                  top: MediaQuery.of(context).size.height-48.0,
                  width: MediaQuery.of(context).size.width,
                  height: 48.0,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Container(
                            color: Color(0xFFF5F5F5),
                            child: Center(
                              child: Text('加入书架',style: TextStyle(fontSize: 18.0,color: Color(0xFFFFB30A)),),
                            ),
                          )
                      ),
                      Expanded(
                          flex: 1,
                          child: Container(
                            color: Color(0xFFFFB30A),
                            /*child: Center(
                              child: Text('开始阅读',style: TextStyle(fontSize: 18.0,color: Colors.white),),
                            ),*/
                            child: InkWell(
                              onTap: (){

                              },
                              child: Center(
                                child: Text('开始阅读',style: TextStyle(fontSize: 18.0,color: Colors.white),),
                              ),
                            ),
                          )
                      ),
                    ],
                  )
              )
            ],
          ),
        )
    );
  }

  void editComment(BuildContext context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
          return Container(
            color: Color(0xFFF5F5F5),
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 18.0,top: 18.0,right: 18.0,bottom: 12.0),
                  child: TextField(
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    decoration: InputDecoration(
                        hintText: "请文明发言，遵守评论规则",
                        hintStyle: TextStyle(
                          color: Color(0xFF999999),
                          fontSize: 16.0,
                        ),
                        contentPadding: EdgeInsets.all(10.0),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                                width: 0.0,
                                color: Colors.white
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                                width: 0.0,
                                color: Colors.white
                            )
                        )
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 18.0,right: 18.0,bottom: 18.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                          child: Icon(
                            Icons.sentiment_satisfied,
                          )
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 20.0),
                          child: Icon(
                            Icons.copyright,
                          )
                      ),

                      Expanded(
                        flex: 1,
                        child:Container() ,
                      ),

                      Container(
                        width: 65.0,
                        height: 30.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Color(0xFFFFB30A)
                        ),
                        child: Center(
                          child: Text("发送",style: TextStyle(
                              fontSize: 14.0,color: Colors.white
                          ),),
                        ),
                      )

                    ],
                  ),
                )

              ],
            ),
          );
        }
    );
  }

  Widget getFictionHomeContent(FictionDetailResponse fictionDetailResponse,BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        getCoverWidget(fictionDetailResponse.data),
        getDescView(fictionDetailResponse.data),
        getCommentView(fictionDetailResponse.data,context),
        getHotPushWidgets(fictionDetailResponse.data.pushBookList),
      ],
    );
  }

  Widget getCoverWidget(FictionDetailBean fictionDetailBean) {
    return Container(
        padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
              fictionDetailBean.picture, width: 90.0, height: 120.0,),
            Container(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(fictionDetailBean.name, style: TextStyle(fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333)),),
                  Container(
                    margin: EdgeInsets.only(top: 7.0),
                    child: StaticRatingBar(
                      size: 12.0,
                      rate: fictionDetailBean.score.toDouble(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 7.0),
                    child: Text(fictionDetailBean.author,style: TextStyle(fontSize: 12.0,color: Color(0xFF999999)),),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 7.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(fictionDetailBean.state,style: TextStyle(fontSize: 12.0,color: Color(0xFF999999)),),
                        Container(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(fictionDetailBean.wordCount.toString()+'万字',style: TextStyle(fontSize: 12.0,color: Color(0xFF999999)),),
                        )
                      ],
                    )
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 7.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: fictionDetailBean.tags.map((String table){
                        return getTableView(table);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }

  Widget getCommentView(FictionDetailBean fictionDetailBean,BuildContext context){
    if(fictionDetailBean.lastComment!=null){
      return Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(12.0),
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Text('书友互动',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Color(0xFF333333)),),
                Container(
                  margin: EdgeInsets.only(left: 5.0),
                  child: Text(fictionDetailBean.commentCount.toString()+'评',style: TextStyle(fontSize: 12.0,color: Color(0xFF999999)),),
                ),
                Container(
                  margin: EdgeInsets.only(left: 153.0),
                  child: InkWell(
                    onTap: (){
                      editComment(context);
                    },
                    child: Image.asset('images/icon_add_comment.png',width: 87.0,height: 32.0,),
                  )
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 12.0,right: 12.0,bottom: 12.0),
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipOval(
                  child: Image.network(fictionDetailBean.lastComment.userAvatar,width: 36.0,height: 36.0,),
                ),
                Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(fictionDetailBean.lastComment.userName,style: TextStyle(fontSize: 14.0,color: Color(0xFF333333)),),
                          Container(
                            margin: EdgeInsets.only(top: 3.0),
                            child: StaticRatingBar(
                              size: 12.0,
                              rate: fictionDetailBean.lastComment.level.toDouble(),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10.0),
                            child: Text(fictionDetailBean.lastComment.comment,style: TextStyle(fontSize: 14.0,color: Color(0xFF333333)),maxLines: 2,overflow: TextOverflow.ellipsis,),
                          )
                        ],
                      ),
                    )
                )

              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 1.0),
            color: Colors.white,
            padding: EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('查看更多',style: TextStyle(fontSize: 14.0,color: Color(0xFFFFB30A)),),
                Container(
                  margin: EdgeInsets.only(left: 5.0),
                  child: Image.asset('images/icon_right.png',width: 6.0,height: 12.0,),
                )
              ],
            ),
          )
        ],
      );
    }else{
      return Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(12.0),
              child: Row(
                children: <Widget>[
                  Text('书友互动',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Color(0xFF333333)),),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40.0,bottom: 10.0),
              child: Text('暂时还没有评论',style: TextStyle(fontSize: 12.0,color: Color(0xFF999999)),),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 40.0),
                child: InkWell(
                  onTap: (){
                    editComment(context);
                  },
                  child: Image.asset('images/icon_add_comment.png',width: 87.0,height: 32.0,),
                )
            ),
          ],
        ),
      );
    }
  }

  Widget getDescView(FictionDetailBean fictionDetailBean){
    return Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          padding: EdgeInsets.all(12.0),
          child: Text(fictionDetailBean.description,style: TextStyle(fontSize: 14.0,color: Color(0xFF333333)),maxLines: 3,overflow: TextOverflow.ellipsis,),
        ),
        Container(
          height: 1.0,
          color: Color(0xFFF5F5F5),
        ),
        Container(
          padding: EdgeInsets.all(12.0),
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('目录',style: TextStyle(fontSize: 16.0,color: Color(0xFF333333),fontWeight: FontWeight.bold),),
                  Container(
                    margin: EdgeInsets.only(left: 17.0),
                    child: Text('连载至'+fictionDetailBean.chapterCount.toString()+'章',style: TextStyle(fontSize: 14.0,color: Color(0xFF666666)),),
                  ),

                ],
              ),
              Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset('images/icon_right.png',width: 6.0,height: 12.0,)
                ],
              )
            ],
          ),
        ),
        Container(
          height: 12.0,
          color: Color(0xFFF5F5F5),
        ),
      ],
    );
  }

  Widget getTableView(String table){
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      child: DecoratedBox(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                  color: Color(0xFFFFB30A),
                  width: 1.0
              )
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0),
            child: Center(
              child: Text(table,style: TextStyle(fontSize: 12.0,color: Color(0xFFFFB30A)),),
            ),
          )
      ),
    );
  }

  //获取热门推荐
  Widget getHotPushWidgets(List<FictionPushBook> hotPushLists){
    return Container(
      margin: EdgeInsets.only(top: 12.0,bottom: 12.0),
      padding: EdgeInsets.all(12.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('同类热门推荐',style: TextStyle(fontSize: 16.0,color: Colors.black,fontWeight: FontWeight.bold),),
          Container(
            padding: EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: hotPushLists.map((FictionPushBook fictionPushBook){
                return getFictionNormalStyle(fictionPushBook);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget getFictionNormalStyle(FictionPushBook fictionPushBook){
    return InkWell(
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context){

            }));
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(fictionPushBook.picture,width: 90.0,height: 120.0,),
          Container(
            width: 90.0,
            margin: EdgeInsets.only(top: 5.0,bottom: 3.0),
            child: Text(fictionPushBook.name,style: TextStyle(fontSize: 14.0,color: Color(0xFF333333)),softWrap: false,overflow: TextOverflow.ellipsis,),
          ),
          Container(
            width: 90.0,
            child: Text(fictionPushBook.author,style: TextStyle(fontSize: 14.0,color: Color(0xFF999999)),softWrap: false,overflow: TextOverflow.ellipsis,),
          ),
        ],
      ),
    );
  }

}
