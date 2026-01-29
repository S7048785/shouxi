import 'package:shared_preferences/shared_preferences.dart';

class UserStore {
  static String? id;

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    id = prefs.getString('user_id');
  }

  /// 判断是否登录
  static bool isLogged() {
    return id?.isNotEmpty ?? false;
  }

  static String getUserId() {
    return id ?? "";
  }

  static Future<void> setUserId(String userid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', userid);
    id = userid;
  }

  static Future<void> removeUserId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    id = null;
  }

}