enum ManagerState { activeClient, noActiveClient }

extension ManagerStateExt on ManagerState {
  String get code {
    switch (this) {
      case ManagerState.activeClient:
        return 'ACTIVE_CLIENT';
      case ManagerState.noActiveClient:
        return 'NO_ACTIVE_CLIENT';
    }
  }
}
