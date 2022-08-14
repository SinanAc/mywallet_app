import 'package:flutter/material.dart';
import 'package:my_wallet/view/screens/charts/functions/chart_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class IncomeExpenseChartWidget extends StatelessWidget {
  const IncomeExpenseChartWidget({
    Key? key,
    required this.transactionList,
  }) : super(key: key);

  final List<ChartData> transactionList;

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = transactionList;
    return Center(
        child: SfCircularChart(
      legend: Legend(
        isVisible: true,
        position: LegendPosition.right,
        isResponsive: true,
      ),
      series: <CircularSeries>[
        PieSeries<ChartData, String>(
          dataSource: chartData,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          xValueMapper: (ChartData data, _) => data.categoryTypeName,
          yValueMapper: (ChartData data, _) => data.amount,
          selectionBehavior: SelectionBehavior(enable: true),
        )
      ],
    ));
  }
}
