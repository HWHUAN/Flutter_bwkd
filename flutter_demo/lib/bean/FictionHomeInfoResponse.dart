import 'dart:convert' show json;

class FictionHomeInfoResponse {

  List<HotPushResponse> other;
  HotPushResponse editerPush;
  HotPushResponse freeTime;
  HotPushResponse hotPush;

  FictionHomeInfoResponse.fromParams({this.other, this.editerPush, this.freeTime, this.hotPush});

  factory FictionHomeInfoResponse(jsonStr) => jsonStr == null ? null : jsonStr is String ? new FictionHomeInfoResponse.fromJson(json.decode(jsonStr)) : new FictionHomeInfoResponse.fromJson(jsonStr);

  FictionHomeInfoResponse.fromJson(jsonRes) {
    other = jsonRes['other'] == null ? null : [];

    for (var otherItem in other == null ? [] : jsonRes['other']){
      other.add(otherItem == null ? null : new HotPushResponse.fromJson(otherItem));
    }

    editerPush = jsonRes['editerPush'] == null ? null : new HotPushResponse.fromJson(jsonRes['editerPush']);
    freeTime = jsonRes['freeTime'] == null ? null : new HotPushResponse.fromJson(jsonRes['freeTime']);
    hotPush = jsonRes['hotPush'] == null ? null : new HotPushResponse.fromJson(jsonRes['hotPush']);
  }

  @override
  String toString() {
    return '{"other": $other,"editerPush": $editerPush,"freeTime": $freeTime,"hotPush": $hotPush}';
  }
}

class HotPushResponse{
  int result;
  String msg;
  String type;
  String title;
  List<FictionIntroduction> data;

  HotPushResponse.fromParams({this.result, this.msg, this.type, this.title, this.data});

  factory HotPushResponse(jsonStr) => jsonStr == null ? null : jsonStr is String ? new HotPushResponse.fromJson(json.decode(jsonStr)) : new HotPushResponse.fromJson(jsonStr);

  HotPushResponse.fromJson(jsonRes) {
    result = jsonRes['result'];
    msg = jsonRes['msg'];
    type = jsonRes['type'];
    title = jsonRes['title'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']){
      data.add(dataItem == null ? null : new FictionIntroduction.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"result": $result,"msg": ${msg != null?'${json.encode(msg)}':'null'},"type": ${type != null?'${json.encode(type)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"data": $data}';
  }

}

class FictionIntroduction {

  int bookId;
  String author;
  String description;
  String name;
  String picture;
  String pushDescription;

  FictionIntroduction.fromParams({this.bookId, this.author, this.description, this.name, this.picture, this.pushDescription});

  FictionIntroduction.fromJson(jsonRes) {
    bookId = jsonRes['bookId'];
    author = jsonRes['author'];
    description = jsonRes['description'];
    name = jsonRes['name'];
    picture = jsonRes['picture'];
    pushDescription = jsonRes['pushDescription'];
  }

  @override
  String toString() {
    return '{"bookId": $bookId,"author": ${author != null?'${json.encode(author)}':'null'},"description": ${description != null?'${json.encode(description)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"picture": ${picture != null?'${json.encode(picture)}':'null'},"pushDescription": ${pushDescription != null?'${json.encode(pushDescription)}':'null'}}';
  }
}







