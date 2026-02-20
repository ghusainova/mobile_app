part of 'qr_bloc.dart';

@freezed
class QrEvent with _$QrEvent {
  const factory QrEvent.getApprovalForCarLoan({
    required String? id,
    required String? advertLink,
  }) = GetApprovalForCarLoan;
  const factory QrEvent.applyWithoutCarLoan({
    required String? id,
  }) = ApplyWithoutCarLoan;
}
