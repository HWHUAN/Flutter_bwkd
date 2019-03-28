import 'package:flutter/material.dart';
class HuanTest extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HuanTestState();
  }

}

class HuanTestState extends State<HuanTest>{
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
                            child: Center(
                              child: Text('开始阅读',style: TextStyle(fontSize: 18.0,color: Colors.white),),
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

}