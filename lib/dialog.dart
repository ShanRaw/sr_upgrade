import 'package:flutter/material.dart';

class SrUpgradeDialog extends StatelessWidget with AppUpgradeDialogDelegate {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  onCancel() {
    // TODO: implement onCancel
    throw UnimplementedError('请实现onCancel方法');
  }

  @override
  onOk() {
    // TODO: implement onOk
    throw UnimplementedError('请实现onOk方法');
  }
}

abstract class AppUpgradeDialogDelegate {
  onOk();

  onCancel();
}
