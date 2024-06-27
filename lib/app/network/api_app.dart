import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../app/constants.dart';
import '../../shared/shared_responses/base_response.dart';

part 'api_app.g.dart';

/// It's a Dart class that extends the RestApi class from the dio_rest_api package. It has a factory
/// constructor that takes a Dio object and a baseUrl.
@RestApi()
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  // @POST(Constants.loginApiUrl)
  // Future<BaseResponse> loginWithEmailAndPassword(
  //   @Field('email') String email,
  //   @Field('password') String password,
  // );
}
