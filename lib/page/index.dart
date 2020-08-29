import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:shopxing/page/cart.dart';
import 'package:shopxing/page/category.dart';
import 'package:shopxing/page/home.dart';
import 'package:shopxing/page/member.dart';
import 'package:shopxing/provide/current_index.dart';

class MyIndexPage extends StatelessWidget {
  List<BottomNavigationBarItem> itemList = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      title: Text(
        "首页",
      ),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      title: Text(
        "分类",
      ),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.shopping_cart),
      title: Text(
        "购物车",
      ),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.profile_circled),
      title: Text(
        "会员中心",
      ),
    ),
  ];

  final List<Widget> bodyList = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    return Provide<CurrentIndexProvide>(builder: (context, child, val) {
      int _currentIndex =
          Provide.value<CurrentIndexProvide>(context).currentIndex;
      return Scaffold(
        backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
        body: IndexedStack(
          index: _currentIndex,
          children: bodyList,
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            Provide.value<CurrentIndexProvide>(context).changeIndex(index);
          },
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          items: itemList,
        ),
      );
    });
  }
}
