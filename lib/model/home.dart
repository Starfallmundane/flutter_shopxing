// To parse this JSON data, do
//
//     final homeBean = homeBeanFromJson(jsonString);

import 'dart:convert';

HomeBean homeBeanFromJson(String str) => HomeBean.fromJson(json.decode(str));

String homeBeanToJson(HomeBean data) => json.encode(data.toJson());

class HomeBean {
  HomeBean({
    this.slides,
    this.shopInfo,
    this.integralMallPic,
    this.toShareCode,
    this.recommend,
    this.advertesPicture,
    this.floor1,
    this.floor2,
    this.floor3,
    this.saoma,
    this.newUser,
    this.floor1Pic,
    this.floor2Pic,
    this.floorName,
    this.category,
    this.floor3Pic,
    this.reservationGoods,
  });

  List<Floor1> slides;
  ShopInfo shopInfo;
  AdvertesPicture integralMallPic;
  AdvertesPicture toShareCode;
  List<Recommend> recommend;
  AdvertesPicture advertesPicture;
  List<Floor1> floor1;
  List<Floor1> floor2;
  List<Floor1> floor3;
  AdvertesPicture saoma;
  AdvertesPicture newUser;
  AdvertesPicture floor1Pic;
  AdvertesPicture floor2Pic;
  FloorName floorName;
  List<Category> category;
  AdvertesPicture floor3Pic;
  List<dynamic> reservationGoods;

