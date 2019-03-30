import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/bean/ChannelResponse.dart';
import 'package:flutter_demo/bean/HotSearchResponse.dart';
import 'package:flutter_demo/channelView.dart';
import 'package:flutter_demo/controller/HttpController.dart';
import 'package:flutter_demo/utils/SpUtil.dart';
import 'package:flutter_demo/view/SearchView.dart';

class SearchPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new SearchPageSate();
  }
}

class SearchPageSate extends State<SearchPage>{

  HttpController mHttpController;

  List<String> historySearchList= <String>[];
  bool mShowSearchContent=false;

  FocusNode _focusNode = FocusNode();
  TextEditingController _controller = new TextEditingController();

  String mSearchText="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mHttpController=new HttpController();
    getHistory();
  }

  void getHistory(){
    List<String> data=SpUtil.getStringList("historySearch",defValue : []);
    setState(() {
      historySearchList.addAll(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    return layout(context);
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
                    color: Color(0xFFFFFFFF),
                    height: MediaQuery.of(context).padding.top,
                    width: MediaQuery.of(context).size.width,
                  )
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top,
                left: 0.0,
                child: new Container(
                  color: Color(0xFFFFFFFF),
                  height: 40.0,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 12.0,right: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                          flex: 5,
                          child: new SearchView(
                              focusNode: _focusNode,
                              controller: _controller,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(50),
                              ],
                              onChangedCallback: () {
                                onSearchTextChangeCallBack();
                              },
                              onEditingComplete: () => _checkInput()
                          )
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text('取消',style: TextStyle(fontSize: 16.0,color: Color(0xFF333333)),),
                          ),
                        )
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: MediaQuery.of(context).padding.top + 40.0,
                  left: 0.0,
                  height: MediaQuery.of(context).size.height-40.0-MediaQuery.of(context).padding.top,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    color: Color(0xFFFFFFFF),
                    padding: EdgeInsets.only(top: 5.0),
                    child: layout(context)
                  )
              )
            ],
          )
        )
    );
  }

  Widget layout(BuildContext context){
    if(!mShowSearchContent){
       return Column(
            children: <Widget>[
              getHeadView(),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Color(0xFFFFFFFF),
                padding: EdgeInsets.all(12.0),
                child: Text('热门搜索',style: TextStyle(fontSize: 16.0,color: Color(0xFF000000),fontWeight: FontWeight.bold),),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300.0,
                child: FutureBuilder<HotSearchResponse>(
                    future: mHttpController.getHotSearchKeyWord(),
                    builder: (BuildContext context, AsyncSnapshot snapshot){
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        case ConnectionState.done:
                          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                          return getHotSearchContent(snapshot.data);
                        default:
                          return null;
                      }
                    }
                ),
              ),
            ],
         );
    }else{
      return NewsListView(mChannelCode: 0.toString(),mSearchText: mSearchText,);
    }
  }

  void _checkInput() {
    String searchText = _controller.text;
    if (searchText.isEmpty) {
      FocusScope.of(context).requestFocus(_focusNode);
      return;
    }

    setState(() {
      mSearchText=searchText;
      mShowSearchContent=true;
      historySearchList.insert(0, mSearchText);
      SpUtil.putStringList('historySearch', historySearchList);

    });

  }

  void onSearchTextChangeCallBack(){
    String searchText = _controller.text;
    if (searchText.isEmpty) {
        setState(() {
          mSearchText="";
          mShowSearchContent=false;
        });
    }
  }

  Widget getHotSearchContent(HotSearchResponse response){
    List<HotSearchBean> data=response.data;
    return new GridView.builder(
        padding: const EdgeInsets.only(left: 12.0),
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 5.0,
        crossAxisSpacing: 10.0,
        crossAxisCount: 2,
        childAspectRatio: 4.0
      ),
      itemBuilder:  (BuildContext context, int index) {
        return InkWell(
          onTap: (){
            setState(() {
              mSearchText=data[index].name;
              mShowSearchContent=true;
              _controller.text=mSearchText;
            });
          },
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text((index+1).toString()+".",style: TextStyle(fontSize: 16.0,color: Color(0xFFFFB30A)),),
                Text(data[index].name,style: TextStyle(fontSize: 16.0,color: Color(0xFF333333)),),
              ],
            ),
          ),
        );
      },
      itemCount: data.length,
    );
  }



  Widget getHeadView(){
    return Column(
      children: <Widget>[
        Container(
          height: 40.0,
          color: Color(0xFFF5F5F5),
          padding: EdgeInsets.only(left: 12.0,right: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
                Expanded(
                    flex: 5,
                    child: Text('最近搜索',style: TextStyle(fontSize: 14.0,color: Color(0xFF999999)),)
                ),
                Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          historySearchList.clear();
                          SpUtil.putStringList('historySearch', historySearchList);
                        });
                      },
                      child: Text('清空记录',style: TextStyle(fontSize: 14.0,color: Color(0xFF999999)),),
                    )
                )
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: historySearchList.map((String history){
           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               Container(
                 height: 40.0,
                 color: Color(0xFFFFFFFF),
                 padding: EdgeInsets.only(left: 12.0,right: 12.0),
                 child:  Row(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: <Widget>[
                     Expanded(
                         flex: 8,
                         child: InkWell(
                           onTap: (){
                             setState(() {
                               mSearchText=history;
                               mShowSearchContent=true;
                               _controller.text=mSearchText;
                             });
                           },
                           child: Container(
                             padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                             child: Text(history,style: TextStyle(fontSize: 14.0,color: Color(0xFF333333)),),
                           ),
                         )
                     ),
                     Expanded(
                         flex: 1,
                         child: InkWell(
                           onTap: (){
                              setState(() {
                                historySearchList.remove(history);
                              });
                           },
                           child: Icon(
                             Icons.clear,
                             size: 18.0,
                             color: Colors.grey,
                           ),
                         )
                     )
                   ],
                 )
               ),
               Container(
                 margin: EdgeInsets.only(left: 12.0,right: 12.0),
                 child: Divider(height: 2.0,),
               )
             ],
           );
          }).toList(),
        )
      ],
    );
  }

}