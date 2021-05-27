```dart
import 'package:flutter/material.dart';
import 'package:sr_upgrade/sr_upgrade.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

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

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String step = '0.00';

  _upgrade() {
    SrUpgrade.show(context,
        barrierDismissible: false,
        appUpgradeDialog: CustomSrUpgradeDialog(),
        progressCallback: (int count, int total) {
      setState(() {
        step = (count / total * 100).toStringAsFixed(2);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: _upgrade,
              child: Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15)),
                alignment: Alignment.center,
                child: Text(
                  '检查升级',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            Text('当前下载进度$step%')
          ],
        ),
      ),
    );
  }
}

```
