import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provide/provide.dart';
import 'package:shopxing/model/base_response.dart';
import 'package:shopxing/model/category.dart';
import 'package:shopxing/model/home.dart';
import 'package:shopxing/model/hot.dart';
import 'package:shopxing/page/details.dart';
import 'package:shopxing/provide/category_child.dart';
import 'package:shopxing/provide/current_index.dart';
import 'package:shopxing/routes/application.dart';
import 'package:shopxing/service/service_mothod.dart';
import 'package:shopxing/utils/utils.dart';

///  首页
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int _page = 1;
  List<HotBean> hotGoodsList = [];

  @override
  void initState() {
    super.initState();
    _requestHotData();
  }

  void _requestHotData() {
    FormData formPage = FormData.fromMap({'page': _page});
    request(2, 'homePageBelowConten', formData: formPage).then((val) {
      var jsonString = json.decode(val.toString());
      BaseResponse baseResponse = BaseResponse.fromJson(jsonString);
      if (baseResponse.code != "0") {
        return Text("火爆商品空数据");
      } else {
        setState(() {
          List<HotBean> newList =
              hotBeanFromJson(json.encode(baseResponse.data));
          if (_page == 1) {
            hotGoodsList = newList;
          } else {
            hotGoodsList.addAll(newList);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("111111111111111111---------build");
    FormData formData =
        FormData.fromMap({'lon': '115.02932', 'lat': '35.76189'});
    return Scaffold(
        backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
        appBar: AppBar(
          title: Text("星星生活"),
        ),
        body: FutureBuilder(
          future: request(1, 'homePageContext', formData: formData),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var jsonString = json.decode(snapshot.data.toString());
              BaseResponse baseResponse = BaseResponse.fromJson(jsonString);
              if (baseResponse.code != "0") {
                return Text("空数据");
              } else {
                HomeBean homeBean = HomeBean.fromJson(baseResponse.data);
                List<Floor1> swiperDataList = homeBean.slides;
                List<Category> navigatorList = homeBean.category;
                String adImage = homeBean.advertesPicture.pictureAddress;
                ShopInfo shopInfo = homeBean.shopInfo;
                List<Recommend> recommendList = homeBean.recommend;
                AdvertesPicture floor1Title = homeBean.floor1Pic;
                List<Floor1> floor1 = homeBean.floor1;
                AdvertesPicture floor2Title = homeBean.floor2Pic;
                List<Floor1> floor2 = homeBean.floor2;
                AdvertesPicture floor3Title = homeBean.floor3Pic;
                List<Floor1> floor3 = homeBean.floor3;
                return EasyRefresh(
                  header: BallPulseHeader(color: Colors.pink),
                  footer: BallPulseFooter(color: Colors.pink),
                  onRefresh: () async {
                    _page = 1;
                    _requestHotData();
                  },
                  onLoad: () async {
                    _page++;
                    _requestHotData();
                  },
                  child: ListView(
                    children: [
                      SwiperDiy(swiperDataList),
                      TopNavigator(navigatorList),
                      AdBanner(adImage),
                      LeaderPhone(shopInfo),
                      RecommendGoods(recommendList),
                      FloorTitle(floor1Title),
                      FloorContent(floor1),
                      FloorTitle(floor2Title),
                      FloorContent(floor2),
                      FloorTitle(floor3Title),
                      FloorContent(floor3),
                      HotGoods(hotGoodsList),
                    ],
                  ),
                );
              }
            } else {
              return Center(child: Text("加载中……"));
            }
          },
        ));
  }
}

//1.轮播图
class SwiperDiy extends StatelessWidget {
  List<Floor1> images;

  SwiperDiy(this.images);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 333.h,
      child: new Swiper(
        onTap: (index) {
          Application.router.navigateTo(
              context, "${DetailsPage.routeName}?id=${images[index].goodsId}",
              transition: TransitionType.fadeIn);
        },
        // 横向
        scrollDirection: Axis.horizontal,
        // 布局构建
        itemBuilder: (BuildContext context, int index) {
          return new Image.network(
            images[index].image,
            fit: BoxFit.fill,
          );
        },
        itemCount: images.length,
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

//2导航模块组件
class TopNavigator extends StatelessWidget {
  List<Category> navigatorList;

  TopNavigator(this.navigatorList);

  @override
  Widget build(BuildContext context) {
    navigatorList.removeRange(10, navigatorList.length);
    int navIndex = -1;
    return Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: 5.0),
        padding: EdgeInsets.all(3.0),
        height: 270.h,
        child: new GridView.count(
          physics: NeverScrollableScrollPhysics(),
          //禁止滑动
          crossAxisCount: 5,
          padding: const EdgeInsets.all(4.0),
          //主轴间隔
          mainAxisSpacing: 5.0,
          //横轴间隔
          crossAxisSpacing: 4.0,
          children: navigatorList.map((category) {
            navIndex++;
            return _gridViewItemUI(context, category, navIndex);
          }).toList(),
        ));
  }

  Widget _gridViewItemUI(
      BuildContext context, Category category, int navIndex) {
    return InkWell(
      onTap: () {
        _goCategory(context, navIndex, category.mallCategoryId);
      },
      child: Column(
        children: [
          Image.network(
            category.image,
            width: 95.w,
          ),
          Text(category.mallCategoryName),
        ],
      ),
    );
  }

  void _goCategory(
      BuildContext context, int navIndex, String mallCategoryId) async {
    request(2, 'getCategory').then((value) {
      var jsonString = json.decode(value.toString());
      BaseResponse baseResponse = BaseResponse.fromJson(jsonString);
      if (baseResponse.code != "0") {
        return Text("分类导航空数据");
      } else {
        Provide.value<CurrentIndexProvide>(context).changeIndex(1);
        List<CategoryBean> navList = categoryBeanFromJson(json.encode(baseResponse.data));
        Provide.value<CategoryTitleProvide>(context).changeCategory(navIndex, mallCategoryId);
        Provide.value<CategoryTitleProvide>(context).setCategoryTitleList(navList[navIndex].bxMallSubDto, mallCategoryId);
      }
    });
  }
}

//3.广告图
class AdBanner extends StatelessWidget {
  final String adImage;

  AdBanner(this.adImage);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5.0),
      color: Colors.white,
      child: Image.network(adImage),
    );
  }
}

