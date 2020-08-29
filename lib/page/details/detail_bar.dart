import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:shopxing/provide/good_details.dart';

class DetailsBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Provide进行刷新
    return Provide<DetailsInfoProvide>(builder: (context, child, val) {
      bool isLeft = Provide.value<DetailsInfoProvide>(context).isLeft;
      bool isRight = Provide.value<DetailsInfoProvide>(context).isRight;
      return Container(
        child: Row(
          children: [
            getHalfBar(context, 1, isLeft),
            getHalfBar(context, 2, isRight),
          ],
        ),
      );
    });
  }

  Widget getHalfBar(BuildContext context, int type, bool isSelect) {
    return InkWell(
      onTap: () {
        Provide.value<DetailsInfoProvide>(context)
            .setGoodBar(type == 1 ? true : false);
      },
      child: Container(
        width: ScreenUtil.screenWidth / 2,
        alignment: Alignment.center,
        padding: EdgeInsets.all(30.w),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    width: 3.h,
                    color: isSelect ? Colors.redAccent : Colors.black12))),
        child: Text(
          type == 1 ? "详细" : "评论",
          style: TextStyle(
              fontSize: 30.sp,
              color: isSelect ? Colors.redAccent : Colors.black),
        ),
      ),
    );
  }
}
