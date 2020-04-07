import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class NetworkHelper {
  final String url;
  Response response;
  Dio dio = new Dio();

  NetworkHelper(this.url);

  Future getData() async {
    try {
      dio.interceptors
          .add(DioCacheManager(CacheConfig(baseUrl: url)).interceptor);
      response = await dio.get(
        url,
        options: buildCacheOptions(
          Duration(minutes: 1),
          maxStale: Duration(days: 6),
        ),
      );
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      print(e);
    }
  }
}
