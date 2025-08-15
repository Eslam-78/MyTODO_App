import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

Future<void> printAndroidVersion() async {
  if (Platform.isAndroid) {
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;

    print('Android Version: ${androidInfo.version.release}');
    print('SDK Int: ${androidInfo.version.sdkInt}');
  }
}
