import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';

import '../../../../../config/injectable/injectable.dart';
import '../../../../config/app/app_config.dart';
import '../../../../modules/shared/_domain/utility/check_role.dart';
import '../../../../modules/shared/login/data/enum/user_role_enum.dart';
import '../../../../services/local_storage/token_manager/token_manager.dart';
import '../../../styles/app_colors.dart';
import '../../../widgets/cached_image_widget.dart';

class ClientImageWidget extends StatefulWidget {
  final String? iin;

  const ClientImageWidget(this.iin, {super.key});

  @override
  State<ClientImageWidget> createState() => _ClientImageWidgetState();
}

class _ClientImageWidgetState extends State<ClientImageWidget> {
  String imageUrl = '';
  Map<String, String> headers = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getData());
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _showInlargeImage,
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.only(right: 16),
        decoration: widget.iin != null
            ? null
            : const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.inactiveText,
              ),
        child: widget.iin != null
            ? ClipOval(
                child: CachedImageWidget(
                  imageUrl,
                  customHeaders: headers,
                  width: double.infinity,
                  height: double.infinity,
                ),
              )
            : null,
      ),
    );
  }

  Future<void> getData() async {
    final accessToken = await getIt.get<TokenManager>().accessToken;
    late final String host;

    if (isManager(UserRoleEnum.creditManager)) {
      host = getIt.get<AppConfig>().creditBaseUrl;
    } else {
      host = getIt.get<AppConfig>().resaleBaseUrl;
    }

    if (widget.iin != null && accessToken != null) {
      setState(() {
        imageUrl = '$host/api/v1/queue/clientPhoto?clientIin=${widget.iin}';
        headers = {'Authorization': 'Bearer $accessToken'};
      });
    }
  }

  void _showInlargeImage() {
    if ((widget.iin ?? '').isEmpty && imageUrl.isEmpty && headers.isEmpty) {
      return;
    }

    final networkImages = [Image.network(imageUrl, headers: headers).image];
    final multiImageProvider = MultiImageProvider(networkImages);

    showImageViewerPager(context, multiImageProvider);
  }
}
