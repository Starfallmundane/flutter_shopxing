import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:shopxing/model/base_response.dart';
import 'package:shopxing/model/category.dart';
import 'package:shopxing/model/category_good.dart';
import 'package:shopxing/provide/category_child.dart';
import 'package:shopxing/provide/category_goods.dart';
import 'package:shopxing/routes/application.dart';
import 'package:shopxing/service/service_mothod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'details.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("商品分类"),
      ),
      body: Row(
        children: [
          LeftCategoryNav(), //左侧导航栏
          Column(
            children: [
              RightTitle(), //右侧顶部标题栏
              RightGood(), //右侧顶部商品列表
            ],
          ),
        ],
      ),
    );
  }
}

//1.左侧导航栏
class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List<CategoryBean> navList = [];
  List<CategoryGoodBean> goodList = [];
  int selectBigIndex = 0;

  @override
  void initState() {
    super.initState();
    _requestCategoryNav();
  }

  //网络请求左侧导航栏数据
  void _requestCategoryNav() {
    request(2, 'getCategory').then((value) {
      var jsonString = json.decode(value.toString());
      BaseResponse baseResponse = BaseResponse.fromJson(jsonString);
      if (baseResponse.code != "0") {
        return Text("分类导航空数据");
      } else {
        navList = categoryBeanFromJson(json.encode(baseResponse.data));
        Provide.value<CategoryTitleProvide>(context).setCategoryTitleList(navList[0].bxMallSubDto, '4');
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryTitleProvide>(builder: (context, child, val) {
      selectBigIndex = Provide.value<CategoryTitleProvide>(context).categoryIndex;
      print("xxxxxxxxxxxxxxx---${selectBigIndex}");
      _requestCategoryGoods1("");
      return Container(
        width: 190.w,
        child: ListView.builder(
            itemCount: navList.length,
            itemBuilder: (context, index) {
              return getNavItemWidget(index, navList[index]);
            }),
      );
    });
  }

  Widget getNavItemWidget(int index, CategoryBean categoryBean) {
    bool selectBig = (index == selectBigIndex) ? true : false;

    return InkWell(
      onTap: () {
        //Provide设置顶部标题列表数据
        Provide.value<CategoryTitleProvide>(context).setCategoryTitleList(
            categoryBean.bxMallSubDto, categoryBean.mallCategoryId);
        Provide.value<CategoryTitleProvide>(context).changeCategory(index,categoryBean.mallCategoryId);
        setState(() {
          selectBigIndex = index;
          //点击后刷新商品列表
          _requestCategoryGoods1("");
        });
      },
      child: Container(
          decoration: BoxDecoration(
              color:
                  selectBig ? Color.fromRGBO(236, 238, 239, 1.0) : Colors.white,
              border: Border(
                bottom: BorderSide(width: 1, color: Colors.black12),
              )),
          padding: EdgeInsets.all(15),
          child: Text(
            categoryBean.mallCategoryName,
            style: TextStyle(fontSize: 30.sp, color: Colors.black),
          )),
    );
  }

  //2.网络请求右侧商品列表数据
  void _requestCategoryGoods1(String titleId) {
    String categoryId = Provide.value<CategoryTitleProvide>(context).categoryId;
    print("titleId-----$categoryId---$titleId");
    FormData formData = FormData.fromMap({
      'categoryId': categoryId,
      'categorySubId': titleId,
      'page': 1
    });
    request(3, 'getMallGoods', formData: formData).then((value) {
      var jsonString = json.decode(value.toString());
      BaseResponse baseResponse = BaseResponse.fromJson(jsonString);
      if (baseResponse.code != "0") {
        return Text("商品列表空数据");
      } else {
        if (baseResponse.data == null) {
          Provide.value<CategoryGoodProvide>(context).setCategoryGoodList([]);
        } else {
          goodList = categoryGoodBeanFromJson(json.encode(baseResponse.data));
          //Provide设置商品列表数据
          Provide.value<CategoryGoodProvide>(context).setCategoryGoodList(goodList);
        }
      }
    });
  }
}

//2.右侧顶部标题栏
class RightTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 560.w,
      height: 80.h,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black12, width: 1)),
      child: Provide<CategoryTitleProvide>(
        builder: (context, child, categoryNavProvide) => Container(
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryNavProvide.childList.length,
              itemBuilder: (context, index) {
                return _getTitleItem(context, index, categoryNavProvide.childList[index]);
              }),
        ),
      ),
    );
  }

  Widget _getTitleItem(
      BuildContext context, int index, BxMallSubDto bxMallSubDto) {
    bool isCheck =
        (index == Provide.value<CategoryTitleProvide>(context).childIndex)
            ? true
            : false;
    return InkWell(
      onTap: () {
        Provide.value<CategoryTitleProvide>(context)
            .setCategoryIndex(index, bxMallSubDto.mallSubId);
        _requestCategoryGoods2(context, bxMallSubDto.mallSubId);
      },
      child: Container(
        color: Colors.white,
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Text(
          bxMallSubDto.mallSubName,
          style: TextStyle(
              fontSize: 30.sp, color: isCheck ? Colors.pink : Colors.black),
        ),
      ),
    );
  }

  //2.网络请求右侧商品列表数据
  void _requestCategoryGoods2(BuildContext context, String titleId) {
    String aa = Provide.value<CategoryTitleProvide>(context).categoryId;
    print("titleId-----$aa---$titleId");
    FormData formData = FormData.fromMap({
      'categoryId': Provide.value<CategoryTitleProvide>(context).categoryId,
      'categorySubId': titleId,
      'page': 1
    });
    request(3, 'getMallGoods', formData: formData).then((value) {
      var jsonString = json.decode(value.toString());
      BaseResponse baseResponse = BaseResponse.fromJson(jsonString);
      if (baseResponse.code != "0") {
        return Text("商品列表空数据");
      } else {
        if (baseResponse.data == null) {
          Provide.value<CategoryGoodProvide>(context).setCategoryGoodList([]);
        } else {
          List<CategoryGoodBean> goodList =
              categoryGoodBeanFromJson(json.encode(baseResponse.data));
          //Provide设置商品列表数据
          Provide.value<CategoryGoodProvide>(context)
              .setCategoryGoodList(goodList);
        }
      }
    });
  }
}

