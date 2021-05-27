import 'package:sr_upgrade/dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

export 'dialog.dart';

typedef ProgressCallback = void Function(int count, int total);

///[show] 显示升级弹窗
///[getPath] 获取apk存储路径
///[upgrade] 升级
///[installApk] 安装apk
class SrUpgrade {
  static const MethodChannel _channel = const MethodChannel('app_upgrade');

  static ProgressCallback? onProgressCallback;

  ///[context] buildContent
  ///[appUpgradeDialog] 弹窗UI
  ///[progressCallback] 下载进度回调函数[ProgressCallback]
  ///[barrierDismissible] 为[showDialog.barrierDismissible]
  static show(BuildContext context,
      {required SrUpgradeDialog appUpgradeDialog,
      ProgressCallback? progressCallback,
      bool? barrierDismissible}) {
    onProgressCallback = progressCallback;
    showDialog(
        context: context,
        barrierDismissible: barrierDismissible ?? false,
        builder: (BuildContext context) => appUpgradeDialog);
  }

  static getPath() async {
    return await _channel.invokeMethod('path');
  }

  static Future upgrade<bool>(String downloadUrl) async {
    final String rootPath = await getPath();
    final String appPath = '$rootPath/temp_apk.apk';
    final dio = Dio();
    try {
      await dio.download(downloadUrl, appPath,
          deleteOnError: true, onReceiveProgress: onProgressCallback);
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
