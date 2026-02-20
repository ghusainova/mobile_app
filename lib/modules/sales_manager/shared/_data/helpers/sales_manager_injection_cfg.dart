import '../../../../shared/car_inspection/car_body/domain/car_body/car_body_bloc.dart';
import '../../../../shared/car_inspection/interior/domain/interior/interior_bloc.dart';
import '../../../../shared/car_inspection/other_parts/domain/other_parts/other_parts_bloc.dart';
import '../../../auto_detail/domain/auto_detail/auto_detail_bloc.dart';
import '../../../auto_detail/domain/car_loan/car_loan_bloc.dart';
import '../../../auto_detail/domain/photos/photos_bloc.dart';
import '../../../auto_detail/domain/similar_auto/similar_auto_bloc.dart';

void registerSalesManagerInjection() {
  //auto-detail
  AutoDetailBloc().registerInjection();
  PhotosBloc().registerInjection();
  CarLoanBloc().registerInjection();
  SimilarAutoBloc().registerInjection();

  //equipment
  CarBodyBloc().registerInjection();
  InteriorBloc().registerInjection();
  OtherPartsBloc().registerInjection();
}

void unregisterSalesManagerInjection() {
  //auto-detail
  AutoDetailBloc().unregisterInjection();
  PhotosBloc().unregisterInjection();
  CarLoanBloc().unregisterInjection();
  SimilarAutoBloc().unregisterInjection();

  //equipment
  CarBodyBloc().unregisterInjection();
  InteriorBloc().unregisterInjection();
  OtherPartsBloc().unregisterInjection();
}
