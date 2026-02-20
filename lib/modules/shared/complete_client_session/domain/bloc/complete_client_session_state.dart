part of 'complete_client_session_bloc.dart';

@freezed
class CompleteClientSessionState with _$CompleteClientSessionState {
  const factory CompleteClientSessionState.initial() = _Initial;
  const factory CompleteClientSessionState.loading() = Loading;
  const factory CompleteClientSessionState.completed() = Completed;
  const factory CompleteClientSessionState.branchLoaded(
    List<BranchUser> branches,
  ) = BranchLoaded;
  const factory CompleteClientSessionState.error(String? error) = _Error;
}
