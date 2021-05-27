import 'package:flutter/material.dart';
import 'package:app_upgrade/app_upgrade.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            AppUpgrade.show(context,
                downloadCloseForUpgradeWindow: true,
                info: AppUpgradeModel(
                    apkDownloadUrl:
                        'https://wbdear.oss-cn-beijing.aliyuncs.com/one-book-school-apk/school_v1.0.0%2Bhotfix.2.apk',
                    title: '测试升级',
                    contents: [
                      '1.修复一直bug',
                      '2.修复已知问题',
                    ]), progressCallback: (int count, int total) {
              setState(() {
                step = (count / total * 100).toStringAsFixed(2);
              });
            });
          },
          child: Column(
            children: [
              Container(
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
              Text('当前下载进度$step%')
            ],
          ),
        ),
      ),
    );
  }
}
