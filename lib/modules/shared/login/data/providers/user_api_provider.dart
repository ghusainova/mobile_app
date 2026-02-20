import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../models/user/user.dart';

part 'generated/user_api_provider.g.dart';

@RestApi()
@Singleton()
abstract class UserApiProvider {
  @factoryMethod
  factory UserApiProvider(Dio dio) = _UserApiProvider;

  @GET('/api/v1/users/branch-info')
  Future<User> getUserInfo();
}
