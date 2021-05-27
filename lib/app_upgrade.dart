import 'package:app_upgrade/dialog.dart';
import 'package:app_upgrade/modal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'default_dialog.dart';
export 'modal.dart';

typedef ProgressCallback = void Function(int count, int total);

///[show] 显示升级弹窗
///[getPath] 获取apk存储路径
///[upgrade] 升级
///[installApk] 安装apk
class AppUpgrade {
  static const MethodChannel _channel = const MethodChannel('app_upgrade');

  static late BuildContext context;

  static ProgressCallback? onProgressCallback;
  static late bool isDownloadCloseForUpgradeWindow;

  ///[context] buildContent
  ///[info] 升级弹窗信息model[AppUpgradeModel]
  ///[progressCallback] 下载进度回调函数[ProgressCallback]
  ///[AppUpgradeDialog] 自定义弹窗组件需要继承实现onCancel onOk 方法
  ///[downloadCloseForUpgradeWindow] 下载的时候是否关闭弹窗 默认为false
  static show(BuildContext context,
      {required AppUpgradeModel info,
      AppUpgradeDialog? appUpgradeDialog,
      ProgressCallback? progressCallback,
      bool? downloadCloseForUpgradeWindow = false}) {
    AppUpgrade.context = context;
    onProgressCallback = progressCallback;
    isDownloadCloseForUpgradeWindow = downloadCloseForUpgradeWindow ?? false;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) =>
            appUpgradeDialog ??
            AppUpgradeDialogDefault(
              info: info,
            ));
  }

  static getPath() async {
    return await _channel.invokeMethod('path');
  }

  static Future upgrade<bool>(String downloadUrl) async {
    // ignore: unnecessary_null_comparison
    if (context == null || isDownloadCloseForUpgradeWindow == null) {
      throw UnimplementedError('请先调用show方法');
    }
    final String rootPath = await getPath();
    final String appPath = '$rootPath/temp_apk.apk';
    final dio = Dio();
    if (isDownloadCloseForUpgradeWindow) {
      Navigator.pop(context);
    }
    try {
      await dio.download(downloadUrl, appPath,
          deleteOnError: true, onReceiveProgress: onProgressCallback);
    } catch (err) {
      return false;
    }
    if (!isDownloadCloseForUpgradeWindow) {
      Navigator.pop(context);
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
