import 'dart:convert' show json;

class RelativeInfoResponse {

  int result;
  String msg;
  List<RelativeNews> data;

  RelativeInfoResponse.fromParams({this.result, this.msg, this.data});

  factory RelativeInfoResponse(jsonStr) => jsonStr == null ? null : jsonStr is String ? new RelativeInfoResponse.fromJson(json.decode(jsonStr)) : new RelativeInfoResponse.fromJson(jsonStr);

  RelativeInfoResponse.fromJson(jsonRes) {
    result = jsonRes['result'];
    msg = jsonRes['msg'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']){
      data.add(dataItem == null ? null : new RelativeNews.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"result": $result,"msg": ${msg != null?'${json.encode(msg)}':'null'},"data": $data}';
  }
}

class RelativeNews {

  int addTime;
  int commentCount;
  int id;
  int likes;
  String author;
  String description;
  String infoType;
  String src;
  String timeLong;
  String title;
  List<String> pictureList;
  List<String> tagList;

  RelativeNews.fromParams({this.addTime, this.commentCount, this.id, this.likes, this.author, this.description, this.infoType, this.src, this.timeLong, this.title, this.pictureList, this.tagList});

  RelativeNews.fromJson(jsonRes) {
    addTime = jsonRes['addTime'];
    commentCount = jsonRes['commentCount'];
    id = jsonRes['id'];
    likes = jsonRes['likes'];
    author = jsonRes['author'];
    description = jsonRes['description'];
    infoType = jsonRes['infoType'];
    src = jsonRes['src'];
    timeLong = jsonRes['timeLong'];
    title = jsonRes['title'];
    pictureList = jsonRes['pictureList'] == null ? null : [];

    for (var pictureListItem in pictureList == null ? [] : jsonRes['pictureList']){
      pictureList.add(pictureListItem);
    }

    tagList = jsonRes['tagList'] == null ? null : [];

    for (var tagListItem in tagList == null ? [] : jsonRes['tagList']){
      tagList.add(tagListItem);
    }
  }

  @override
  String toString() {
    return '{"addTime": $addTime,"commentCount": $commentCount,"id": $id,"likes": $likes,"author": ${author != null?'${json.encode(author)}':'null'},"description": ${description != null?'${json.encode(description)}':'null'},"infoType": ${infoType != null?'${json.encode(infoType)}':'null'},"src": ${src != null?'${json.encode(src)}':'null'},"timeLong": ${timeLong != null?'${json.encode(timeLong)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"pictureList": $pictureList,"tagList": $tagList}';
  }
}

