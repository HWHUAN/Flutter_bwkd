import 'package:dio/dio.dart';
import 'package:flutter_demo/bean/HotSearchResponse.dart';
import 'dart:async';
import 'package:flutter_demo/bean/NewsResData.dart';
import 'package:flutter_demo/bean/ChannelResponse.dart';
import 'package:flutter_demo/bean/RelativeInfoResponse.dart';
import 'package:flutter_demo/bean/BannerInfoResponse.dart';
import 'package:flutter_demo/bean/FictionHomeInfoResponse.dart';
import 'package:flutter_demo/bean/NewsDetailResponse.dart';
import 'package:flutter_demo/bean/FictionDetailResponse.dart';

class HttpController{
  Dio dio;
  HttpController(){
    dio=new Dio();
  }
  void getNewsList(String url,Function callBack,{Map<String,String> params,Function errorCallback}){
      dio.get(url,data: params).then((Response response){
        print(response.data.toString());
        NewsResData newsResData=new NewsResData.fromJson(response.data);
        if(newsResData.result==200){
          callBack(newsResData);
          print("数据大小="+newsResData.data.list.length.toString());
        }
      });
  }

  //获取channel频道
  void getChannelList(Function callBack,{Function errorCallBack}){
    dio.get("https://app.tenyou0574.com/App/Info/GetDefaultTags").then((Response response){
      try {
        ChannelResponse channelResponse=new ChannelResponse.fromJson(response.data);
        if(channelResponse.result==200){
                callBack(channelResponse.data);
              }else{
                errorCallBack(channelResponse.msg);
              }
      } catch (e) {
        errorCallBack(e.toString());
      }
    });
  }

  void getRelativeInfo(int infoId,Function callBack,{Function errorCallBack})  {
    Map<String,String> dataMap=new Map();
    dataMap["id"]=infoId.toString();
     dio.get("https://app.tenyou0574.com/App/Info/GetRelationInfo",data: dataMap).then((Response response){
      RelativeInfoResponse relativeInfoResponse=new RelativeInfoResponse.fromJson(response.data);
      if(relativeInfoResponse.result==200){
        RelativeNews relativeNews=new RelativeNews.fromParams(infoType: "videoTitle");
        relativeInfoResponse.data.insert(0, relativeNews);
        callBack(relativeInfoResponse);
      }else{
        errorCallBack(relativeInfoResponse.msg);
      }
    });
  }

  void getNewsDetail(int infoId,Function callBack,{Function errorCallBack}){
    Map<String,String> dataMap=new Map();
    dataMap["id"]=infoId.toString();
    dio.get("https://app.tenyou0574.com/App/Info/GetDetailInfo",data: dataMap).then((Response response){
      NewsDetailResponse newsDetailResponse=new NewsDetailResponse.fromJson(response.data);
      if(newsDetailResponse.result==200){
        callBack(newsDetailResponse.data);
        print("NewsDetailResponse="+newsDetailResponse.toString());
      }else{
        errorCallBack(newsDetailResponse.msg);
      }
    });
  }

  Future<List<DataBean>> getBannerInfo(String type,{Function errorCallBack}) async{
    Map<String,String> dataMap=new Map();
    dataMap["type"]=type;
    /*await dio.get("https://app.tenyou0574.com/App/Common/GetBannerInfo",data: dataMap).then((Response response){
      BannerInfoResponse bannerInfoResponse=new BannerInfoResponse.fromJson(response.data);
      return bannerInfoResponse.data;
    });*/
    Response response=await dio.get("https://app.tenyou0574.com/App/Common/GetBannerInfo",data: dataMap);
    BannerInfoResponse bannerInfoResponse=new BannerInfoResponse.fromJson(response.data);
    return bannerInfoResponse.data;
  }

  //获取小说首页内容
  Future<FictionHomeInfoResponse> getFictionHomePageInfo () async{
    Response response=await dio.get("https://app.tenyou0574.com/App/Book/HomePageBook");
    FictionHomeInfoResponse fictionHomeInfoResponse=new FictionHomeInfoResponse.fromJson(response.data);
    return fictionHomeInfoResponse;
  }

  void getReplaceFiction(String type,Function callBack,{Function errorCallBack})  {
    Map<String,String> dataMap=new Map();
    dataMap["type"]=type;
    dio.get("https://app.tenyou0574.com/App/Book/GetOtherPush",data: dataMap).then((Response response){
      HotPushResponse replacePushResponse=new HotPushResponse.fromJson(response.data);
      if(replacePushResponse.result==200){
        callBack(replacePushResponse);
      }else{
        errorCallBack(replacePushResponse.msg);
      }
    });
  }

  Future<FictionDetailResponse> getFictionDetail(int fictionId) async{
    Map<String,String> dataMap=new Map();
    dataMap["bookid"]=fictionId.toString();
    Response response=await dio.get("https://app.tenyou0574.com/App/Book/GetBookDetail",data: dataMap);
    FictionDetailResponse fictionDetailResponse =FictionDetailResponse.fromJson(response.data);
    return fictionDetailResponse;
  }

  //获取所搜热词
  Future<HotSearchResponse> getHotSearchKeyWord () async{
    Response response=await dio.get("https://app.tenyou0574.com/App/Info/GetHotSearchKeyWord");
    HotSearchResponse hotSearchResponse=new HotSearchResponse.fromJson(response.data);
    /*  HotSearchBean hotSearchBean=HotSearchBean.fromParams(code: -1,name: "热门搜索");
    hotSearchResponse.data.insert(0, hotSearchBean);*/
    return hotSearchResponse;
  }

}