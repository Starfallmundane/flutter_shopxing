// To parse this JSON data, do
//
//     final goodDetailBean = goodDetailBeanFromJson(jsonString);

import 'dart:convert';

GoodDetailBean goodDetailBeanFromJson(String str) => GoodDetailBean.fromJson(json.decode(str));

String goodDetailBeanToJson(GoodDetailBean data) => json.encode(data.toJson());

class GoodDetailBean {
  GoodDetailBean({
    this.goodInfo,
    this.goodComments,
    this.advertesPicture,
  });

  GoodInfo goodInfo;
  List<dynamic> goodComments;
  AdvertesPicture advertesPicture;

  factory GoodDetailBean.fromJson(Map<String, dynamic> json) => GoodDetailBean(
    goodInfo: GoodInfo.fromJson(json["goodInfo"]),
    goodComments: List<dynamic>.from(json["goodComments"].map((x) => x)),
    advertesPicture: AdvertesPicture.fromJson(json["advertesPicture"]),
  );

  Map<String, dynamic> toJson() => {
    "goodInfo": goodInfo.toJson(),
    "goodComments": List<dynamic>.from(goodComments.map((x) => x)),
    "advertesPicture": advertesPicture.toJson(),
  };
}

class AdvertesPicture {
  AdvertesPicture({
    this.pictureAddress,
    this.toPlace,
  });

  String pictureAddress;
  String toPlace;

  factory AdvertesPicture.fromJson(Map<String, dynamic> json) => AdvertesPicture(
    pictureAddress: json["PICTURE_ADDRESS"],
    toPlace: json["TO_PLACE"],
  );

  Map<String, dynamic> toJson() => {
    "PICTURE_ADDRESS": pictureAddress,
    "TO_PLACE": toPlace,
  };
}

class GoodInfo {
  GoodInfo({
    this.image5,
    this.amount,
    this.image3,
    this.image4,
    this.goodsId,
    this.isOnline,
    this.image1,
    this.image2,
    this.goodsSerialNumber,
    this.oriPrice,
    this.presentPrice,
    this.comPic,
    this.state,
    this.shopId,
    this.goodsName,
    this.goodsDetail,
  });

  String image5;
  int amount;
  String image3;
  String image4;
  String goodsId;
  String isOnline;
  String image1;
  String image2;
  String goodsSerialNumber;
  double oriPrice;
  double presentPrice;
  String comPic;
  int state;
  String shopId;
  String goodsName;
  String goodsDetail;

  factory GoodInfo.fromJson(Map<String, dynamic> json) => GoodInfo(
    image5: json["image5"],
    amount: json["amount"],
    image3: json["image3"],
    image4: json["image4"],
    goodsId: json["goodsId"],
    isOnline: json["isOnline"],
    image1: json["image1"],
    image2: json["image2"],
    goodsSerialNumber: json["goodsSerialNumber"],
    oriPrice: json["oriPrice"],
    presentPrice: json["presentPrice"],
    comPic: json["comPic"],
    state: json["state"],
    shopId: json["shopId"],
    goodsName: json["goodsName"],
    goodsDetail: json["goodsDetail"],
  );

  Map<String, dynamic> toJson() => {
    "image5": image5,
    "amount": amount,
    "image3": image3,
    "image4": image4,
    "goodsId": goodsId,
    "isOnline": isOnline,
    "image1": image1,
    "image2": image2,
    "goodsSerialNumber": goodsSerialNumber,
    "oriPrice": oriPrice,
    "presentPrice": presentPrice,
    "comPic": comPic,
    "state": state,
    "shopId": shopId,
    "goodsName": goodsName,
    "goodsDetail": goodsDetail,
  };
}
