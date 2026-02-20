import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../models/single_message_response.dart';

part 'generated/qr_api_provider.g.dart';

@RestApi()
@lazySingleton
abstract class QrApiProvider {
  @factoryMethod
  factory QrApiProvider(Dio dio) = _QrApiProvider;

  @POST('/api/v1/sm/orders/{id}/finish/approved')
  Future<SingleMessageResponse> getApprovalForCarLoan(
    @Path('id') String? id,
    @Field('clientIin') int? clientIin,
    @Field('advertLink') String? advertLink,
    @Field('clientTransactionId') int? clientTransactionId,
  );

  @POST('/api/v1/sm/orders/{id}/finish/unapproved')
  Future<String?> applyWithoutCarLoan(
    @Path('id') String? id,
    @Field('clientIin') String? clientIin,
    @Field('clientTransactionId') int? clientTransactionId,
  );
}
