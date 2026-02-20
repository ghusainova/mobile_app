import 'dart:io';

import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_compress_v2/video_compress_v2.dart';

void deleteCache() async {
  //TODO: handle path existense error
  DefaultCacheManager().emptyCache();
  imageCache.clear();
  _deleteAppDir();
  _deleteCacheDir();
  _deleteExternal();
  await VideoCompressV2.deleteAllCache();
}

Future<void> _deleteCacheDir() async {
  Directory tempDir = await getTemporaryDirectory();

  if (tempDir.existsSync()) {
    tempDir.deleteSync(recursive: true);
  }
}

Future<void> _deleteAppDir() async {
  Directory appDocDir = await getApplicationDocumentsDirectory();

  if (appDocDir.existsSync()) {
    appDocDir.deleteSync(recursive: true);
  }
}

Future<void> _deleteExternal() async {
  List<Directory>? extCacheDir = await getExternalCacheDirectories();
  if (extCacheDir!.isNotEmpty) {
    for (var element in extCacheDir) {
      element.deleteSync(recursive: true);
    }
  }
}
