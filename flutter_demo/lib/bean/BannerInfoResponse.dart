import 'dart:convert' show json;

class BannerInfoResponse {

  int result;
  String msg;
  List<DataBean> data;

  BannerInfoResponse.fromParams({this.result, this.msg, this.data});

  factory BannerInfoResponse(jsonStr) => jsonStr == null ? null : jsonStr is String ? new BannerInfoResponse.fromJson(json.decode(jsonStr)) : new BannerInfoResponse.fromJson(jsonStr);

  BannerInfoResponse.fromJson(jsonRes) {
    result = jsonRes['result'];
    msg = jsonRes['msg'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']){
      data.add(dataItem == null ? null : new DataBean.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"result": $result,"msg": ${msg != null?'${json.encode(msg)}':'null'},"data": $data}';
  }
}

class DataBean {

  String redirctUrl;
  int flagId;
  String infoType;
  String pictureUrl;
  String redirectType;

  DataBean.fromParams({this.redirctUrl, this.flagId, this.infoType, this.pictureUrl, this.redirectType});

  DataBean.fromJson(jsonRes) {
    redirctUrl = jsonRes['redirctUrl'];
    flagId = jsonRes['flagId'];
    infoType = jsonRes['infoType'];
    pictureUrl = jsonRes['pictureUrl'];
    redirectType = jsonRes['redirectType'];
  }

  @override
  String toString() {
    return '{"redirctUrl": ${redirctUrl != null?'${json.encode(redirctUrl)}':'null'},"flagId": $flagId,"infoType": ${infoType != null?'${json.encode(infoType)}':'null'},"pictureUrl": ${pictureUrl != null?'${json.encode(pictureUrl)}':'null'},"redirectType": ${redirectType != null?'${json.encode(redirectType)}':'null'}}';
  }
}

