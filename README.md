# app_upgrade

*Android download and upgrade APK, custom UI components support download progress callback*

## 使用
```dart
 AppUpgrade.show(context,
                downloadCloseForUpgradeWindow: true,
                info: AppUpgradeModel(
                    apkDownloadUrl:
                        'xxx.apk',
                    title: '测试升级',
                    contents: [
                      '1.修复一直bug',
                      '2.修复已知问题',
                    ]), progressCallback: (int count, int total) {
              ///这可以state显示下载进度
              setState(() {
                step = (count / total * 100).toStringAsFixed(2);
              });
            })

```
## 自定义UI
```dart
class CustomAppUpgradeDialog extends AppUpgradeDialog {
  final AppUpgradeModel info;

  CustomAppUpgradeDialog({required this.info});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        alignment: Alignment.center,
        child: Container(
          width: 250,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: [
              Text(
                info.title ?? '',
                style: TextStyle(
                    fontSize: 16, color: Color(0xff333333), height: 2),
              ),
              Expanded(
                  child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 15),
                children: info.contents!
                    .map((e) => Text(
                          e,
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey, height: 1.6),
                        ))
                    .toList(),
              )),
              Container(
                height: 50,
                child: Row(
                  children: [
                    info.force != true
                        ? Expanded(
                            child: TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('取消')),
                          )
                        : Container(),
                    Expanded(
                      child: TextButton(onPressed: onOk, child: Text('升级')),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      color: Colors.transparent,
    );
  }

  @override
  onCancel() {
    // TODO: implement onCancel
  }

  @override
  onOk() {
    AppUpgrade.upgrade(info.apkDownloadUrl);
  }
}
```

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

