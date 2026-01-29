import 'package:shouxi/constant/api-constant.dart';
import 'package:shouxi/stores/user_store.dart';
import 'package:shouxi/utils/ToastUtil.dart';
import 'package:shouxi/utils/request.dart';

class UserService {

  /// 发送邮件验证码
  static Future<void> sendCode(String email) async {
    final res = await dioRequest.post(ApiConstant.SEND_VERIFY_CODE_URI, params: {'email': email});
    if (res.code == 200) {
      ToastUtil.showText("验证码已发送");
    }
    return;
  }

  /// 登录
  /// return 用户id
  static Future<String> login(String email, String code) async {
      final response = await dioRequest.post(ApiConstant.LOGIN_URI, params: {
        'email': email,
        'code': code,
      });
      return response.data;
  }

  /// 登出
  static Future<void> logout() async {
    UserStore.removeUserId();
  }
}
