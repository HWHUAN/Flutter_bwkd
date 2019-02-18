import 'dart:convert' show json;

class FictionDetailResponse {

  int result;
  String msg;
  FictionDetailBean data;

  FictionDetailResponse.fromParams({this.result, this.msg, this.data});

  factory FictionDetailResponse(jsonStr) => jsonStr == null ? null : jsonStr is String ? new FictionDetailResponse.fromJson(json.decode(jsonStr)) : new FictionDetailResponse.fromJson(jsonStr);

  FictionDetailResponse.fromJson(jsonRes) {
    result = jsonRes['result'];
    msg = jsonRes['msg'];
    data = jsonRes['data'] == null ? null : new FictionDetailBean.fromJson(jsonRes['data']);
  }

  @override
  String toString() {
    return '{"result": $result,"msg": ${msg != null?'${json.encode(msg)}':'null'},"data": $data}';
  }
}

class FictionDetailBean {

  int chapterCount;
  int commentCount;
  int id;
  int score;
  int wordCount;
  bool isFavorite;
  String author;
  String cp;
  String description;
  String lastChapter;
  String name;
  String picture;
  String state;
  List<FictionPushBook> pushBookList;
  List<String> tags;
  LastComment lastComment;

  FictionDetailBean.fromParams({this.chapterCount, this.commentCount, this.id, this.score, this.wordCount, this.isFavorite, this.author, this.cp, this.description, this.lastChapter, this.name, this.picture, this.state, this.pushBookList, this.tags, this.lastComment});

  FictionDetailBean.fromJson(jsonRes) {
    chapterCount = jsonRes['chapterCount'];
    commentCount = jsonRes['commentCount'];
    id = jsonRes['id'];
    score = jsonRes['score'];
    wordCount = jsonRes['wordCount'];
    isFavorite = jsonRes['isFavorite'];
    author = jsonRes['author'];
    cp = jsonRes['cp'];
    description = jsonRes['description'];
    lastChapter = jsonRes['lastChapter'];
    name = jsonRes['name'];
    picture = jsonRes['picture'];
    state = jsonRes['state'];
    pushBookList = jsonRes['pushBookList'] == null ? null : [];

    for (var pushBookListItem in pushBookList == null ? [] : jsonRes['pushBookList']){
      pushBookList.add(pushBookListItem == null ? null : new FictionPushBook.fromJson(pushBookListItem));
    }

    tags = jsonRes['tags'] == null ? null : [];

    for (var tagsItem in tags == null ? [] : jsonRes['tags']){
      tags.add(tagsItem);
    }

    lastComment = jsonRes['lastComment'] == null ? null : new LastComment.fromJson(jsonRes['lastComment']);
  }

  @override
  String toString() {
    return '{"chapterCount": $chapterCount,"commentCount": $commentCount,"id": $id,"score": $score,"wordCount": $wordCount,"isFavorite": $isFavorite,"author": ${author != null?'${json.encode(author)}':'null'},"cp": ${cp != null?'${json.encode(cp)}':'null'},"description": ${description != null?'${json.encode(description)}':'null'},"lastChapter": ${lastChapter != null?'${json.encode(lastChapter)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"picture": ${picture != null?'${json.encode(picture)}':'null'},"state": ${state != null?'${json.encode(state)}':'null'},"pushBookList": $pushBookList,"tags": $tags,"lastComment": $lastComment}';
  }
}

class LastComment {

  int level;
  String comment;
  String userAvatar;
  String userName;

  LastComment.fromParams({this.level, this.comment, this.userAvatar, this.userName});

  LastComment.fromJson(jsonRes) {
    level = jsonRes['level'];
    comment = jsonRes['comment'];
    userAvatar = jsonRes['userAvatar'];
    userName = jsonRes['userName'];
  }

  @override
  String toString() {
    return '{"level": $level,"comment": ${comment != null?'${json.encode(comment)}':'null'},"userAvatar": ${userAvatar != null?'${json.encode(userAvatar)}':'null'},"userName": ${userName != null?'${json.encode(userName)}':'null'}}';
  }
}

class FictionPushBook {

  int id;
  String author;
  String name;
  String picture;

  FictionPushBook.fromParams({this.id, this.author, this.name, this.picture});

  FictionPushBook.fromJson(jsonRes) {
    id = jsonRes['id'];
    author = jsonRes['author'];
    name = jsonRes['name'];
    picture = jsonRes['picture'];
  }

  @override
  String toString() {
    return '{"id": $id,"author": ${author != null?'${json.encode(author)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"picture": ${picture != null?'${json.encode(picture)}':'null'}}';
  }
}

