import 'package:flutter/material.dart';
import 'package:my_wallet/view/core/colors.dart';

class ChartNoDataWidget extends StatelessWidget {
  const ChartNoDataWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(
        child: Center(
            child: Text(
      'No data available !!',
      style: TextStyle(color: kRedColor),
    )));
  }
}
