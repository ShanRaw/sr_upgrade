import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef ProgressCallback = void Function(int count, int total);
typedef DioCallback = void Function(Dio dio);

///[getPath] 获取apk存储路径
///[upgrade] 升级
///[installApk] 安装apk
class SrUpgrade {
  static const MethodChannel _channel = const MethodChannel('app_upgrade');

  static getPath() async {
    return await _channel.invokeMethod('path');
  }

  static Future upgrade<bool>(String downloadUrl,
      {ProgressCallback? progressCallback, DioCallback? dioCallback}) async {
    final String rootPath = await getPath();
    final String appPath = '$rootPath/temp_apk.apk';
    final dio = Dio();
    CancelToken token = new CancelToken();
    try {
      await dio.download(downloadUrl, appPath,cancelToken: token,
          deleteOnError: true,
          onReceiveProgress: progressCallback ?? (int count, int total) {});
      if (dioCallback != null) {
        dioCallback(dio);
      }
    } catch (err) {
      return false;
    }
    return await installApk(appPath);
  }

  static Future installApk<bool>(String path) async {
    try {
      await _channel.invokeMethod('install', {"path": path});
    } catch (err) {
      return false;
    }
    return true;
  }
}
