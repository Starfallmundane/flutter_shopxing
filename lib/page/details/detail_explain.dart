import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsExplain extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border:
          Border(bottom: BorderSide(width: 20.h, color: Colors.black12))
      ),
      padding: EdgeInsets.only(left: 25.w,bottom: 20.h,top: 20.h),
      child: Text(
        "说明：> 极速送达  >  正品保证",
        style: TextStyle(fontSize: 30.sp, color: Colors.pink),
      ),
    );;
  }
}
