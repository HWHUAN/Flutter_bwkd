import 'dart:convert' show json;

class NewsResData {

  int result;
  String msg;
  NewsObject data;

  NewsResData.fromParams({this.result, this.msg, this.data});

  factory NewsResData(jsonStr) => jsonStr == null ? null : jsonStr is String ? new NewsResData.fromJson(json.decode(jsonStr)) : new NewsResData.fromJson(jsonStr);

  NewsResData.fromJson(jsonRes) {
    result = jsonRes['result'];
    msg = jsonRes['msg'];
    data = jsonRes['data'] == null ? null : new NewsObject.fromJson(jsonRes['data']);
  }

  @override
  String toString() {
    return '{"result": $result,"msg": ${msg != null?'${json.encode(msg)}':'null'},"data": $data}';
  }
}

class NewsObject {

  String search;
  Object toplist;
  int currentindex;
  int currentpage;
  int lasttime;
  int tag;
  List<News> list;

  NewsObject.fromParams({this.search, this.toplist, this.currentindex, this.currentpage, this.lasttime, this.tag, this.list});

  NewsObject.fromJson(jsonRes) {
    search = jsonRes['search'];
    toplist = jsonRes['toplist'];
    currentindex = jsonRes['currentindex'];
    currentpage = jsonRes['currentpage'];
    lasttime = jsonRes['lasttime'];
    tag = jsonRes['tag'];
    list = jsonRes['list'] == null ? null : [];

    for (var listItem in list == null ? [] : jsonRes['list']){
      list.add(listItem == null ? null : new News.fromJson(listItem));
    }
  }

  @override
  String toString() {
    return '{"search": ${search != null?'${json.encode(search)}':'null'},"toplist": $toplist,"currentindex": $currentindex,"currentpage": $currentpage,"lasttime": $lasttime,"tag": $tag,"list": $list}';
  }
}

class News {

  int addTime;
  int commentCount;
  int flagId;
  int id;
  int likes;
  int pictureCount;
  int readcount;
  bool isBigIcon;
  bool isHot;
  bool isSpecial;
  bool isTop;
  String author;
  String description;
  String infoType;
  String redirectType;
  String src;
  String timeLong;
  String title;
  List<String> pictureList;

  News.fromParams({this.addTime, this.commentCount, this.flagId, this.id, this.likes, this.pictureCount, this.readcount, this.isBigIcon, this.isHot, this.isSpecial, this.isTop, this.author, this.description, this.infoType, this.redirectType, this.src, this.timeLong, this.title, this.pictureList});

  News.fromJson(jsonRes) {
    addTime = jsonRes['addTime'];
    commentCount = jsonRes['commentCount'];
    flagId = jsonRes['flagId'];
    id = jsonRes['id'];
    likes = jsonRes['likes'];
    pictureCount = jsonRes['pictureCount'];
    readcount = jsonRes['readcount'];
    isBigIcon = jsonRes['isBigIcon'];
    isHot = jsonRes['isHot'];
    isSpecial = jsonRes['isSpecial'];
    isTop = jsonRes['isTop'];
    author = jsonRes['author'];
    description = jsonRes['description'];
    infoType = jsonRes['infoType'];
    redirectType = jsonRes['redirectType'];
    src = jsonRes['src'];
    timeLong = jsonRes['timeLong'];
    title = jsonRes['title'];
    pictureList = jsonRes['pictureList'] == null ? null : [];

    for (var pictureListItem in pictureList == null ? [] : jsonRes['pictureList']){
      pictureList.add(pictureListItem);
    }
  }

  @override
  String toString() {
    return '{"addTime": $addTime,"commentCount": $commentCount,"flagId": $flagId,"id": $id,"likes": $likes,"pictureCount": $pictureCount,"readcount": $readcount,"isBigIcon": $isBigIcon,"isHot": $isHot,"isSpecial": $isSpecial,"isTop": $isTop,"author": ${author != null?'${json.encode(author)}':'null'},"description": ${description != null?'${json.encode(description)}':'null'},"infoType": ${infoType != null?'${json.encode(infoType)}':'null'},"redirectType": ${redirectType != null?'${json.encode(redirectType)}':'null'},"src": ${src != null?'${json.encode(src)}':'null'},"timeLong": ${timeLong != null?'${json.encode(timeLong)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"pictureList": $pictureList}';
  }
}

