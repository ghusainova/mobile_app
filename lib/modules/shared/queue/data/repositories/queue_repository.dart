import 'package:injectable/injectable.dart';

import '../../../../../config/injectable/injectable.dart';
import '../../../../../services/local_storage/system_options/system_options.dart';
import '../../../../../services/local_storage/token_manager/token_manager.dart';
import '../../../../credit_manager/credit_application/domain/credit_application/credit_application_bloc.dart';
import '../../../../credit_manager/credit_queue/data/providers/credit_queue_api_provider.dart';
import '../../../../sales_manager/client_processing/data/enum/manager_state.dart';
import '../../../_domain/utility/check_role.dart';
import '../../../login/data/enum/user_role_enum.dart';
import '../../../login/domain/user/user_bloc.dart';
import '../models/branch_user.dart';
import '../models/active_client_dto.dart';
import '../providers/queue_api_provider.dart';

@lazySingleton
class QueueRepository {
  final QueueApiProvider queueApiProvider;
  final CreditQueueApiProvider creditQueueApiProvider;
  final TokenManager tokenManager;
  final SystemOptions systemOptions;
  final UserBloc userBloc;

  const QueueRepository({
    required this.userBloc,
    required this.queueApiProvider,
    required this.creditQueueApiProvider,
    required this.tokenManager,
    required this.systemOptions,
  });
  get provider => isManager(UserRoleEnum.creditManager)
      ? creditQueueApiProvider
      : queueApiProvider;

  Future<void> queueAuth() async {
    final deviceId = await systemOptions.getDeviceId();

    if (deviceId == null) {
      throw 'Не удалось определить Device ID';
    }

    final credentials = await tokenManager.getLoginCredentials();

    if (credentials != null) {
      final response = await provider.queueAuth(
        contentType: 'application/x-www-form-urlencoded',
        login: credentials.login,
        password: credentials.password,
        deviceId: deviceId,
      );
      await tokenManager.storeBranchUser(response);
    } else {
      throw Exception('No log in credentials specified');
    }
  }

  Future<ManagerState?> getManagerState() async {
    final response = await provider.getManagerState();
    return response.data;
  }

  Future<BranchUser?> getBranchUser() async {
    return await tokenManager.getBranchUser();
  }

  Future<int?> getQueueLength() async {
    final response = await provider.getQueueLength();
    return response.shortStatistics.queueLength;
  }

  Future<ActiveClientDTO> getActiveClient() async {
    return await provider.getActiveClient();
  }

  Future<ActiveClientDTO?> callClient({String? iin}) async {
    Map<String, dynamic> body = {};

    if ((iin ?? '').isNotEmpty) {
      body = {
        'clientIin': iin,
      };
    } else {
      body = {
        'clientTransactionId': 0,
      };
    }

    return await provider.callClient(body);
  }

  Future<void> recallClient(int clientTransactionId) async {
    await provider.recallClient(clientTransactionId);
  }

  Future<List<BranchUser>> getQueueBranch() async {
    final response = await provider.getQueueBranch();
    return response.users;
  }

  Future<void> completeClientSession({
    required int clientTransactionId,
    String? reason,
    String? comment,
    bool? isCancel,
  }) async {
    if (isManager(UserRoleEnum.creditManager)) {
      final creditOrderId =
          getIt.get<CreditApplicationBloc>().carLoanOrder?.order.id;

      await provider.completeClientSession(
        clientTransactionId: clientTransactionId,
        orderId: creditOrderId,
        reason: reason,
        comment: comment,
        isCancel: isCancel ?? false,
      );
    } else {
      await provider.completeClientSession(
        clientTransactionId: clientTransactionId,
        reason: reason,
        comment: comment,
      );
    }
  }

  Future<void> redirectClient(
    int clientTransactionId,
    int queueType,
    int tableNumber,
  ) async {
    await provider.redirectClient(
      clientTransactionId,
      queueType,
      tableNumber,
    );
  }

  Future<String?> getDeviceIp() async {
    final token = await tokenManager.accessToken;

    if (token == null) {
      return null;
    }

    final deviceId = await systemOptions.getDeviceId();
    return await provider.getDeviceIp(deviceId);
  }

  Future<void> setDeviceInfo(String computerAddress) async {
    final deviceId = await systemOptions.getDeviceId();
    await provider.setDeviceInfo(
      deviceId: deviceId,
      computerAddress: computerAddress,
    );
  }
}
