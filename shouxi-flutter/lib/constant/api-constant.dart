class HttpConstant {
  // 基础地址
  static const String BASE_URL = 'http://192.168.1.103:8000';

  // 超时时间
  static const int TIMEOUT = 10;

  // 成功状态码
  static const String SUCCESS_CODE = "1";

  // 响应结果字段
  static const String RESULT_FIELD_CODE = "code";
  static const String RESULT_FIELD_MSG = "msg";
  static const String RESULT_FIELD_DATA = "data";
}


class ApiConstant {

  // 登录
  static const String LOGIN_URI = "/users/login";
  // 发送验证码
  static const String SEND_VERIFY_CODE_URI = "/users/send-code";
  // 获取当前用户信息
  static const String GET_CURRENT_USER_INFO_URI = "/users/";

  // 签到
  static const String SIGN_IN_URI = "/checkin/";
  // 查询某年某月的签到记录
  static const String QUERY_SIGN_IN_RECORD_URI = "/checkin/month";
  // 查询今天签到信息
  static const String QUERY_TODAY_SIGN_IN_URI = "/checkin/today";
  // 获取签到统计
  static const String GET_SIGN_IN_STATS_URI = "/checkin/stats";

  // 紧急联系人
  static const String EMERGENCY_CONTACT_URI = "/emergency-contacts/";
}


