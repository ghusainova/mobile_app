import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:flutter/material.dart';

import '../../../../../../components/router/data/routes.dart';
import '../../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../../components/widgets/buttons/outlined_blue_button.dart';
import '../../../../../../components/widgets/status_widget.dart';
import '../../../../../../components/widgets/page_form_widget.dart';
import '../../../../../shared/_data/enums/status_type_enum.dart';
import 'widgets/sales_contract_item_widget.dart';

class SalesContractPage extends StatefulWidget {
  final SalesContractRouteArgs args;

  const SalesContractPage(this.args, {super.key});

  @override
  State<SalesContractPage> createState() => _SalesContractPageState();
}

class _SalesContractPageState extends State<SalesContractPage> {
  String documentBase64 = '';

  @override
  Widget build(BuildContext context) {
    return PageFormWidget(
      appBarTitle: widget.args.title,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            widget.args.title,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            widget.args.subtitle,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        if (documentBase64.isEmpty)
          OutlinedBlueButton(
            text: 'Отсканировать',
            leadingIcon: const Icon(Icons.document_scanner_outlined),
            margin: const EdgeInsets.symmetric(vertical: 16),
            onPressed: () => handleDocumentScanner(context),
          )
        else
          SalesContractItemWidget(
            documentBase64: documentBase64,
            onDelete: deleteDocument,
          ),
        const StatusWidget(
          status: StatusTypeEnum.warning,
          title: 'Замечание',
          subtitle: 'Нет печати на договоре купли-продажи',
          infoCard: true,
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: BlueButton(
              onPressed: widget.args.onSubmit,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> handleDocumentScanner(BuildContext context) async {
    final response = await CunningDocumentScanner.getPictures();
    setState(() => documentBase64 = response?.first ?? ''); //MOCK

    if (context.mounted && (response ?? []).isNotEmpty) {
      DocumentsScannerResultViewRoute(response!).push(context);
    }
  }

  void deleteDocument() {
    setState(() => documentBase64 = '');
  }
}
