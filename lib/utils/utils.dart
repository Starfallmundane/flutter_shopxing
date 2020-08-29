

//打电话
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopUtils{

  static launchURL(String phone) async{
    print("==========打电话");
    String url = 'tel:'+phone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  
}

