import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class SiakProgressDialog extends StatelessWidget {
  final String msg;
  final int max;
  final ProgressType progressType;

  SiakProgressDialog({
    required this.msg,
    required this.max,
    required this.progressType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProgressDialog pd = ProgressDialog(context: context);

    return Container(
      child: CircularProgressIndicator(),
    );
  }

  Future<void> _showProgress(ProgressDialog pd) async {
    pd.show(
      max: max,
      msg: msg,
      progressType: progressType,
    );

    // Simulate a delay
    await Future.delayed(Duration(seconds: 10));

    pd.close();
  }
}
