///[title] 标题
///[contents] 简介
///[apkDownloadUrl] apk下载链接
///[force] 是否强制升级 true 强制 默认为false
class AppUpgradeModel {
  final String? title;
  final List<String>? contents;
  final String apkDownloadUrl;
  final bool? force;

  AppUpgradeModel(
      {this.title = '',
      this.contents = const [],
      required this.apkDownloadUrl,
      this.force = false});
}
