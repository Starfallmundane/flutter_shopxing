import 'package:flutter/material.dart';
import 'package:shopxing/model/category.dart';
import 'package:shopxing/model/category_good.dart';

class CategoryGoodProvide extends ChangeNotifier {
  List<CategoryGoodBean> goodList=[];

  void setCategoryGoodList(List<CategoryGoodBean> newList) {
    goodList=newList;
    notifyListeners();
  }

  void addCategoryGoodList(List<CategoryGoodBean> newList) {
    goodList.addAll(newList);
    notifyListeners();
  }
}