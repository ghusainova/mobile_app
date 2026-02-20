import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../components/styles/app_colors.dart';
import '../../../../domain/defects/defects_bloc.dart';
import '../modals/point_modal.dart';
import '../../../../../../shared/utilities/defect_imports.dart';

class PointWidget extends StatefulWidget {
  final int index;
  final num topValue;
  final num leftValue;

  const PointWidget({
    required this.index,
    required this.topValue,
    required this.leftValue,
    super.key,
  });

  @override
  State<PointWidget> createState() => _PointWidgetState();
}

class _PointWidgetState extends State<PointWidget> {
  @override
  Widget build(BuildContext context) {
    final displaySize = MediaQuery.of(context).size;

    return BlocBuilder<DefectsBloc, DefectsState>(
      builder: (context, state) {
        final bloc = context.read<DefectsBloc>();

        int? pointMicroMeter = bloc.getPointMicroMeter(widget.index);
        return Container(
          child: (pointMicroMeter == null)
              ? Positioned(
                  top: displaySize.height * widget.topValue,
                  left: displaySize.width * widget.leftValue,
                  child: IconButton(
                    onPressed: _openPointModal,
                    icon: Image.asset(
                      AppAssets.defectPoint,
                      height: 40,
                    ),
                  ),
                )
              : Positioned(
                  top: displaySize.height * (widget.topValue + 0.01),
                  left: displaySize.width * (widget.leftValue + 0.02),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors.red,
                    child: InkWell(
                      onTap: _openPointModal,
                      child: Text(
                        pointMicroMeter.toString(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }

  void _openPointModal() {
    final bloc = context.read<DefectsBloc>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showModalBottomSheet(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) => PointModal(
          index: widget.index,
          microMeter: bloc.getPointMicroMeter(widget.index),
          defect: bloc.defect,
          onUpdate: (defect) => bloc.add(DefectsEvent.setDefect(defect)),
        ),
      );
    });
  }
}
