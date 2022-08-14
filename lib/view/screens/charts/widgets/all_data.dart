import 'package:flutter/material.dart';
import 'package:my_wallet/view/screens/charts/functions/all_chart_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AllChartWidget extends StatelessWidget {
  const AllChartWidget({
    Key? key,
    required this.transactionList,
  }) : super(key: key);

  final List<AllChartData> transactionList;

  @override
  Widget build(BuildContext context) {
    final List<AllChartData> chartData = transactionList;
    return Center(
        child: SfCircularChart(
      legend: Legend(
        isVisible: true,
        position: LegendPosition.right,
        isResponsive: true,
      ),
      series: <CircularSeries>[
        PieSeries<AllChartData, String>(
          dataSource: chartData,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          xValueMapper: (AllChartData data, _) => data.incomeOrExpense,
          yValueMapper: (AllChartData data, _) => data.amount,
          selectionBehavior: SelectionBehavior(enable: true),
        )
      ],
    ));
  }
}
