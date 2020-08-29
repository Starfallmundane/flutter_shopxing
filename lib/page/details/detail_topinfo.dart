import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:shopxing/model/details.dart';
import 'package:shopxing/provide/good_details.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsTopInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GoodDetailBean goodDetailBean =
        Provide.value<DetailsInfoProvide>(context).goodDetailBean;

    return Container(
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 20.h, color: Colors.black12))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getGoodImage(goodDetailBean),
            getGoodName(goodDetailBean),
            getGoodNumb(goodDetailBean),
            getGoodPrice(goodDetailBean),
          ],
        ));
  }

  Widget getGoodImage(GoodDetailBean goodDetailBean) {
   return Image.network(goodDetailBean.goodInfo.image1);
  }

  Widget getGoodName(GoodDetailBean goodDetailBean) {
    return Container(
      padding: EdgeInsets.only(left: 25.w,bottom: 10.h),
      child: Text(
        goodDetailBean.goodInfo.goodsName,
        style: TextStyle(fontSize: 30.sp, color: Colors.black),
      ),
    );
  }

  Widget getGoodNumb(GoodDetailBean goodDetailBean) {
    return Container(
      padding: EdgeInsets.only(left: 25.w,bottom: 20.h),
      child: Text(
        "编号：" + goodDetailBean.goodInfo.goodsSerialNumber,
        style: TextStyle(fontSize: 30.sp, color: Colors.black38),
      ),
    );
  }

  Widget getGoodPrice(GoodDetailBean goodDetailBean) {
    return  Container(
      padding: EdgeInsets.only(left: 25.w,bottom: 20.h),
      child: Row(
        children: [
          Text(
            "￥${goodDetailBean.goodInfo.presentPrice}",
            style: TextStyle(fontSize: 40.sp, color: Colors.pink),
          ),
          Text(
            "市场价：￥${goodDetailBean.goodInfo.oriPrice}",
            style: TextStyle(
                fontSize: 30.sp,
                color: Colors.black38,
                decoration: TextDecoration.lineThrough),
          ),
        ],
      ),
    );
  }

}
