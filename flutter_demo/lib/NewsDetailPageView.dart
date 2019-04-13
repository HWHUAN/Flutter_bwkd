

import 'package:flutter/material.dart';
import 'package:flutter_demo/bean/NewsResData.dart';
import 'package:flutter_demo/view/NewDetailWebview.dart';

class NewsDetailPageView extends StatefulWidget{
  News mNews;
  NewsDetailPageView({this.mNews});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new NewsDetailPageViewState();
  }

}

class NewsDetailPageViewState extends State<NewsDetailPageView>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Theme(
        data: ThemeData(
            primaryColor: Color(0xFFF5F5F5)
        ),
        child: Scaffold(
          body: Column(
            children: <Widget>[
             Container(
               height: 40.0,
               child:  Text('中国联通中国联通中国联通'),
             ),
             Transform(transform: null),
             Container(
               height: MediaQuery.of(context).size.height-150.0,
               child:  NewDetailWebview(mNews: widget.mNews),
             ),

            ],
          ),
        )
    );
  }

}