import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_wallet/controller/transaction_list_provider.dart';
import 'package:my_wallet/view/core/colors.dart';
import 'package:my_wallet/view/screens/view_all/widgets/sorting_button.dart';
import 'package:my_wallet/view/screens/view_all/widgets/text_widget.dart';
import 'package:my_wallet/view/widgets/no_data_img.dart';
import 'package:provider/provider.dart';

class ViewAllScreen extends StatelessWidget {
  const ViewAllScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Overview'),
        centerTitle: true,
      ),
      body: Consumer<TransactionListProvider>(
          builder: (context, transactionData, Widget? _) {
        List<double> valueList = transactionData.totalStatistics();

        final data = transactionData.transactionList;
        return data.isEmpty
            ? const NoDataImage(
                image: 'assets/images/viewAllNoData.svg',
                text: 'No transaction data to display \nStart adding now')
            : Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            kIndigoColor,
                            kBlackCardColor,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          bottom: 15,
                        ),
                        child: Column(
                          children: [
                            const TitleText(
                              text: 'Total Balance',
                              color: kAmberColor,
                              fontSize: 15,
                            ),
                            TitleText(
                                text: '₹ ${valueList[0]}',
                                color: valueList[0] > 0
                                    ? kGreenColor
                                    : kRedColor,
                                fontSize: 18),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    const TitleText(
                                      text: 'Total Income',
                                      color: kAmberColor,
                                      fontSize: 15,
                                    ),
                                    TitleText(
                                      text: '₹ ${valueList[1]}',
                                      color: kWhiteColor,
                                      fontSize: 17,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const TitleText(
                                      text: 'Total Expense',
                                      color: kAmberColor,
                                      fontSize: 15,
                                    ),
                                    TitleText(
                                      text: '₹ ${valueList[2]}',
                                      color: kWhiteColor,
                                      fontSize: 17,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView(children: [
                        const SizedBox(height: 10),
                        const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            'All Transactions',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SortingButton(
                                  context: context,
                                  text: 'All',
                                  icon: FontAwesomeIcons.scaleBalanced),
                              SortingButton(
                                  context: context,
                                  text: 'Income',
                                  icon: FontAwesomeIcons.sackDollar),
                              SortingButton(
                                  context: context,
                                  text: 'Expense',
                                  icon: FontAwesomeIcons.handsBubbles),
                            ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SortingButton(
                                context: context,
                                text: 'Today',
                                icon: FontAwesomeIcons.calendarDay),
                            SortingButton(
                                context: context,
                                text: 'Last Week',
                                icon: FontAwesomeIcons.calendarWeek),
                            SortingButton(
                                context: context,
                                text: 'Last Month',
                                icon: FontAwesomeIcons.calendarDays),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8, top: 5),
                          child: Text('Custom',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SortingButton(
                                context: context,
                                text: 'Date',
                                icon: FontAwesomeIcons.calendarCheck),
                            SortingButton(
                                context: context,
                                text: 'Month',
                                icon: FontAwesomeIcons.calendarPlus),
                            SortingButton(
                                context: context,
                                text: 'Period',
                                icon: FontAwesomeIcons.squarePen),
                          ],
                        )
                      ]),
                    ),
                  ],
                ),
              );
      }),
    );
  }
}
