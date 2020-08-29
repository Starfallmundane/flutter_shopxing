

import 'package:dio/dio.dart';
import 'package:shopxing/config/service_url.dart';

Future request(type,url,{formData})async{
  try{
//    print('开始获取数据...............$type');
    Response response;
    Dio dio = new Dio();
    if(formData==null){
      response = await dio.post(servicePath[url]);
    }else{
      response = await dio.post(servicePath[url],data:formData);
    }
    if(response.statusCode==200){
//      print("11-$type-获取数据数据---${response.data}");
      return response.data;
    }else{
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  }catch(e){
    return print('ERROR:==$type====>${e}');
  }

}