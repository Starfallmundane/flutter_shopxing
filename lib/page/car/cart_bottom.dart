import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:shopxing/provide/cart.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        width: 750.w,
        height: 80.h,
        child: Provide<CartProvide>(
            builder: (context, child, childCategory) {
             return Row(
                children: [
                  selectAllBtn(context),
                  allPriceArea(context),
                  goButton(context),
                ],
              );
            }),
    );
  }

  Widget selectAllBtn(BuildContext context) {
  bool isAllCheck=  Provide.value<CartProvide>(context).isAllCheck;
    return Container(
      width: 200.w,
      height: 80.h,
      child: Row(
        children: [
          Checkbox(
            value: isAllCheck,
            activeColor: Colors.pink,
            onChanged: (val) {
              Provide.value<CartProvide>(context).changeAllCheckBtnState(val);
            },
          ),
          Text(
            "全选",
            style: TextStyle(color: Colors.black, fontSize: 30.sp),
          ),
        ],
      ),
    );
  }

  Widget allPriceArea(BuildContext context) {
  var allPrice=  Provide.value<CartProvide>(context).allPrice;
  print("商品总价----${allPrice}");
    return Container(
        width: 400.w,
        height: 80.h,
        padding: EdgeInsets.only(right: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "合计:",
                  style: TextStyle(color: Colors.black, fontSize: 36.sp),
                ),
                Text(
                  "￥${allPrice}",
                  style: TextStyle(color: Colors.red, fontSize: 36.sp),
                ),
              ],
            ),
            Text(
              "满10元免配送费，预购免配送费",
              style: TextStyle(color: Colors.black38, fontSize: 23.sp),
            ),
          ],
        ));
  }

  Widget goButton(BuildContext context) {
    var allGoodsCount=  Provide.value<CartProvide>(context).allGoodsCount;
    return Container(
        alignment: Alignment.center,
        width: 150.w,
        height: 80.h,
        decoration: BoxDecoration(
            color: Colors.pinkAccent, borderRadius: BorderRadius.circular(5)),
        child: Text(
          "结算(${allGoodsCount})",
          style: TextStyle(color: Colors.white, fontSize: 35.sp),
        ));
  }
}