class RightGood extends StatefulWidget {
  @override
  _RightGoodState createState() => _RightGoodState();
}

class _RightGoodState extends State<RightGood> {
  var _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodProvide>(
        builder: (context, child, categoryGoodProvide) {
      try {
        if (Provide.value<CategoryTitleProvide>(context).page == 1) {
          print('回到顶部');
          _scrollController.jumpTo(0.0);
        }
      } catch (e) {
        print('进入页面第一次初始化：${e}');
      }

      if (categoryGoodProvide.goodList.length == 0) {
        return Expanded(child: Container(width: 560.w, child: Text("暂无数据")));
      } else {
        bool isNoMore =
            Provide.value<CategoryTitleProvide>(context).noMoreText ==
                "没有更多数据了";
        return Expanded(
          child: Container(
            width: 560.w,
            child: EasyRefresh(
              scrollController: _scrollController,
              header: BallPulseHeader(color: Colors.pink),
              footer: isNoMore ? null : BallPulseFooter(color: Colors.pink),
              onRefresh: () async {
                //刷新page=1
                Provide.value<CategoryTitleProvide>(context).page = 1;
                String titleId =
                    Provide.value<CategoryTitleProvide>(context).titleId;
                _requestCategoryGoods3(context, titleId, true);
              },
              onLoad: () async {
                if (!isNoMore) {
                  Provide.value<CategoryTitleProvide>(context).addPage();
                  String titleId =
                      Provide.value<CategoryTitleProvide>(context).titleId;
                  _requestCategoryGoods3(context, titleId, false);
                }
              },
              child: ListView.builder(
                  itemCount: categoryGoodProvide.goodList.length,
                  itemBuilder: (context, index) {
                    return GoodItem(
                        index: index, goodList: categoryGoodProvide.goodList);
                  }),
            ),
          ),
        );
      }
    });
  }

  //3.网络请求右侧商品列表数据
  void _requestCategoryGoods3(BuildContext context, String titleId, isRefresh) {
    String bigId = Provide.value<CategoryTitleProvide>(context).categoryId;
    int page = Provide.value<CategoryTitleProvide>(context).page;
    print("titleId-----$bigId---$titleId----$page");
    FormData formData = FormData.fromMap({
      'categoryId': Provide.value<CategoryTitleProvide>(context).categoryId,
      'categorySubId': titleId,
      'page': page
    });
    request(3, 'getMallGoods', formData: formData).then((value) {
      var jsonString = json.decode(value.toString());
      BaseResponse baseResponse = BaseResponse.fromJson(jsonString);
      if (baseResponse.code != "0") {
        return Text("商品列表空数据");
      } else {
        if (baseResponse.data == null) {
          if (isRefresh) {
            Provide.value<CategoryGoodProvide>(context).setCategoryGoodList([]);
          } else {
            Provide.value<CategoryTitleProvide>(context).noMoreText = "没有更多数据了";
            Fluttertoast.showToast(
                msg: "已经到底了，没有数据了",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        } else {
          List<CategoryGoodBean> goodList =
              categoryGoodBeanFromJson(json.encode(baseResponse.data));
          //Provide添加更多商品列表数据
          if (isRefresh) {
            Provide.value<CategoryGoodProvide>(context)
                .setCategoryGoodList(goodList);
          } else {
            Provide.value<CategoryGoodProvide>(context)
                .addCategoryGoodList(goodList);
          }
        }
      }
    });
  }
}

class GoodItem extends StatelessWidget {
  const GoodItem({
    Key key,
    @required this.index,
    @required this.goodList,
  }) : super(key: key);

  final int index;
  final List<CategoryGoodBean> goodList;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(
            context, "${DetailsPage.routeName}?id=${goodList[index].goodsId}",
            transition: TransitionType.fadeIn);
      },
      child: Container(
        padding: EdgeInsets.only(top: 5.w, bottom: 5.w),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(color: Colors.black12, width: 1),
                left: BorderSide(color: Colors.black12, width: 1))),
        child: Row(
          children: [
            Container(
                width: 200.w, child: Image.network(goodList[index].image)),
            Container(
              width: 355.w,
              padding: EdgeInsets.all(5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(5.w),
                    child: Text(
                      goodList[index].goodsName,
                      style: TextStyle(fontSize: 30.sp, color: Colors.black),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5.w),
                    child: Row(
                      children: [
                        Text(
                          "价格：￥${goodList[index].presentPrice}",
                          style: TextStyle(fontSize: 30.sp, color: Colors.pink),
                        ),
                        Text(
                          "￥${goodList[index].oriPrice}",
                          style: TextStyle(
                              fontSize: 30.sp,
                              color: Colors.black38,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
