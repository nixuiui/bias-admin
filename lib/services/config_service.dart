import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';

class ConfigService {
  static ConfigService get to => Get.find();

  final appVersion = ''.obs;

  ConfigService() {
    init();
  }

  init() async {
    _packageInfo ??= await PackageInfo.fromPlatform();
    appVersion.value = _packageInfo?.version ?? '';
  }

  PackageInfo? _packageInfo;
  bool get hasFinishedLoading => _packageInfo != null;

  Future loadConfig() async {
    _packageInfo ??= await PackageInfo.fromPlatform();
  }

  Dio? _httpClient;
  Dio? get httpClient => _httpClient;
}
