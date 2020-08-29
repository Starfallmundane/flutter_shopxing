import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:shopxing/page/details/detail_topinfo.dart';
import 'package:shopxing/page/details/detail_explain.dart';
import 'package:shopxing/page/details/detail_bar.dart';
import 'package:shopxing/page/details/detail_web.dart';
import 'package:shopxing/page/details/details_bottom.dart';
import 'package:shopxing/provide/good_details.dart';

class DetailsPage extends StatelessWidget {
  static String routeName = '/detail';

  final String goodId;

  DetailsPage(this.goodId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("商品详情"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
          future: _getDetailData(context),
          builder: (context, snapshot) {
            print("商品数据-----${snapshot.hasData}---${snapshot.data}");
            if (snapshot.hasData) {
              return Stack(
                children: <Widget>[
                  ListView(children: [
                    DetailsTopInfo(),
                    DetailsExplain(),
                    DetailsBar(),
                    DetailsWeb(),
                    SizedBox(height: 80.h,),
                  ]),
                  Positioned(bottom:0,child: DetailsBottom()),
                ],
              );
            } else {
              return Center(child: Text("商品详情加载中……$goodId"));
            }
          }),
    );
  }

  Future _getDetailData(BuildContext context) async {
    await Provide.value<DetailsInfoProvide>(context).getGoodDetailData(goodId);
    return "success";
  }
}
