import 'package:flutter/material.dart';
import 'package:shopxing/model/category.dart';

class CategoryTitleProvide extends ChangeNotifier {
  List<BxMallSubDto> childList=[];

  int categoryIndex=0;    //大类索引
  int childIndex=0;
  String categoryId="4";
  String titleId=" ";
  int page=1;  //列表页数，当改变大类或者小类时进行改变
  String noMoreText = ''; //显示更多的表示

  void setCategoryTitleList(List<BxMallSubDto> newList,String newcategoryId) {
    page=1;
    childIndex=0;
    categoryId=newcategoryId;
    titleId='';
    noMoreText='';


    BxMallSubDto all=  BxMallSubDto();
    all.mallSubId="";
    all.mallCategoryId="0";
    all.mallSubName="全部";
    all.comments="null";
    childList=[all];
    childList.addAll(newList);
    notifyListeners();
  }


  //改变子类标题栏索引
  void setCategoryIndex(int newIndex,String newTitleId){
    childIndex=newIndex;
    titleId=newTitleId;
    page=1;
    noMoreText='';
    notifyListeners();
  }


  //增加Page的方法f
  addPage(){
    page++;
  }
  //改变noMoreText数据
  changeNoMore(String text){
    noMoreText=text;
    notifyListeners();
  }


//首页点击类别是更改类别
  changeCategory(int index,String id){
    categoryId=id;
    categoryIndex=index;
    titleId ='';
    notifyListeners();
  }
}