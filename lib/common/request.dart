import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './const.dart';

class DioUtils {
  static Dio dio;

  static Dio _getDio({
    bool showErr=true
  }) {
    if (dio == null) {
      var options = BaseOptions(
        // baseUrl: Const.BASE_URL,
      );
      dio = Dio(options);
      dio.interceptors.add(InterceptorsWrapper(
        onError: (err) {
          // if (err.message != 'hasErr') {
          //   Fluttertoast.showToast(msg: '后端出错了!');
          // }
          // print(err.error);
          // print(err.request);
          // print(err.response);
          return err;         
        },
        onResponse: (res) {
          if (res.data['hasErr'] == 1) {
            if (showErr) {
              Fluttertoast.showToast(msg: res.data['message']??'hasErr');
            }
            throw Exception('hasErr');
          }
        },
        onRequest: (option){
          // print(option.path);
        }
      ));
    }
    
    return dio;
  }

  static Future get(url) async{
    return await DioUtils._getDio().get(url);
  }

  static Future<Response> post(url, {data}) async{
    return await DioUtils._request(url, method: 'post', data: data, showErr: true);
  }

  static Future<Response> put(url, {data}) async{
    return await DioUtils._request(url, method: 'put', data: data, showErr: true);
  }

  static Future<Response> putWithoutToast(url, {data}) async{
    return await DioUtils._request(url, method: 'put', data: data, showErr: false);
  }

  static Future<Response> _request(String path,{
    method='get',
    data,
    showErr
  }) async {
    return DioUtils._getDio(showErr: showErr).request(
      _getUrl(path),
      data: data,
      options: Options(
        method: method,
      )
    );
  }

  static String _getUrl(String path) {
    if (path.startsWith('http')) {
      return path;
    } else if (path.startsWith('/')) {
      return '${Const.BASE_URL}$path';
    } else {
      return '${Const.BASE_URL}/$path';
    }
  }
}