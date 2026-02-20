
{{#is_stateless}}
import 'package:flutter/material.dart';

import '../../../../../components/widgets/appbar/appbar_widget.dart';

class {{filename.pascalCase()}}Page extends StatelessWidget {
  const {{filename.pascalCase()}}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar:  AppBarWidget('{{filename}}'),
    );
  }
}
{{/is_stateless}}
{{^is_stateless}}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/injectable/injectable.dart';
import '../../../../../presentation/widgets/appbar/appbar_widget.dart';
import '../../../../../presentation/widgets/no_content_widget.dart';
import '../../../../../presentation/widgets/snackbar/snackbar.dart';
import '../../domain/{{filename.snakeCase()}}/{{filename.snakeCase()}}_bloc.dart';
import 'widgets/{{filename.snakeCase()}}_content.dart';

class {{filename.pascalCase()}}Page extends StatefulWidget {
  const {{filename.pascalCase()}}Page({super.key});

  @override
  State<{{filename.pascalCase()}}Page> createState() => _{{filename.pascalCase()}}PageState();
}

class _{{filename.pascalCase()}}PageState extends State<{{filename.pascalCase()}}Page> {
  final bloc = getIt.get<{{filename.pascalCase()}}Bloc>();
  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget('{{filename}}'),
      body: BlocProvider.value(
        value: bloc,
        child: BlocConsumer<{{filename.pascalCase()}}Bloc, {{filename.pascalCase()}}State>(
          listener: (context, state) {
            state.whenOrNull(
              error: (message) => showSnackBar(context, message ?? ''),
            );
          },
          builder: (context, state) =>
              state.whenOrNull(
                loading: () => const Center(child: CircularProgressIndicator()),
                loaded: ({{filename.camelCase()}}) => const {{filename.pascalCase()}}Content(),
                error: (errorMessage) => NoContentWidget(
                  onRefresh: load,
                  errorMessage:errorMessage,
                ),
              ) ??
              const SizedBox(),
        ),
      ),
    );
  }

  void load() {
    bloc.add(const {{filename.pascalCase()}}Event.load());
  }
}

{{/is_stateless}}