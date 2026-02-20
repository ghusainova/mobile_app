import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../config/injectable/injectable.dart';
import '../../../../../components/widgets/appbar/appbar_widget.dart';
import '../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../components/widgets/snackbar/snackbar.dart';
import '../../data/models/completing_reasons_args.dart';
import '../../domain/bloc/complete_client_session_bloc.dart';
import 'widgets/reasons_tile_list_widget.dart';

class CompletingReasonsPage extends StatefulWidget {
  final CompletingReasonsRouteArgs args;

  const CompletingReasonsPage(this.args, {super.key});

  @override
  State<CompletingReasonsPage> createState() => _CompletingReasonsPageState();
}

class _CompletingReasonsPageState extends State<CompletingReasonsPage> {
  String reason = '';
  String? comment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget('Завершение работы'),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.args.title ??
                          'Выберите причину,\nчтобы завершить работу',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    ReasonsTileListWidget(
                      completingReason: widget.args.reasonItems,
                      onReasonChanged: onReasonChanged,
                      onCommentChanged: onCommentChanged,
                    ),
                  ],
                ),
              ),
            ),
            BlocProvider.value(
              value: getIt.get<CompleteClientSessionBloc>(),
              child: BlocConsumer<CompleteClientSessionBloc,
                  CompleteClientSessionState>(
                listener: (context, state) => state.whenOrNull(
                  completed: onCompleted,
                  error: (error) => showSnackBar(context, error),
                ),
                builder: (context, state) => BlueButton(
                  text: 'Завершить работу с клиентом',
                  isLoading: state is Loading,
                  onPressed: onPressed,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onReasonChanged(String text) {
    reason = text;
  }

  void onCommentChanged(String text) {
    if (text.isNotEmpty) {
      comment = toBeginningOfSentenceCase(text);
    } else {
      comment = null;
    }
  }

  void onPressed() {
    final commentText = comment != null ? (comment ?? '').trim() : null;

    if (reason == 'Другое' && (commentText ?? '').length < 15) {
      showSnackBar(context, 'Оставьте развернутый комментарий');
      return;
    }

    if (reason != 'Другое' && commentText != null) {
      comment = null;
    }

    getIt.get<CompleteClientSessionBloc>().add(
          CompleteClientSession(
            reason: reason,
            isCancel: widget.args.isCancel,
            comment: commentText,
          ),
        );
  }

  void onCompleted() {
    if (widget.args.onSubmit != null) {
      widget.args.onSubmit!();
    }

    if (widget.args.isCancel == true) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => showSnackBar(context, 'Заявка на Автокредит отменена'),
      );
    }
  }
}
