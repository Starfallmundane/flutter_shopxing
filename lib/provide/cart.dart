import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopxing/model/cartInfo.dart';

class CartProvide extends ChangeNotifier {
  static const String KEY_CART = "cartData";
  List<CartInfoMode> cartList = []; //商品列表对象
  double allPrice = 0; //总价格
  int allGoodsCount = 0; //商品总数量
  bool isAllCheck = true; //是否全选

  //添加某一个商品
  save(goodsId, goodsName, count, price, images) async {
    CartInfoMode newCartInfoMode = CartInfoMode();
    newCartInfoMode.goodsId = goodsId;
    newCartInfoMode.goodsName = goodsName;
    newCartInfoMode.count = count;
    newCartInfoMode.price = price;
    newCartInfoMode.images = images;
    newCartInfoMode.isCheck = true;

    SharedPreferences sp = await SharedPreferences.getInstance();
    var tempList = sp.getString(KEY_CART);
    allGoodsCount = 0;
    allPrice = 0;
    bool isHas = false;
    if (tempList == null) {
      cartList = [];
    } else {
      cartList = hotBeanFromJson(tempList);
      cartList.forEach((item) {
        if (item.goodsId == goodsId) {
          item.count++;
          isHas = true;
        }
        //计算集合已有的总数量和总金额
        if (item.isCheck) {
          allGoodsCount += item.count;
          allPrice += item.count * item.price;
        }
      });
    }
    if (!isHas) {
      cartList.add(newCartInfoMode);
      //添加新增商品的数量和金额
      if (newCartInfoMode.isCheck) {
        allGoodsCount = allGoodsCount + newCartInfoMode.count;
        allPrice += newCartInfoMode.count * newCartInfoMode.price;
      }
    }
    print("33----${cartList.length}");
    sp.setString(KEY_CART, json.encode(cartList).toString());
    notifyListeners();
  }

  //获取所有商品
  getCartInfo() async {
    allGoodsCount = 0;
    allPrice = 0;
    SharedPreferences sp = await SharedPreferences.getInstance();
    var tempList = sp.getString(KEY_CART);
    if (tempList == null) {
      cartList = [];
    } else {
      isAllCheck = true;
      cartList = hotBeanFromJson(tempList);
      cartList.forEach((item) {
        if (item.isCheck) {
          allGoodsCount += item.count;
          allPrice += item.count * item.price;
        } else {
          isAllCheck = false;
        }
      });
    }
    notifyListeners();
  }

  //删除全部商品
  clearAll() async {
    allGoodsCount = 0;
    allPrice = 0;
    isAllCheck = false;
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove(KEY_CART);
    await getCartInfo();
  }

  //删除摸一个商品
  void deleteOne(String goodsId) async {
    int tempIndex = 0;
    int delIndex = 0;
    cartList.forEach((item) {
      if (item.goodsId == goodsId) {
        delIndex = tempIndex;
      }
      tempIndex++;
    });
    cartList.removeAt(delIndex);
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(KEY_CART, json.encode(cartList).toString());
    await getCartInfo();
  }

  //设置单个商品选中状态
  void changeCheckState(CartInfoMode newCartInfoMode) async {
    cartList.forEach((item) {
      if (item.goodsId == newCartInfoMode.goodsId) {
        item = newCartInfoMode;
      }
    });
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(KEY_CART, json.encode(cartList).toString());
    await getCartInfo();
  }

  //设置全部商品选中状态
  void changeAllCheckBtnState(bool isSelect) async {
    isAllCheck = isSelect;
    allGoodsCount = 0;
    allPrice = 0;
    cartList.forEach((item) {
      item.isCheck = isSelect;
      print("${item.isCheck}");
      if (item.isCheck) {
        allGoodsCount += (item.count);
        allPrice += (item.count * item.price);
      }
    });

    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(KEY_CART, json.encode(cartList).toString());
    notifyListeners();
  }

  addOrReduceAction(CartInfoMode newCartInfoMode, bool todo) async {
    cartList.forEach((item) {
      if (item.goodsId == newCartInfoMode.goodsId) {
        if (todo) {
          item.count++;
        } else {
          if (item.count > 1) {
            item.count--;
          }
        }
      }
    });
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(KEY_CART, json.encode(cartList).toString());
    await getCartInfo();
  }
}
