import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../shared/login/data/models/user/token.dart';
import '../models/scan_case.dart';

part 'generated/scan_case_api_provider.g.dart';

@RestApi()
abstract class ScanCaseApiProvider {
  @factoryMethod
  factory ScanCaseApiProvider(Dio dio) = _ScanCaseApiProvider;

  @POST('/api/v2/auth/login')
  Future<Token> logIn(
    @Field('login') String login,
    @Field('password') String password,
  );

  @GET('/api/v2/orders/by-user')
  Future<List<ScanCase>> getCases();

  @POST('/api/v2/orders/{caseId}/in-work')
  Future getCaseInWork({
    @Path('caseId') required String caseId,
  });
}
