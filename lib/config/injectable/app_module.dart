import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../modules/credit_manager/application_status/data/providers/credit_application_status_api_provider.dart';
import '../../modules/credit_manager/credit_application/data/providers/credit_application_api_provider.dart';
import '../../modules/credit_manager/credit_brand_model_selection/data/providers/credit_brand_model_api_provider.dart';
import '../../modules/credit_manager/credit_documents/data/providers/credit_documents_api_provider.dart';
import '../../modules/credit_manager/credit_queue/data/providers/credit_queue_api_provider.dart';
import '../../modules/credit_manager/credit_additional_info/data/providers/credit_additional_info_api_provider.dart';
import '../../modules/credit_manager/credit_rework/data/providers/credit_rework_api_provider.dart';
import '../../modules/credit_manager/seller_data/data/providers/seller_data_api_provider.dart';
import '../../modules/master_sto/additional_info/data/providers/additional_info_api_provider.dart';
import '../../modules/master_sto/defect_inspection/_shared/data/providers/defects_api_provider.dart';
import '../../modules/master_sto/equipment_inspection/data/providers/equipment_inspection_api_provider.dart';
import '../../modules/master_sto/equipment_inspection/data/providers/tires_api_provider.dart';
import '../../modules/master_sto/history/data/providers/history_api_provider.dart';
import '../../modules/master_sto/main_info/data/providers/main_info_api_provider.dart';
import '../../modules/master_sto/scan_cases/data/providers/scan_case_api_provider.dart';
import '../../modules/shared/_data/constants/global_constants.dart';
import '../app/app_config.dart';
import '../../modules/shared/login/data/providers/auth_api_provider.dart';
import '../../modules/shared/media_capture_vin/data/providers/buyer_media_capture_vin_api_provider.dart';
import '../../modules/credit_manager/credit_media_capture/data/providers/credit_media_capture_api_provider.dart';
import '../../modules/shared/media_capture_vin/data/providers/media_capture_vin_api_provider.dart';
import '../dio/dio_client.dart';
import '../dio/interceptors/error_handling_interceptor.dart';
import '../dio/interceptors/log_interceptor.dart';
import 'injectable.dart';

@module
abstract class AppModule {
  @singleton
  Dio get dio => getIt.get<DioClient>().dio;

  //global
  @Singleton(order: -10)
  AuthApiProvider get authApiProvider => AuthApiProvider(
        Dio(
          BaseOptions(
            baseUrl: getIt.get<AppConfig>().resaleBaseUrl,
            receiveTimeout: Constants.dioTimeout,
            connectTimeout: Constants.dioTimeout,
            sendTimeout: Constants.dioTimeout,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
          ),
        )
          ..interceptors.add(logInterceptor())
          ..interceptors.add(errorHandlingInterceptor()),
      );

  //master-sto
  @lazySingleton
  ScanCaseApiProvider get scanCaseApiProvider =>
      ScanCaseApiProvider(_getDioClient());

  @lazySingleton
  HistoryApiProvider get historyApiProvider =>
      HistoryApiProvider(_getDioClient());

  @lazySingleton
  MediaCaptureApiProvider get mediaCaptureApiProvider =>
      MediaCaptureApiProvider(_getDioClient());

  //TODO: remove this when media api will be refactored to v2/media
  @lazySingleton
  BuyerMediaCaptureApiProvider get buyerMediaCaptureApiProvider =>
      BuyerMediaCaptureApiProvider(
        _getDioClient(url: getIt.get<AppConfig>().resaleBaseUrl),
      );

  @lazySingleton
  DefectsApiProvider get defectsApiProvider =>
      DefectsApiProvider(_getDioClient());

  @lazySingleton
  MainInfoApiProvider get mainInfoApiProvider =>
      MainInfoApiProvider(_getDioClient());

  @lazySingleton
  AdditionalInfoApiProvider get additionalInfoApiProvider =>
      AdditionalInfoApiProvider(_getDioClient());

  @lazySingleton
  EquipmentInspectionApiProvider get equipmenmtApiProvider =>
      EquipmentInspectionApiProvider(_getDioClient());

  @lazySingleton
  TiresApiProvider get tiresApiProvider => TiresApiProvider(_getDioClient());

  //credit-manager
  @lazySingleton
  CreditApplicationApiProvider get creditApplicationApiProvider =>
      CreditApplicationApiProvider(
        _getDioClient(url: getIt.get<AppConfig>().creditBaseUrl),
      );

  @lazySingleton
  CreditQueueApiProvider get creditQueueApiProvider => CreditQueueApiProvider(
        _getDioClient(url: getIt.get<AppConfig>().creditBaseUrl),
      );

  @lazySingleton
  CreditAdditionalInfoApiProvider get creditAdditionalInfoApiProvider =>
      CreditAdditionalInfoApiProvider(
        _getDioClient(url: getIt.get<AppConfig>().creditBaseUrl),
      );

  @lazySingleton
  CreditApplicationStatusApiProvider get creditApplicationStatusApiProvider =>
      CreditApplicationStatusApiProvider(
        _getDioClient(url: getIt.get<AppConfig>().creditBaseUrl),
      );

  @lazySingleton
  CreditBrandModelApiProvider get creditBrandModelApiProvider =>
      CreditBrandModelApiProvider(
        _getDioClient(url: getIt.get<AppConfig>().creditBaseUrl),
      );

  @lazySingleton
  SellerDataApiProvider get sellerDataApiProvider => SellerDataApiProvider(
        _getDioClient(url: getIt.get<AppConfig>().creditBaseUrl),
      );
  @lazySingleton
  CreditReworkApiProvider get creditReworkApiProvider =>
      CreditReworkApiProvider(
        _getDioClient(url: getIt.get<AppConfig>().creditBaseUrl),
      );

  //TODO: remove this when media api will be refactored to v2/media
  @lazySingleton
  CreditMediaCaptureApiProvider get creditMediaCaptureApiProvider =>
      CreditMediaCaptureApiProvider(
        _getDioClient(url: getIt.get<AppConfig>().creditBaseUrl),
      );
  @lazySingleton
  CreditDocumentsApiProvider get creditDocumentsApiProvider =>
      CreditDocumentsApiProvider(
        _getDioClient(url: getIt.get<AppConfig>().creditBaseUrl),
      );

  Dio _getDioClient({String? url}) {
    final baseUrl = url ?? getIt.get<AppConfig>().masterBaseUrl;
    final customDio = dio;
    customDio.options.baseUrl = baseUrl;
    return customDio;
  }
}