//4.拨打电话图
class LeaderPhone extends StatelessWidget {
  final ShopInfo shopInfo;

  LeaderPhone(this.shopInfo);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => ShopUtils.launchURL(shopInfo.leaderPhone),
      child: Image.network(shopInfo.leaderImage),
    );
  }
}

//4.商品推荐
class RecommendGoods extends StatelessWidget {
  final List<Recommend> recommendList;

  RecommendGoods(this.recommendList);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[_titleWidget(), _recommedList(context)],
      ),
    );
  }

  //推荐商品标题
  _titleWidget() {
    return Container(
        padding: EdgeInsets.only(left: 15, top: 5, bottom: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Colors.black12))),
        alignment: Alignment.centerLeft,
        child:
            Text("商品推荐", style: TextStyle(fontSize: 16, color: Colors.pink)));
  }

  //推荐商品列表
  _recommedList(BuildContext context) {
    return Container(
      height: 310.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context, index) {
          return _recommendItem(recommend: recommendList[index]);
        },
      ),
    );
  }
}

class _recommendItem extends StatelessWidget {
  const _recommendItem({
    Key key,
    @required this.recommend,
  }) : super(key: key);

  final Recommend recommend;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(left: BorderSide(color: Colors.black12))),
      child: InkWell(
        onTap: () {
          Application.router.navigateTo(
              context, "${DetailsPage.routeName}?id=${recommend.goodsId}",
              transition: TransitionType.fadeIn);
        },
        child: Column(
          children: [
            Image.network(
              recommend.image,
              width: 240.w,
            ),
            Text(
              '￥${recommend.mallPrice}',
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
            Text(
              '￥${recommend.price}',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black38,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FloorTitle extends StatelessWidget {
  final AdvertesPicture floor1Title;

  FloorTitle(this.floor1Title);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5.0),
      color: Colors.white,
      child: Image.network(floor1Title.pictureAddress),
    );
  }
}

class FloorContent extends StatelessWidget {
  final List<Floor1> floor1;

  FloorContent(this.floor1);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          fisrstItem(context, floor1),
          secondItem(context, floor1),
        ],
      ),
    );
  }

  Widget fisrstItem(BuildContext context, List<Floor1> floor1) {
    return Row(
      children: [
        _goodsItem(context, floor1[0]),
        Column(
          children: [
            _goodsItem(context, floor1[1]),
            _goodsItem(context, floor1[2]),
          ],
        ),
      ],
    );
  }

  Widget secondItem(BuildContext context, List<Floor1> floor1) {
    return Row(
      children: [
        _goodsItem(context, floor1[3]),
        _goodsItem(context, floor1[4]),
      ],
    );
  }

  Widget _goodsItem(BuildContext context, Floor1 floor1) {
    return Container(
      width: ScreenUtil.screenWidth / 2,
      child: InkWell(
          onTap: () {
            Application.router.navigateTo(
                context, "${DetailsPage.routeName}?id=${floor1.goodsId}",
                transition: TransitionType.fadeIn);
          },
          child: Image.network(floor1.image)),
    );
  }
}

//火爆专区组合
class HotGoods extends StatelessWidget {
  final List<HotBean> hotGoodsList;

  HotGoods(this.hotGoodsList);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        _hotTitle(),
        _hotContent(context, hotGoodsList),
      ],
    ));
  }
}

//火爆专区标题
Widget _hotTitle() {
  return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(width: 0.5, color: Colors.black12))),
      child: Text(
        "火爆专区",
        style: TextStyle(fontSize: 16, color: Colors.black),
      ));
}

//火爆专区列表内容
Widget _hotContent(BuildContext context, List<HotBean> hotGoodsList) {
  List<Widget> listWidget = hotGoodsList.map((HotBean hotBean) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(
            context, "${DetailsPage.routeName}?id=${hotBean.goodsId}",
            transition: TransitionType.fadeIn);
      },
      child: Container(
//        width: 372.w,
          color: Colors.white,
          padding: EdgeInsets.all(5.0),
          margin: EdgeInsets.only(bottom: 3.0),
          width: ScreenUtil.screenWidth / 2 - 1,
          child: Column(
            children: [
              Image.network(hotBean.image),
              Text(
                hotBean.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, color: Colors.pink),
              ),
              Row(
                children: [
                  Text(
                    '￥${hotBean.mallPrice}',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  Text(
                    '￥${hotBean.price}',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black38,
                        decoration: TextDecoration.lineThrough),
                  ),
                ],
              ),
            ],
          )),
    );
  }).toList();
  return Wrap(
    spacing: 2,
    children: listWidget,
  );
}
