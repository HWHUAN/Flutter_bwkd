import 'package:flutter/material.dart';
import 'bean/FictionHomeInfoResponse.dart';
import 'controller/HttpController.dart';

class FictionManFeatured extends StatefulWidget{
  List<FictionIntroduction> manLists;
  bool isMan;

  FictionManFeatured({this.manLists,this.isMan});


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new FictionManFeaturedState();
  }

}

class FictionManFeaturedState extends State<FictionManFeatured>{

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
    return getManFeaturedWidgets(widget.manLists);
  }

  Widget getManFeaturedWidgets(List<FictionIntroduction> manPushLists){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 10.0),
          child: Text(widget.isMan ? '男生精选' : '女生精选',style: TextStyle(fontSize: 16.0,color: Colors.black,fontWeight: FontWeight.bold),),
        ),
        Container(
          padding: EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: manPushLists.map((FictionIntroduction fictionIntroduction){
              return getFictionNormalStyle(fictionIntroduction);
            }).toList(),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10.0),
          height: 1.0,
          color: Color.fromARGB(150, 235, 235, 235),
        ),
        InkWell(
            onTap: (){
              getReplaceFiction(widget.isMan ? 'boy' : 'girl');
            },
            child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
                child: Stack(
                  fit: StackFit.loose,
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10.0,bottom: 10.0),
                      child: Image.asset('images/icon_replace.png',width: 78.0,height: 22.0,),
                    ),
                    Text('换一换',style: TextStyle(fontSize: 14.0,color: Color(0xFFFFB30A)),)
                  ],
                ),
            )
        ),

      ],
    );
  }

  Widget getFictionNormalStyle(FictionIntroduction fictionIntroduction){
    return Column(
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
    );
  }

  void getReplaceFiction(String type) async{
    await mHttpController.getReplaceFiction(type,(replacePushResponse){
      if(replacePushResponse!=null){
        setState(() {
          widget.manLists=replacePushResponse.data;
        });
      }
    });
  }

}