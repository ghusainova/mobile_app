import 'package:dio/dio.dart' hide Headers;
import '../models/user/app_version_response.dart';
import '../models/user/token.dart';
import 'package:retrofit/retrofit.dart';

part 'generated/auth_api_provider.g.dart';

@RestApi()
abstract class AuthApiProvider {
  factory AuthApiProvider(Dio dioClean) = _AuthApiProvider;

  @POST('/api/v1/auth/login')
  Future<Token> logIn(
    @Field('login') String login,
    @Field('password') String password,
  );

  @POST('/api/v1/queue/logout')
  Future<void> logOut(@Header('Authorization') bearerToken);

  @POST('/api/v1/auth/refresh-token')
  Future<Token> refreshToken(@Field('refresh_token') String refreshToken);

  @POST('/api/v1/users/update-roles')
  Future<void> updateRoles(@Header('Authorization') bearerToken);

  @GET('/api/v1/files/file/mobile-version/{appVersion}')
  Future<AppVersionResponse?> checkAppVersion(
    @Header('Authorization') bearerToken,
    @Path('appVersion') String appVersion,
  );
}
