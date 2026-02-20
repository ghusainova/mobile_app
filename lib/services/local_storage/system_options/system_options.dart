import 'dart:async';

import 'package:flutter_device_imei/flutter_device_imei.dart';
import 'package:injectable/injectable.dart';

import '../../../config/extensions/string_extensions.dart';
import '../../../config/logs/log.dart';
import '../secured_storage.dart';
import 'system_key_constants.dart';

@singleton
class SystemOptions {
  final SecuredStorage securedStorage;

  SystemOptions(this.securedStorage);

  Future<String?> getDeviceId() async {
    try {
      return await FlutterDeviceImei.instance.getIMEI();
    } catch (e) {
      logger.e(e);
    }

    return null;
  }

  Future<String?> getCachedIpAddress() async {
    try {
      return await securedStorage.storage.read(key: queueIpAddressKey);
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<void> storeQueueIpAddress(String queueIpAddress) async {
    try {
      await securedStorage.storage
          .write(key: queueIpAddressKey, value: queueIpAddress);
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> firstInitAutoScroll() async {
    final scrollState = await getAutoScrollStatus();

    if (!scrollState.parseBool()) {
      await changeAutoScrollStatus();
    }
  }

  Future<bool> changeAutoScrollStatus() async {
    bool isEnabled = false;

    try {
      final status = await getAutoScrollStatus();
      isEnabled = status.parseBool();
      await securedStorage.storage
          .write(key: autoScrollStatusKey, value: (!isEnabled).toString());
    } catch (e) {
      logger.e(e);
    }

    return !isEnabled;
  }

  Future<String?> getAutoScrollStatus() async {
    try {
      return await securedStorage.storage.read(key: autoScrollStatusKey);
    } catch (e) {
      logger.e(e);
    }

    return null;
  }

  Future<void> clearAllStorage() async {
    try {
      await securedStorage.storage.deleteAll();
    } catch (e) {
      logger.e(e);
    }
  }
}
