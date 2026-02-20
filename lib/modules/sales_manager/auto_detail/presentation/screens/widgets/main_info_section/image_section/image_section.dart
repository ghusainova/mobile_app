import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../config/injectable/injectable.dart';
import '../../../../../data/enums/photo_type_enum.dart';
import '../../../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../../domain/auto_detail/auto_detail_bloc.dart';
import '../../../../../domain/photos/photos_bloc.dart';
import 'image_carousel.dart';

class ImageSection extends StatefulWidget {
  const ImageSection({super.key});

  @override
  State<ImageSection> createState() => _ImageSectionState();
}

class _ImageSectionState extends State<ImageSection> {
  final photosBloc = getIt.get<PhotosBloc>();

  @override
  void initState() {
    super.initState();
    initBloc();
  }

  @override
  void dispose() {
    photosBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: photosBloc,
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 3.2,
        child: BlocConsumer<PhotosBloc, PhotosState>(
          listener: (context, state) {
            state.whenOrNull(
              error: (message) => showSnackBar(context, message ?? ''),
            );
          },
          builder: (context, state) =>
              state.whenOrNull(
                loading: () => const Center(child: CircularProgressIndicator()),
                loaded: (photos) => ImageCarousel(photos: photos),
              ) ??
              const SizedBox(),
        ),
      ),
    );
  }

  void initBloc() {
    final orderId = context.read<AutoDetailBloc>().autoInfo?.id;
    final type = PhotoTypeEnum.vehicles.documentType;

    photosBloc.add(
      PhotosEvent.load(orderId: orderId, type: type),
    );
  }
}
