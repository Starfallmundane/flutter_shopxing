// To parse this JSON data, do
//
//     final hotBean = hotBeanFromJson(jsonString);


import 'dart:convert';

List<HotBean> hotBeanFromJson(String str) => List<HotBean>.from(json.decode(str).map((x) => HotBean.fromJson(x)));

String hotBeanToJson(List<HotBean> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HotBean {
  HotBean({
    this.name,
    this.image,
    this.mallPrice,
    this.goodsId,
    this.price,
  });

  String name;
  String image;
  double mallPrice;
  String goodsId;
  double price;

  factory HotBean.fromJson(Map<String, dynamic> json) => HotBean(
    name: json["name"],
    image: json["image"],
    mallPrice: json["mallPrice"].toDouble(),
    goodsId: json["goodsId"],
    price: json["price"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
    "mallPrice": mallPrice,
    "goodsId": goodsId,
    "price": price,
  };
}
