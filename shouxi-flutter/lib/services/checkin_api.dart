import 'package:shouxi/constant/api-constant.dart';
import 'package:shouxi/utils/request.dart';

class CheckInService {

  /// 签到
  static Future<void> checkIn() async {
    await dioRequest.post(ApiConstant.SIGN_IN_URI);
  }

  /// 获取月份签到记录
  static Future<List<String>> getCheckInRecord() async {
    final response = await dioRequest.get(ApiConstant.QUERY_SIGN_IN_RECORD_URI);
    // 转为 List<String>
    List<String> checkInRecord = List<String>.from(response.data);
    return checkInRecord;
  }

  /// 获取今天签到信息
  static Future<bool> getTodayCheckInInfo() async {
    final response = await dioRequest.get(ApiConstant.QUERY_TODAY_SIGN_IN_URI);
    return response as bool;
  }
}