import 'package:dio/dio.dart';
import 'package:taafe/shared/network/remote/end_points.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
        BaseOptions(
            baseUrl: baseUrl,
            receiveDataWhenStatusError: true,
            headers: {'Accept': 'application/json'},
        )
    );
  }

  static Future<Response> postData ({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? token
  })
   async{
    return await dio.post(
        url,
        data:data,
      queryParameters: query
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async
  {
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

}
