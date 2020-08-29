import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:shopxing/provide/cart.dart';
import 'package:shopxing/provide/current_index.dart';
import 'package:shopxing/provide/good_details.dart';

class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsInfo =
        Provide.value<DetailsInfoProvide>(context).goodDetailBean.goodInfo;
    var goodsID = goodsInfo.goodsId;
    var goodsName = goodsInfo.goodsName;
    var count = 1;
    var price = goodsInfo.presentPrice;
    var images = goodsInfo.image1;
    return Container(
      child: Row(
        children: [
          Container(
              alignment: Alignment.center,
              color: Colors.white,
              height: 80.h,
              width: ScreenUtil.screenWidth / 7,
              child: InkWell(
                onTap: (){
                  Provide.value<CurrentIndexProvide>(context).changeIndex(2);
                  Navigator.pop(context);
                },
                child: Stack(children: [
                  Container(
                      height: 80.h,
                      width: ScreenUtil.screenWidth / 7,
                      child: Icon(Icons.shopping_cart,
                          color: Colors.red, size: 60.w)),
                  Provide<CartProvide>(builder: (context, child, val) {
                    int allGoodsCount=Provide.value<CartProvide>(context).allGoodsCount;
                    return Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            border: Border.all(width: 2, color: Colors.white),
                            borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          "${allGoodsCount}",
                          style: TextStyle(fontSize: 28.sp, color: Colors.white),
                        ),
                      ),
                    );
                  }),
                ]),
              )),
          InkWell(
            onTap: () async {
              await Provide.value<CartProvide>(context)
                  .save(goodsID, goodsName, count, price, images);
            },
            child: Container(
                alignment: Alignment.center,
                color: Colors.green,
                height: 80.h,
                width: ScreenUtil.screenWidth * 3 / 7,
                child: Text(
                  "加入购物车",
                  style: TextStyle(fontSize: 35.sp, color: Colors.white),
                )),
          ),
          InkWell(
            onTap: () async {
              await Provide.value<CartProvide>(context).clearAll();
            },
            child: Container(
                alignment: Alignment.center,
                color: Colors.red,
                height: 80.h,
                width: ScreenUtil.screenWidth * 3 / 7,
                child: Text(
                  "马上购买",
                  style: TextStyle(fontSize: 35.sp, color: Colors.white),
                )),
          ),
        ],
      ),
    );
  }
}
