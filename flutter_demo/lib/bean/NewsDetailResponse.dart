import 'dart:convert' show json;

class NewsDetailResponse {

  int result;
  String msg;
  NewsDetail data;

  NewsDetailResponse.fromParams({this.result, this.msg, this.data});

  factory NewsDetailResponse(jsonStr) => jsonStr == null ? null : jsonStr is String ? new NewsDetailResponse.fromJson(json.decode(jsonStr)) : new NewsDetailResponse.fromJson(jsonStr);

  NewsDetailResponse.fromJson(jsonRes) {
    result = jsonRes['result'];
    msg = jsonRes['msg'];
    data = jsonRes['data'] == null ? null : new NewsDetail.fromJson(jsonRes['data']);
  }

  @override
  String toString() {
    return '{"result": $result,"msg": ${msg != null?'${json.encode(msg)}':'null'},"data": $data}';
  }
}

class NewsDetail {

  int FPS;
  int addTime;
  int bitRate;
  int commentCount;
  int id;
  int likes;
  int readcount;
  int videoSize;
  bool enableComment;
  bool isFavorite;
  bool isNoneImg;
  String addTimeStr;
  String author;
  String content;
  String description;
  String src;
  String timeLong;
  String title;
  String videoSrc;
  String xcShareId;
  String xcSharePath;
  List<String> pictureList;
  List<String> tagList;

  NewsDetail.fromParams({this.FPS, this.addTime, this.bitRate, this.commentCount, this.id, this.likes, this.readcount, this.videoSize, this.enableComment, this.isFavorite, this.isNoneImg, this.addTimeStr, this.author, this.content, this.description, this.src, this.timeLong, this.title, this.videoSrc, this.xcShareId, this.xcSharePath, this.pictureList, this.tagList});

  NewsDetail.fromJson(jsonRes) {
    FPS = jsonRes['FPS'];
    addTime = jsonRes['addTime'];
    bitRate = jsonRes['bitRate'];
    commentCount = jsonRes['commentCount'];
    id = jsonRes['id'];
    likes = jsonRes['likes'];
    readcount = jsonRes['readcount'];
    videoSize = jsonRes['videoSize'];
    enableComment = jsonRes['enableComment'];
    isFavorite = jsonRes['isFavorite'];
    isNoneImg = jsonRes['isNoneImg'];
    addTimeStr = jsonRes['addTimeStr'];
    author = jsonRes['author'];
    content = jsonRes['content'];
    description = jsonRes['description'];
    src = jsonRes['src'];
    timeLong = jsonRes['timeLong'];
    title = jsonRes['title'];
    videoSrc = jsonRes['videoSrc'];
    xcShareId = jsonRes['xcShareId'];
    xcSharePath = jsonRes['xcSharePath'];
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
    return '{"FPS": $FPS,"addTime": $addTime,"bitRate": $bitRate,"commentCount": $commentCount,"id": $id,"likes": $likes,"readcount": $readcount,"videoSize": $videoSize,"enableComment": $enableComment,"isFavorite": $isFavorite,"isNoneImg": $isNoneImg,"addTimeStr": ${addTimeStr != null?'${json.encode(addTimeStr)}':'null'},"author": ${author != null?'${json.encode(author)}':'null'},"content": ${content != null?'${json.encode(content)}':'null'},"description": ${description != null?'${json.encode(description)}':'null'},"src": ${src != null?'${json.encode(src)}':'null'},"timeLong": ${timeLong != null?'${json.encode(timeLong)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"videoSrc": ${videoSrc != null?'${json.encode(videoSrc)}':'null'},"xcShareId": ${xcShareId != null?'${json.encode(xcShareId)}':'null'},"xcSharePath": ${xcSharePath != null?'${json.encode(xcSharePath)}':'null'},"pictureList": $pictureList,"tagList": $tagList}';
  }
}

