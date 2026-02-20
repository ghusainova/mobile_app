import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../../../../config/injectable/injectable.dart';
import '../../../../../config/app/app_config.dart';
import '../../../complete_client_session/data/enums/branch_user_queue_type_enum.dart';
import '../../../../../../modules/shared/login/domain/user/user_bloc.dart';
import '../../../../../components/styles/app_colors.dart';
import '../../../../../components/widgets/page_form_widget.dart';
import '../../../queue/domain/bloc/queue_bloc.dart';
import 'widgets/profile_btns_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = getIt.get<UserBloc>().user;
  List<String> profileInfoItems = [];
  String? appVersion;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getAppVersion());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: PageFormWidget(
        appBarTitle: 'Профиль',
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (user?.userFirstName != null && user?.userLastName != null)
                Text(
                  '${toBeginningOfSentenceCase(user?.userFirstName ?? '')} ${toBeginningOfSentenceCase(user?.userLastName ?? '')}'
                      .trim(),
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              if ((user?.userLogin ?? '').isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    user?.userLogin ?? '',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ...profileInfoItems.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    e,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: AppColors.inactiveText),
                  ),
                ),
              ),
            ],
          ),
          const ProfileBtnsWidget(),
        ],
      ),
    );
  }

  Future<void> getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;

    if (mounted) setState(mapProfileInfoItems);
  }

  void mapProfileInfoItems() {
    final branchUser = getIt.get<QueueBloc>().branchUser;

    profileInfoItems = [
      if (branchUser?.tableNumber != null) 'Стол №${branchUser!.tableNumber!}',
      if (branchUser?.queueType?.label != null) branchUser!.queueType!.label!,
      if (appVersion != null)
        'Версия: $appVersion/${getIt.get<AppConfig>().envType}',
    ];
  }
}
