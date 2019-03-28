import 'dart:convert' show json;

class HotSearchResponse {

  int result;
  String msg;
  List<HotSearchBean> data;

  HotSearchResponse.fromParams({this.result, this.msg, this.data});

  factory HotSearchResponse(jsonStr) => jsonStr == null ? null : jsonStr is String ? new HotSearchResponse.fromJson(json.decode(jsonStr)) : new HotSearchResponse.fromJson(jsonStr);

  HotSearchResponse.fromJson(jsonRes) {
    result = jsonRes['result'];
    msg = jsonRes['msg'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']){
      data.add(dataItem == null ? null : new HotSearchBean.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"result": $result,"msg": ${msg != null?'${json.encode(msg)}':'null'},"data": $data}';
  }
}

class HotSearchBean {

  int code;
  String name;

  HotSearchBean.fromParams({this.code, this.name});

  HotSearchBean.fromJson(jsonRes) {
    code = jsonRes['code'];
    name = jsonRes['name'];
  }

  @override
  String toString() {
    return '{"code": $code,"name": ${name != null?'${json.encode(name)}':'null'}}';
  }
}

