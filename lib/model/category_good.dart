import 'dart:convert';

List<CategoryGoodBean> categoryGoodBeanFromJson(String str) => List<CategoryGoodBean>.from(json.decode(str).map((x) => CategoryGoodBean.fromJson(x)));

String categoryGoodBeanToJson(List<CategoryGoodBean> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryGoodBean {
  CategoryGoodBean({
    this.image,
    this.oriPrice,
    this.presentPrice,
    this.goodsName,
    this.goodsId,
  });

  String image;
  double oriPrice;
  double presentPrice;
  String goodsName;
  String goodsId;

  factory CategoryGoodBean.fromJson(Map<String, dynamic> json) => CategoryGoodBean(
    image: json["image"],
    oriPrice: json["oriPrice"].toDouble(),
    presentPrice: json["presentPrice"].toDouble(),
    goodsName: json["goodsName"],
    goodsId: json["goodsId"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "oriPrice": oriPrice,
    "presentPrice": presentPrice,
    "goodsName": goodsName,
    "goodsId": goodsId,
  };
}
