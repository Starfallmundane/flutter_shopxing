import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shopxing/model/base_response.dart';
import 'package:shopxing/model/details.dart';
import 'package:shopxing/service/service_mothod.dart';

class DetailsInfoProvide extends ChangeNotifier {
  GoodDetailBean goodDetailBean = null;
  bool isLeft=true;
  bool isRight=false;

  getGoodDetailData(String id) async {
    print("商品详情ID-------$id");
    FormData formData = FormData.fromMap({'goodId': id,});
    await request(9, 'getGoodDetailById', formData: formData).then((val) {
      var jsonString = json.decode(val.toString());
      BaseResponse baseResponse = BaseResponse.fromJson(jsonString);
      if (baseResponse.code != "0") {
        return Text("空数据");
      } else {
         goodDetailBean = GoodDetailBean.fromJson(baseResponse.data);
        print("商品详情数据-5-${goodDetailBean.goodInfo.goodsName}");
      }
      notifyListeners();
    });
  }

  setGoodBar(bool isLeft){
    this.isLeft=isLeft;
    this.isRight=!isLeft;
    notifyListeners();
  }

}
