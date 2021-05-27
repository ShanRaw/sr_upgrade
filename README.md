# app_upgrade

*Android download and upgrade APK, custom UI components support download progress callback*

## 添加依赖
```yaml
dependencies:
  sr_upgrade: ^0.0.1
```

## 使用
- 引入
```dart
import 'package:sr_upgrade/sr_upgrade.dart';
```
- 继承SrUpgradeDialog 创建UI
```dart
class CustomSrUpgradeDialog extends SrUpgradeDialog {
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
                '这里是自定义升级弹窗',
                style: TextStyle(
                    fontSize: 16, color: Color(0xff333333), height: 2),
              ),
              Expanded(child: Container()),
              Container(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('取消')),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            onOk();
                          },
                          child: Text('升级')),
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
    SrUpgrade.upgrade(
        'https://wbdear.oss-cn-beijing.aliyuncs.com/sr_upgrade/app-release.apk');
  }
}
```
- 调用SrUpgrade.show
```dart
    SrUpgrade.show(context,
        barrierDismissible: false,
        appUpgradeDialog: CustomSrUpgradeDialog(),
        progressCallback: (int count, int total) {
    });
```
