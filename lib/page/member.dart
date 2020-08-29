import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: <Widget>[
      MySliverAppBar(),
      // 这个部件一般用于最后填充用的，会占有一个屏幕的高度，
      // 可以在 child 属性加入需要展示的部件
      SliverFillRemaining(
        child: ContentView(),
      ),
    ]));
  }
}

class MySliverAppBar extends StatelessWidget {
  const MySliverAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text('会员中心'),
      centerTitle: true,
      // 展开的高度
      expandedHeight: 300.0,
      // 强制显示阴影
      forceElevated: true,
      // 设置该属性，当有下滑手势的时候，就会显示 AppBar
//        floating: true,
      // 该属性只有在 floating 为 true 的情况下使用，不然会报错
      // 当上滑到一定的比例，会自动把 AppBar 收缩（不知道是不是 bug，当 AppBar 下面的部件没有被 AppBar 覆盖的时候，不会自动收缩）
      // 当下滑到一定比例，会自动把 AppBar 展开
//        snap: true,
      // 设置该属性使 Appbar 折叠后不消失
      pinned: true,
      // 通过这个属性设置 AppBar 的背景
      flexibleSpace: FlexibleSpaceBar(
//          title: Text('Expanded Title'),
        // 背景折叠动画
        collapseMode: CollapseMode.parallax,
        background: HeaderView(),
      ),
    );
  }
}

//头布局
class HeaderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
            'http://pic5.nipic.com/20091230/3655316_091215123447_2.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ClipOval(
                child: Image.network(
                  'http://img.mm4000.com/file/5/d2/172c33ddfc_1044.jpg',
                  fit: BoxFit.cover,
                  width: 120,
                  height: 120,
                ),
              ),
              Text(
                '嘻嘻',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//内容部分
class ContentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getAllOrder(),
        getOrderType(),
        getMemberType(),
      ],
    );
  }

  Widget getAllOrder() {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                top: BorderSide(color: Colors.black12, width: 15.h),
                bottom: BorderSide(color: Colors.black12, width: 15.h))),
        child: ListTile(
            leading: Icon(Icons.menu),
            title: Text("我的订单", style: TextStyle(fontSize: 36.0.sp)),
            trailing: Icon(Icons.arrow_forward_ios)));
  }

  Widget getOrderType() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(color: Colors.black12, width: 15.h))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          getOrderOneTypeText("待付款", Icons.party_mode),
          getOrderOneTypeText("待发货", Icons.query_builder),
          getOrderOneTypeText("待收货", Icons.directions_car),
          getOrderOneTypeText("待评价", Icons.content_paste),
        ],
      ),
    );
  }

  Widget getOrderOneTypeText(String name, IconData content_paste) {
    return Container(
        width: ScreenUtil.screenWidth / 4,
        padding: EdgeInsets.all(10),
        color: Colors.white,
        child: Column(
          children: [
            Icon(content_paste),
            Text(
              name,
              style: TextStyle(fontSize: 32.sp, color: Colors.black),
            ),
          ],
        ));
  }

  Widget getMemberType() {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            getMemberOneTypeText("1.领取优惠券"),
            getMemberOneTypeText("2.已领取优惠券"),
            getMemberOneTypeText("3.地址管理"),
            getMemberOneTypeText("4.客服电话"),
            getMemberOneTypeText("5.关于我们"),
            getMemberOneTypeText("6.帮助中心"),

            getMemberOneTypeText("1.领取优惠券"),
            getMemberOneTypeText("2.已领取优惠券"),
            getMemberOneTypeText("3.地址管理"),
            getMemberOneTypeText("4.客服电话"),
            getMemberOneTypeText("5.关于我们"),
            getMemberOneTypeText("6.帮助中心"),
            getMemberOneTypeText("1.领取优惠券"),
            getMemberOneTypeText("2.已领取优惠券"),
            getMemberOneTypeText("3.地址管理"),
            getMemberOneTypeText("4.客服电话"),
            getMemberOneTypeText("5.关于我们"),
            getMemberOneTypeText("6.帮助中心"),
          ],
        ),
      ),
    );
  }

  Widget getMemberOneTypeText(String title) {
    return ListTile(
      leading: Icon(Icons.save),
      title: Text(
        title,
        style: TextStyle(fontSize: 32.sp, color: Colors.black),
      ),
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}