  factory HomeBean.fromJson(Map<String, dynamic> json) => HomeBean(
        slides:
            List<Floor1>.from(json["slides"].map((x) => Floor1.fromJson(x))),
        shopInfo: ShopInfo.fromJson(json["shopInfo"]),
        integralMallPic: AdvertesPicture.fromJson(json["integralMallPic"]),
        toShareCode: AdvertesPicture.fromJson(json["toShareCode"]),
        recommend: List<Recommend>.from(
            json["recommend"].map((x) => Recommend.fromJson(x))),
        advertesPicture: AdvertesPicture.fromJson(json["advertesPicture"]),
        floor1:
            List<Floor1>.from(json["floor1"].map((x) => Floor1.fromJson(x))),
        floor2:
            List<Floor1>.from(json["floor2"].map((x) => Floor1.fromJson(x))),
        floor3:
            List<Floor1>.from(json["floor3"].map((x) => Floor1.fromJson(x))),
        saoma: AdvertesPicture.fromJson(json["saoma"]),
        newUser: AdvertesPicture.fromJson(json["newUser"]),
        floor1Pic: AdvertesPicture.fromJson(json["floor1Pic"]),
        floor2Pic: AdvertesPicture.fromJson(json["floor2Pic"]),
        floorName: FloorName.fromJson(json["floorName"]),
        category: List<Category>.from(
            json["category"].map((x) => Category.fromJson(x))),
        floor3Pic: AdvertesPicture.fromJson(json["floor3Pic"]),
        reservationGoods:
            List<dynamic>.from(json["reservationGoods"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "slides": List<dynamic>.from(slides.map((x) => x.toJson())),
        "shopInfo": shopInfo.toJson(),
        "integralMallPic": integralMallPic.toJson(),
        "toShareCode": toShareCode.toJson(),
        "recommend": List<dynamic>.from(recommend.map((x) => x.toJson())),
        "advertesPicture": advertesPicture.toJson(),
        "floor1": List<dynamic>.from(floor1.map((x) => x.toJson())),
        "floor2": List<dynamic>.from(floor2.map((x) => x.toJson())),
        "floor3": List<dynamic>.from(floor3.map((x) => x.toJson())),
        "saoma": saoma.toJson(),
        "newUser": newUser.toJson(),
        "floor1Pic": floor1Pic.toJson(),
        "floor2Pic": floor2Pic.toJson(),
        "floorName": floorName.toJson(),
        "category": List<dynamic>.from(category.map((x) => x.toJson())),
        "floor3Pic": floor3Pic.toJson(),
        "reservationGoods": List<dynamic>.from(reservationGoods.map((x) => x)),
      };
}

class AdvertesPicture {
  AdvertesPicture({
    this.pictureAddress,
    this.toPlace,
  });

  String pictureAddress;
  String toPlace;

  factory AdvertesPicture.fromJson(Map<String, dynamic> json) =>
      AdvertesPicture(
        pictureAddress: json["PICTURE_ADDRESS"],
        toPlace: json["TO_PLACE"],
      );

  Map<String, dynamic> toJson() => {
        "PICTURE_ADDRESS": pictureAddress,
        "TO_PLACE": toPlace,
      };
}

class Category {
  Category({
    this.mallCategoryId,
    this.mallCategoryName,
    this.bxMallSubDto,
    this.comments,
    this.image,
  });

  String mallCategoryId;
  String mallCategoryName;
  List<BxMallSubDto> bxMallSubDto;
  dynamic comments;
  String image;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        mallCategoryId: json["mallCategoryId"],
        mallCategoryName: json["mallCategoryName"],
        bxMallSubDto: List<BxMallSubDto>.from(
            json["bxMallSubDto"].map((x) => BxMallSubDto.fromJson(x))),
        comments: json["comments"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "mallCategoryId": mallCategoryId,
        "mallCategoryName": mallCategoryName,
        "bxMallSubDto": List<dynamic>.from(bxMallSubDto.map((x) => x.toJson())),
        "comments": comments,
        "image": image,
      };
}

class BxMallSubDto {
  BxMallSubDto({
    this.mallSubId,
    this.mallCategoryId,
    this.mallSubName,
    this.comments,
  });

  String mallSubId;
  String mallCategoryId;
  String mallSubName;
  String comments;

  factory BxMallSubDto.fromJson(Map<String, dynamic> json) => BxMallSubDto(
        mallSubId: json["mallSubId"],
        mallCategoryId: json["mallCategoryId"],
        mallSubName: json["mallSubName"],
        comments: json["comments"] == null ? null : json["comments"],
      );

  Map<String, dynamic> toJson() => {
        "mallSubId": mallSubId,
        "mallCategoryId": mallCategoryId,
        "mallSubName": mallSubName,
        "comments": comments == null ? null : comments,
      };
}

class Floor1 {
  Floor1({
    this.image,
    this.goodsId,
  });

  String image;
  String goodsId;

  factory Floor1.fromJson(Map<String, dynamic> json) => Floor1(
        image: json["image"],
        goodsId: json["goodsId"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "goodsId": goodsId,
      };
}

class FloorName {
  FloorName({
    this.floor1,
    this.floor2,
    this.floor3,
  });

  String floor1;
  String floor2;
  String floor3;

  factory FloorName.fromJson(Map<String, dynamic> json) => FloorName(
        floor1: json["floor1"],
        floor2: json["floor2"],
        floor3: json["floor3"],
      );

  Map<String, dynamic> toJson() => {
        "floor1": floor1,
        "floor2": floor2,
        "floor3": floor3,
      };
}

class Recommend {
  Recommend({
    this.image,
    this.mallPrice,
    this.goodsName,
    this.goodsId,
    this.price,
  });

  String image;
  double mallPrice;
  String goodsName;
  String goodsId;
  double price;

  factory Recommend.fromJson(Map<String, dynamic> json) => Recommend(
        image: json["image"],
        mallPrice: json["mallPrice"],
        goodsName: json["goodsName"],
        goodsId: json["goodsId"],
        price: json["price"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "mallPrice": mallPrice,
        "goodsName": goodsName,
        "goodsId": goodsId,
        "price": price,
      };
}

class ShopInfo {
  ShopInfo({
    this.leaderImage,
    this.leaderPhone,
  });

  String leaderImage;
  String leaderPhone;

  factory ShopInfo.fromJson(Map<String, dynamic> json) => ShopInfo(
        leaderImage: json["leaderImage"],
        leaderPhone: json["leaderPhone"],
      );

  Map<String, dynamic> toJson() => {
        "leaderImage": leaderImage,
        "leaderPhone": leaderPhone,
      };
}
