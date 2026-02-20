import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../shared/queue/data/models/branch_user.dart';
import '../../../../shared/queue/data/models/queue_branch_response.dart';
import '../../../../shared/queue/data/models/active_client_dto.dart';
import '../../../../shared/queue/data/models/manager_state_dto.dart';
import '../../../../shared/queue/data/models/queue_length_response.dart';

part 'generated/credit_queue_api_provider.g.dart';

@RestApi()
abstract class CreditQueueApiProvider {
  @factoryMethod
  factory CreditQueueApiProvider(Dio dio) = _CreditQueueApiProvider;

  @POST('/api/v1/queue/login')
  Future<BranchUser?> queueAuth({
    @Header('Content-Type') required String contentType,
    @Field('login') required String login,
    @Field('password') required String password,
    @Field('deviceId') String? deviceId,
  });

  @GET('/api/v1/queue/length')
  Future<QueueLengthResponse> getQueueLength();

  @GET('/api/v1/queue/managerState')
  Future<ManagerStateDTO?> getManagerState();

  @GET('/api/v1/queue/activeClient')
  Future<ActiveClientDTO> getActiveClient();

  @POST('/api/v1/queue/call')
  Future<ActiveClientDTO?> callClient(
    @Body() body,
  );

  @POST('/api/v1/queue/repeat-call')
  Future<void> recallClient(
    @Field('clientTransactionId') int clientTransactionId,
  );

  @GET('/api/v1/queue/branch')
  Future<QueueBranchResponse> getQueueBranch();

  @POST('/api/v1/queue/complete')
  Future<void> completeClientSession({
    @Field('clientTransactionId') required int clientTransactionId,
    @Field('orderId') int? orderId,
    @Field('reason') String? reason,
    @Field('comment') String? comment,
    @Field('isCancel') bool? isCancel,
  });

  @POST('/api/v1/queue/redirect')
  Future<void> redirectClient(
    @Field('clientTransactionId') int clientTransactionId,
    @Field('queueType') int queueType,
    @Field('tableNumber') int tableNumber,
  );

  @GET('/api/v1/queue/getDeviceId')
  Future<String?> getDeviceIp(
    @Query('deviceId') String deviceId,
  );

  @POST('/api/v1/queue/setDeviceInfo')
  Future<void> setDeviceInfo({
    @Field('deviceId') required String deviceId,
    @Field('computerAddress') required String computerAddress,
  });
}
