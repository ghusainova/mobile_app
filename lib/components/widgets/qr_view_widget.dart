import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class QrViewVidget extends StatefulWidget {
  final String advertLink;
  final String title;
  final String subtitle;
  final String logoPath;

  const QrViewVidget({
    required this.advertLink,
    required this.title,
    required this.subtitle,
    required this.logoPath,
    super.key,
  });

  @override
  State<QrViewVidget> createState() => _QrViewVidgetState();
}

class _QrViewVidgetState extends State<QrViewVidget> {
  late QrImage qrImage;

  @override
  void initState() {
    super.initState();
    final qrCode = QrCode(
      12,
      QrErrorCorrectLevel.H,
    )..addData(widget.advertLink);

    qrImage = QrImage(qrCode);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            widget.subtitle,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(40),
          child: PrettyQrView(
            qrImage: qrImage,
            decoration: PrettyQrDecoration(
              image: PrettyQrDecorationImage(
                image: Image.asset(widget.logoPath).image,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
