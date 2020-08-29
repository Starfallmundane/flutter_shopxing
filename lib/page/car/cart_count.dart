import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:shopxing/model/cartInfo.dart';
import 'package:shopxing/provide/cart.dart';

class CartCount extends StatelessWidget {

  CartInfoMode cartInfoMode;

  CartCount(this.cartInfoMode);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      height: 60.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _reduceBtn(context),
          _countArea(),
          _addBtn(context),
        ],
      ),
    );
  }

  Widget _reduceBtn(BuildContext context) {
    return InkWell(
      onTap: (){
        if(cartInfoMode.count>1) {
          Provide.value<CartProvide>(context).addOrReduceAction(
              cartInfoMode, false);
        }
      },
      child: Container(
          alignment: Alignment.center,
          width: 50.w,
          height: 50.w,
          decoration: BoxDecoration(
              color:cartInfoMode.count>1? Colors.white:Colors.black12,
              border: Border.all(color: Colors.black12, width: 1)),
          child: Text("—",style: TextStyle(color: cartInfoMode.count>1? Colors.black:Colors.black12),)),
    );
  }

  Widget _countArea() {
    return Container(
        alignment: Alignment.center,
        width: 80.w,
        height: 50.w,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black12, width: 1)),
        child: Text("${cartInfoMode.count}"));
  }

  Widget _addBtn(BuildContext context) {
    return InkWell(
      onTap: (){
        Provide.value<CartProvide>(context).addOrReduceAction(cartInfoMode, true);
      },
      child: Container(
          alignment: Alignment.center,
          width: 50.w,
          height: 50.w,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black12, width: 1)),
          child: Text("+")),
    );
  }
}
