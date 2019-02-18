import 'dart:convert' show json;

class ChannelResponse {

  int result;
  String msg;
  List<Channel> data;

  ChannelResponse.fromParams({this.result, this.msg, this.data});

  factory ChannelResponse(jsonStr) => jsonStr == null ? null : jsonStr is String ? new ChannelResponse.fromJson(json.decode(jsonStr)) : new ChannelResponse.fromJson(jsonStr);

  ChannelResponse.fromJson(jsonRes) {
    result = jsonRes['result'];
    msg = jsonRes['msg'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']){
      data.add(dataItem == null ? null : new Channel.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"result": $result,"msg": ${msg != null?'${json.encode(msg)}':'null'},"data": $data}';
  }
}

class Channel {

  int code;
  int sortIndex;
  bool isUserTag;
  String name;

  Channel.fromParams({this.code, this.sortIndex, this.isUserTag, this.name});

  Channel.fromJson(jsonRes) {
    code = jsonRes['code'];
    sortIndex = jsonRes['sortIndex'];
    isUserTag = jsonRes['isUserTag'];
    name = jsonRes['name'];
  }

  @override
  String toString() {
    return '{"code": $code,"sortIndex": $sortIndex,"isUserTag": $isUserTag,"name": ${name != null?'${json.encode(name)}':'null'}}';
  }
}

