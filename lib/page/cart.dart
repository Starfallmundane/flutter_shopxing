import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:shopxing/model/cartInfo.dart';
import 'package:shopxing/page/car/cart_bottom.dart';
import 'package:shopxing/page/car/cart_item.dart';
import 'package:shopxing/provide/cart.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("购物车"), actions: <Widget>[
          InkWell(
            onTap: ()  async{
              await Provide.value<CartProvide>(context).clearAll();
            },
              child: Container(
            padding: EdgeInsets.all(20),
            child: Icon(Icons.clear),
          ))
        ]),
        body: FutureBuilder(
          future: _getCartInfo(context),
          builder: (context, snapshot) {
            print("${snapshot.data}");
            if (snapshot.hasData) {
              return Stack(
                children: [
                  Provide<CartProvide>(builder: (context, child, data) {
                    return ListView.builder(
                        padding: EdgeInsets.only(bottom: 80.h),
                        itemCount: data.cartList.length,
                        itemBuilder: ((BuildContext context, int index) {
                          return CartItem(data.cartList[index]);
                        }));
                  }),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: CartBottom(),
                  )
                ],
              );
            } else {
              return Text("购物车数据加载中……");
            }
          },
        ));
  }

  Future _getCartInfo(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCartInfo();
    return "success";
  }
}
