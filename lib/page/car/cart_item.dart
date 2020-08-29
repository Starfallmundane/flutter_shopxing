import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:shopxing/model/cartInfo.dart';
import 'package:shopxing/page/car/cart_count.dart';
import 'package:shopxing/provide/cart.dart';

class CartItem extends StatelessWidget {
  final CartInfoMode cartInfoMode;

  CartItem(this.cartInfoMode);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.black12))),
          child: Row(
            children: [
              getCartCheck(context),
              getCartImage(),
              getCartInfo(cartInfoMode),
              getCartPrice(context),
            ],
          )),
    );
  }

  Widget getCartCheck(BuildContext context) {
    return Container(
        width: 120.w,
        child: Checkbox(
            activeColor: Colors.pink,
            value: cartInfoMode.isCheck,
            onChanged: (val) {
              cartInfoMode.isCheck = val;
              Provide.value<CartProvide>(context).changeCheckState(cartInfoMode);
            }));
  }

  Widget getCartImage() {
    return Container(
        margin: EdgeInsets.only(top: 25.h, bottom: 25.h),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black12, width: 1)),
        width: 150.w,
        height: ScreenUtil.screenWidth / 5,
        child: Image.network(cartInfoMode.images));
  }

  Widget getCartInfo(CartInfoMode cartInfoMode) {
    return Container(
        padding: EdgeInsets.only(left: 15.w),
        alignment: Alignment.topLeft,
        width: 330.w,
        height: ScreenUtil.screenWidth / 5,
        child: Column(
          children: [
            Text(
              cartInfoMode.goodsName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 30.sp, color: Colors.black),
            ),
            CartCount(cartInfoMode),
          ],
        ));
  }

  Widget getCartPrice(BuildContext context) {
    return Container(
        width: 150.w,
        color: Colors.white,
        height: ScreenUtil.screenWidth / 5 + 50.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("￥${cartInfoMode.price}",
                style: TextStyle(fontSize: 30.sp, color: Colors.black)),
            InkWell(
              onTap: (){
                Provide.value<CartProvide>(context).deleteOne(cartInfoMode.goodsId);
              },
              child: Container(
                child: Icon(
                  Icons.delete,
                  size: 60.w,
                  color: Colors.pink,
                ),
              ),
            )
          ],
        ));
  }
}
