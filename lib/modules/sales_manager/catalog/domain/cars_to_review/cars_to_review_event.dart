part of 'cars_to_review_bloc.dart';

@freezed
class CarsToReviewEvent with _$CarsToReviewEvent {
  const factory CarsToReviewEvent.addToReview(AutoInfo autoInfo) = AddToReview;
  const factory CarsToReviewEvent.removeFromReview(String autoInfoId) =
      RemoveFromReview;
  const factory CarsToReviewEvent.clearReviewList() = ClearReviewList;
}
