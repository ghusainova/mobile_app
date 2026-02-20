part of 'cars_to_review_bloc.dart';

@freezed
class CarsToReviewState with _$CarsToReviewState {
  const factory CarsToReviewState.intial() = _Initial;
  const factory CarsToReviewState.loading() = _Loading;
  const factory CarsToReviewState.hasCarsToReview(List<AutoInfo> autoInfoList) =
      HasCarsToReview;
}
