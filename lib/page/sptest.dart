import 'package:flutter/material.dart';
import 'package:shopxing/utils/sp_utils.dart';

class SpTextPage extends StatefulWidget {

  @override
  _SpTextPageState createState() => _SpTextPageState();
}

class _SpTextPageState extends State<SpTextPage> {
  String data;
  List<String> dataList;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Column(
        children: [
          Text("购物车"),
          Row(
            children: [
              RaisedButton(
                child: Text("增加"),
                onPressed: () {
                  SPUtil.save(SPUtil.KEY_ACCOUNT, "小小");
                },
              ),
              RaisedButton(
                child: Text("删除"),
                onPressed: () {
                  SPUtil.delete(SPUtil.KEY_ACCOUNT);
                },
              ),
              RaisedButton(
                child: Text("显示"),
                onPressed: () {
                  setState(() {
                    SPUtil.get(SPUtil.KEY_ACCOUNT).then((value) => data=value  );
                  });
                },
              ),
            ],
          ),
          Text("数据：$data"),

          Row(
            children: [
              RaisedButton(
                child: Text("增加"),
                onPressed: () {
                  SPUtil.saveList(SPUtil.KEY_LIST, "小小");
                },
              ),
              RaisedButton(
                child: Text("删除"),
                onPressed: () {
                  SPUtil.delete(SPUtil.KEY_LIST);
                },
              ),
              RaisedButton(
                child: Text("显示"),
                onPressed: () {
                  setState(() {
                    SPUtil.getList(SPUtil.KEY_LIST).then((value) => dataList=value  );
                  });
                },
              ),
            ],
          ),
          Text("数据：${dataList.toString()}"),
        ],
      )),
    );
  }
}
