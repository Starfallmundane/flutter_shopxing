import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provide/provide.dart';
import 'package:shopxing/provide/good_details.dart';

class DetailsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(builder: (context, child, val) {
      bool isLeft = Provide.value<DetailsInfoProvide>(context).isLeft;
      bool isRight = Provide.value<DetailsInfoProvide>(context).isRight;
      return Container(
          child: isLeft ? getHtml(context) : getComment(context),
      );
    });
  }

  Widget getHtml(BuildContext context) {
    String goodsDetails = Provide.value<DetailsInfoProvide>(context).goodDetailBean.goodInfo.goodsDetail;
    return Container(
      child: Html(
          data: goodsDetails
      ),
    );
  }

  Widget getComment(BuildContext context) {
    return Text("暂无评论");
  }
  
}
