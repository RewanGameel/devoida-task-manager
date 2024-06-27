import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../app/app_prefs.dart';
import '../../app/constants.dart';
import '../service_locator.dart';

const String APPLICATION_JSON = 'application/json';
const String CONTENT_TYPE = 'content-type';
const String ACCEPT = 'accept';
const String AUTHORIZATION = 'authorization';
const String DEFAULT_LANGUAGE = 'language';

class DioFactory {
  final AppPreferences _appPreferences;

  DioFactory(this._appPreferences);
  Dio? dio;
  bool isTokenRefreshDialogOpen = false;
  String? refreshTokenInProgress;

  Future<Dio> getDio() async {
    dio = Dio();

    Map<String, String> header = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: Constants.apiToken,
    };
    dio!.options = BaseOptions(
      baseUrl: Constants.appBaseUrl,
      headers: header,
      sendTimeout: Duration(milliseconds: Constants.apiTimeout),
      receiveTimeout: Duration(milliseconds: Constants.apiTimeout),
    );

    dio!.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        var option = options.copyWith();
        Map<String, dynamic> queryParameters = options.queryParameters;
        options.queryParameters = queryParameters;
        option.queryParameters = queryParameters;
        if (options.path.contains('/login')) {
          option = options.copyWith(baseUrl: Constants.appBaseUrl);
        } else if (options.path.contains('/users')) {
          option = options.copyWith(baseUrl: Constants.appBaseUrl);
        } else {
          option = options.copyWith(baseUrl: Constants.appBaseUrl);
        }

        return handler.next(option);
      },
      onResponse: (e, handler) {
        return handler.next(e);
      },
      onError: (error, handler) async {
        // if ((error.response?.statusCode == 401 && (error.response?.data['error'] != "Token has expired" || error.response?.data['error'] != "Token is invalid"))) {
        //   if (!(error.requestOptions.path.contains('logout')) && !(error.requestOptions.path.contains('login')) && !(error.requestOptions.path.contains('refresh-token'))) {
        //     if (await refreshToken()) {
        //       error.requestOptions.headers['Authorization'] = 'Bearer ${Singleton().token}';
        //       return handler.resolve(await _retry(error.requestOptions));
        //    }
        //   }
        // }
        return handler.next(error);
      },
    ));
    //this to show log for request in debug mode

    if (!kReleaseMode) {
      dio!.interceptors.add(PrettyDioLogger(requestHeader: true, requestBody: true, responseHeader: true));

      // Disable certificate validation (not recommended for production)
      (dio!.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        return null;
      };
    }
    return dio!;
  }

  //cache token and refresh token every 25 minutes

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    isTokenRefreshDialogOpen = false;
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return dio!.request<dynamic>(requestOptions.path, data: requestOptions.data, queryParameters: requestOptions.queryParameters, options: options);
  }
}
