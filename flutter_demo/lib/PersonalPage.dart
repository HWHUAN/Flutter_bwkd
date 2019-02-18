import 'package:flutter/material.dart';

class PersonalPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new PersonalPageState();
  }

}

class PersonalPageState extends State<PersonalPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          getHeartView(),
        ],
      ),
    );
  }

  Widget getHeartView(){
    return Stack(
      children: <Widget>[
        Image.asset('images/personal_heart_bg.png',),
        Column(
          children: <Widget>[
            Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(2.0),
                  margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top,right: 8.0),
                  child: Image.asset('images/setting.png',width: 20.0,height: 20.0,),
                )
              ],
            ),

            Container(
              margin: EdgeInsets.only(left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset('images/personal_ava_default.png',width: 72.0,height: 72.0,),
                  Container(
                    margin: EdgeInsets.only(left: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Betty',style: TextStyle(fontSize: 16.0,color: Color(0xFF333333),),),
                        Text('ID：12345678',style: TextStyle(fontSize: 16.0,color: Color(0xFF333333),),),
                      ],
                    ),
                  )
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('5000',style: TextStyle(fontSize: 20.0,color: Color(0xFF333333),),),
                      Padding(
                        padding: EdgeInsets.only(top: 3.0),
                        child: Text('我的金币',style: TextStyle(fontSize: 14.0,color: Color(0xFF333333)),),
                      )
                    ],
                  ),
                  Container(
                    width: 1.0,
                    height: 27.0,
                    color: Color(0xFF999999),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('10',style: TextStyle(fontSize: 20.0,color: Color(0xFF333333),),),
                      Padding(
                        padding: EdgeInsets.only(top: 3.0),
                        child: Text('我的零钱',style: TextStyle(fontSize: 14.0,color: Color(0xFF333333)),),
                      )
                    ],
                  ),
                  Container(
                    width: 1.0,
                    height: 27.0,
                    color: Color(0xFF999999),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('7',style: TextStyle(fontSize: 20.0,color: Color(0xFF333333),),),
                      Padding(
                        padding: EdgeInsets.only(top: 3.0),
                        child: Text('收徒人数',style: TextStyle(fontSize: 14.0,color: Color(0xFF333333)),),
                      )
                    ],
                  )
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(30.0, 35.0, 30.0, 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('images/mine_withdraw_icon.png',width: 24.0,height: 24.0,),
                      Padding(
                        padding: EdgeInsets.only(top: 3.0),
                        child: Text('提现',style: TextStyle(fontSize: 14.0,color: Color(0xFF333333)),),
                      )
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('images/mine_cash_icon.png',width: 24.0,height: 24.0,),
                      Padding(
                        padding: EdgeInsets.only(top: 3.0),
                        child: Text('明细',style: TextStyle(fontSize: 14.0,color: Color(0xFF333333)),),
                      )
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('images/mine_apprentice_icon.png',width: 24.0,height: 24.0,),
                      Padding(
                        padding: EdgeInsets.only(top: 3.0),
                        child: Text('收徒',style: TextStyle(fontSize: 14.0,color: Color(0xFF333333)),),
                      )
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('images/mine_message_icon.png',width: 24.0,height: 24.0,),
                      Padding(
                        padding: EdgeInsets.only(top: 3.0),
                        child: Text('消息',style: TextStyle(fontSize: 14.0,color: Color(0xFF333333)),),
                      )
                    ],
                  ),
                ],
              ),
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              height: 10.0,
              color: Color(0xFFEEEEEE),
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
                      Image.asset('images/mine_code_icon.png',width: 20.0,height: 20.0,),
                      Container(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text('面对面收徒',style: TextStyle(fontSize: 16.0,color: Color(0xFF333333)),),
                      )

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
              padding: EdgeInsets.all(12.0),
              margin: EdgeInsets.only(top: 1.0),
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('images/mine_riddle_icon.png',width: 20.0,height: 20.0,),
                      Container(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text('答题解谜',style: TextStyle(fontSize: 16.0,color: Color(0xFF333333)),),
                      )

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
              padding: EdgeInsets.all(12.0),
              margin: EdgeInsets.only(top: 1.0),
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('images/mine_guess_icon.png',width: 20.0,height: 20.0,),
                      Container(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text('趣味竞猜',style: TextStyle(fontSize: 16.0,color: Color(0xFF333333)),),
                      )

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
              width: MediaQuery.of(context).size.width,
              height: 10.0,
              color: Color(0xFFEEEEEE),
            ),

            Container(
              padding: EdgeInsets.all(12.0),
              margin: EdgeInsets.only(top: 1.0),
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('images/mine_wallet_icon.png',width: 20.0,height: 20.0,),
                      Container(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text('赚钱攻略',style: TextStyle(fontSize: 16.0,color: Color(0xFF333333)),),
                      )

                    ],
                  ),
                  Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('images/icon_right.png',width: 6.0,height: 12.0,),
                      Container(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Text('教你玩转百万头条',style: TextStyle(fontSize: 13.0,color: Color(0xFFFF9600)),),
                      ),
                    ],
                  )
                ],
              ),
            ),

          ],
        )
      ],
    );
  }

}