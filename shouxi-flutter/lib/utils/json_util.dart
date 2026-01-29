
import '../constant/api-constant.dart';

class JsonResParseUtil {
  /// 通用 JSON 解析函数
  /// 参数1: 模型类的 fromJson 构造函数 (如 GoodsDetailItems.fromJson)
  /// 参数2: 包含数据的 map (如 response[HttpConstant.RESULT_FIELD_DATA])
  /// 返回值: 解析后的模型对象
  static T parseJsonData<T>(
      T Function(Map<String, dynamic> json) fromJsonFunc,
      dynamic jsonData,
      ) {
    return fromJsonFunc(jsonData);
  }

  /// 通用 JSON 列表解析函数
  /// 参数1: 模型类的 fromJson 构造函数 (如 GoodsDetailItems.fromJson)
  /// 参数2: 包含数据的 map (如 response[HttpConstant.RESULT_FIELD_DATA])
  /// 返回值: 解析后的模型对象列表
  static List<T> parseJsonListData<T>(
      T Function(Map<String, dynamic> json) fromJsonFunc,
      dynamic jsonData,
      ) {
    return (jsonData as List<dynamic>)
        .map((e) => fromJsonFunc(e))
        .toList();
  }

}