import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../../modules/buyer_manager/car_info/data/repositories/car_info_repository.dart';
import '../../modules/buyer_manager/car_info/domain/car_info/car_info_bloc.dart';
import '../../modules/buyer_manager/queue/domain/buyout/buyout_bloc.dart';
import '../../modules/credit_manager/credit_application/domain/credit_application/credit_application_bloc.dart';
import '../../modules/credit_manager/credit_documents/data/repositories/credit_documents_repository.dart';
import '../../modules/credit_manager/credit_documents/domain/credit_documents/credit_documents_bloc.dart';
import '../../modules/shared/media_capture_vin/domain/buyer_media_capture_vin/buyer_media_capture_vin_bloc.dart';
import '../dio/dio_client.dart';
import 'injectable.config.dart';

final getIt = GetIt.instance;

@injectableInit
void configureInjection(String environment) {
  getIt.registerFactory(() => DioClient());

  //buyer
  getIt.registerFactory(() => BuyerMediaCaptureVinBloc());
  getIt.registerFactory(
    () => CarInfoBloc(
      getIt.get<CarInfoRepository>(),
      getIt.get<BuyoutBloc>(),
    ),
  );

  getIt.registerFactory(
    () => CreditDocumentsBloc(
      getIt.get<CreditDocumentsRepository>(),
      getIt.get<CreditApplicationBloc>(),
    ),
  );

  getIt.init(environment: environment);
}
