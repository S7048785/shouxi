import 'package:dio/dio.dart';
import 'package:shouxi/constant/api-constant.dart';
import 'package:shouxi/models/result.dart';
import 'package:shouxi/stores/user_store.dart';

import 'ToastUtil.dart';

class _DioRequest {
  /// dio请求对象
  final _dio = Dio();

  /// 配置基础地址和拦截器
  _DioRequest() {
    _dio.options
      ..baseUrl = HttpConstant.BASE_URL
      ..sendTimeout = Duration(seconds: HttpConstant.TIMEOUT)
      ..receiveTimeout = Duration(seconds: HttpConstant.TIMEOUT)
      ..connectTimeout = Duration(seconds: HttpConstant.TIMEOUT);

    _addInterceptors();
  }

  /// 添加拦截器
  void _addInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        // 请求拦截器
        onRequest: (request, handler) {
          String userId = UserStore.getUserId();
          if (UserStore.getUserId().isNotEmpty) {
            request.headers["user_id"] = userId;
          }
          print(
            "baseUrl: ${request.baseUrl}, url: ${request.path}, query: ${request.queryParameters}, body: ${request.data}",
          );
          // 目前无逻辑 放行所有请求
          return handler.next(request);
        },
        // 响应拦截器
        onResponse: (response, handler) {
          // 响应正常放行 否则拒绝
          if (response.statusCode! >= 200 && response.statusCode! < 300) {
            return handler.next(response);
          }
          return handler.reject(
            DioException(requestOptions: response.requestOptions),
          );
        },
        // 错误拦截器
        onError: (error, handler) {
          // 拒绝 所有错误
          return handler.reject(error);
        },
      ),
    );
  }

  /// get请求
  /// @param url 请求地址
  /// @param queryParameters 请求参数
  Future<Result> get(String url, {Map<String, dynamic>? params}) async {
    return await _handleResponse(_dio.get(url, queryParameters: params));
  }

  /// post请求
  Future<Result> post(String url, {Map<String, dynamic>? params}) async {
    return await _handleResponse(_dio.post(url, data: params));
  }

  /// put请求
  Future<Result> put(String url, {Map<String, dynamic>? params}) async {
    return await _handleResponse(_dio.put(url, data: params));
  }

  /// delete请求
  Future<Result> delete(String url, {Map<String, dynamic>? params}) async {
    return await _handleResponse(_dio.delete(url, data: params));
  }

  /// 异步处理返回结果
  /// @param task 异步任务处理响应
  Future<Result> _handleResponse(Future<Response<dynamic>> task) async {
    /// 等待返回结果
    Response<dynamic> res = await task;

    final data = res.data;
    print("res: ${data.toString()}");
    return Result(
      code: data[HttpConstant.RESULT_FIELD_CODE],
      data: data[HttpConstant.RESULT_FIELD_DATA],
      msg: data[HttpConstant.RESULT_FIELD_MSG],
    );
  }
}

/// 单例对象
final dioRequest = _DioRequest();
