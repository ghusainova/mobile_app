import 'package:flutter/material.dart';

import '../../../../../../components/styles/app_colors.dart';
import '../../../../../../components/widgets/buttons/outlined_blue_button.dart';
import '../../../../../../config/injectable/injectable.dart';
import '../../../../../../services/local_storage/system_options/system_options.dart';
import '../../../../_domain/utility/check_role.dart';
import '../../../../login/data/enum/user_role_enum.dart';
import '../../../../queue/domain/bloc/queue_bloc.dart';
import 'queue_ip_address_modal.dart';

class QueueIpAddressWidget extends StatefulWidget {
  const QueueIpAddressWidget({super.key});

  @override
  State<QueueIpAddressWidget> createState() => _QueueIpAddressWidgetState();
}

class _QueueIpAddressWidgetState extends State<QueueIpAddressWidget> {
  bool get hideWidget => isManager(UserRoleEnum.techSpecialist);

  @override
  Widget build(BuildContext context) {
    if (hideWidget) {
      return const SizedBox();
    }

    return Column(
      children: [
        FutureBuilder(
          future: getIt.get<SystemOptions>().getDeviceId(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'DeviceId: ${snapshot.data}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: AppColors.inactiveText),
                ),
              );
            }

            return const SizedBox();
          },
        ),
        FutureBuilder(
          future: getIpAddress(),
          builder: (context, snapshot) {
            return OutlinedBlueButton(
              text: (snapshot.data ?? '').isEmpty
                  ? 'Установить IP адрес ЭО'
                  : 'IP адрес ЭО: ${snapshot.data}',
              margin: const EdgeInsets.only(bottom: 16),
              isLoading: snapshot.connectionState == ConnectionState.waiting,
              onPressed: () => onChangeIpAddress(snapshot.data),
            );
          },
        ),
      ],
    );
  }

  Future<String?> getIpAddress() async {
    return await getIt.get<QueueBloc>().getDeviceIp();
  }

  void onChangeIpAddress(String? ip) async {
    final response = await showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      context: context,
      isScrollControlled: true,
      builder: (context) => QueueIpAddressModal(ip),
    );

    if (response != null) {
      getQueueIpAddress(response);
    }
  }

  void getQueueIpAddress(String? ip) async {
    if ((ip ?? '').isEmpty) {
      return;
    }

    await getIt.get<QueueBloc>().setDeviceInfo(ip!);
    getIt.get<QueueBloc>().add(const GetManagerState());
    if (mounted) setState(() {});
  }
}
