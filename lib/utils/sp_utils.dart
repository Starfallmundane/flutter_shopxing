import 'package:shared_preferences/shared_preferences.dart';

class SPUtil {
  static const String KEY_ACCOUNT = "account";
  static const String KEY_LIST = "accountList";
  static List<String> list=[];

  // 异步保存
  static Future save(String key, String value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(key, value);
  }

  // 异步读取
  static Future<String> get(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(key);
  }

  // 异步删除
  static void delete(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove(key);
  }

  // 异步保存
  static Future saveList(String key, String value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    list.add(value);
    sp.setStringList(key, list);
  }

  // 异步读取
  static Future<List<String>> getList(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getStringList(key);
  }

  // 异步删除
  static void deleteList(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove(key);
  }
}
