import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../models/credit_documents.dart';

part 'generated/credit_documents_api_provider.g.dart';

@RestApi()
abstract class CreditDocumentsApiProvider {
  @factoryMethod
  factory CreditDocumentsApiProvider(Dio dio) = _CreditDocumentsApiProvider;

  @GET('/api/v1/print/{clientIin}')
  Future<CreditDocuments> getCreditDocuments(
    @Path('clientIin') clientIin,
  );
}
