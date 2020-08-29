import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:shopxing/page/details.dart';

class Routes {


  static void defineRoutes(Router router) {
    router.notFoundHandler= new Handler(
        handlerFunc: (BuildContext context,Map<String,List<String>> params){
          print('ERROR====>ROUTE WAS NOT FONUND!!!');
          return Text("异常界面");
        }
    );

    var detailsHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          return DetailsPage(params["id"][0]);
        });

    router.define(DetailsPage.routeName, handler: detailsHandler);
  }

  //详情页面
//  var detailsHandler = Handler(
//      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
//        return DetailsPage(params["id"][0]);
//      });

//  Handler detailsHandler2 =Handler(
//      handlerFunc: (BuildContext context,Map<String,List<String>> params){
//        String goodsId = params['id'].first;
//        print('index>details goodsID is ${goodsId}');
//        return DetailsPage(goodsId);
//
//      }
//  );
}