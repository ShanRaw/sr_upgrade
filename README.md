# app_upgrade

*Android download and upgrade APK, custom UI components support download progress callback*

## AndroidManifest.xml application 增加
```xml
 <provider
        android:name="androidx.core.content.FileProvider"
        android:authorities="${applicationId}.fileprovider"
        android:exported="false"
        android:grantUriPermissions="true">
        <meta-data
            android:name="android.support.FILE_PROVIDER_PATHS"
            tools:replace="android:resource"
            android:resource="@xml/file_paths"/>
 </provider>

```
## 添加依赖
```yaml
dependencies:
  sr_upgrade: ^0.0.2
```

## 使用
- 引入
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

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String step = '0.00';

  _upgrade() {
    SrUpgrade.upgrade(
        'https://dldir1.qq.com/weixin/android/weixin806android1900_arm64.apk',
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
