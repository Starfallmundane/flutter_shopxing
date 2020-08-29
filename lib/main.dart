import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provide/provide.dart';
import 'package:shopxing/page/index.dart';
import 'package:shopxing/provide/cart.dart';
import 'package:shopxing/provide/category_goods.dart';
import 'package:shopxing/provide/current_index.dart';
import 'package:shopxing/provide/good_details.dart';
import 'package:shopxing/routes/application.dart';
import 'package:shopxing/routes/routes.dart';

import 'provide/category_child.dart';

void main() {
  var providers = Providers();
  var categoryTitleProvide = CategoryTitleProvide();
  var categoryGoodProvide = CategoryGoodProvide();
  var detailsInfoProvide = DetailsInfoProvide();
  var cartProvide = CartProvide();
  var currentIndexProvide = CurrentIndexProvide();
  providers
    ..provide(Provider<CategoryTitleProvide>.value(categoryTitleProvide))
    ..provide(Provider<CategoryGoodProvide>.value(categoryGoodProvide))
    ..provide(Provider<DetailsInfoProvide>.value(detailsInfoProvide))
    ..provide(Provider<CartProvide>.value(cartProvide))
    ..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide));

  runApp(
    ProviderNode(
      providers: providers,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final router = Router();
    Routes.defineRoutes(router);
    Application.router=router;
    
    return MaterialApp(
      title: '星星商城',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Application.router.generator,
      theme: ThemeData(
        primaryColor: Colors.pink,
      ),
      home: MyIndexPage(),
    );
  }
}
