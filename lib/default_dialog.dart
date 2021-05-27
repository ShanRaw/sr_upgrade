import 'package:app_upgrade/dialog.dart';
import 'package:app_upgrade/modal.dart';
import 'package:flutter/material.dart';

import 'app_upgrade.dart';

class AppUpgradeDialogDefault extends AppUpgradeDialog {
  final AppUpgradeModel info;

  AppUpgradeDialogDefault({required this.info});

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
