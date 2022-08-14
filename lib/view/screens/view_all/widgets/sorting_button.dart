import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_wallet/view/core/colors.dart';
import 'package:my_wallet/view/core/functions.dart';
import 'package:my_wallet/view/screens/view_all/functions/view_all_functions.dart';
import 'package:my_wallet/view/screens/view_all/widgets/all_transactions.dart';
import 'package:my_wallet/view/screens/view_all/widgets/income_expense_list.dart';
import 'package:my_wallet/view/screens/view_all/widgets/last_week_and_month.dart';
import 'package:my_wallet/view/screens/view_all/widgets/today_list.dart';

class SortingButton extends StatelessWidget {
  const SortingButton({
    Key? key,
    required this.context,
    required this.text,
    required this.icon,
  }) : super(key: key);

  final BuildContext context;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.width * 0.3,
        child: Card(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              icon,
              color: kBlueColor,
              size: MediaQuery.of(context).size.height * 0.035,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.005,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
            )
          ],
        )),
      ),
      onTap: () {
        text == 'All'
            ? CoreFunctions.pushToNext(context, const AllTransactionScreen())
            : text == 'Income'
                ? CoreFunctions.pushToNext(
                    context,
                    const IncomeAndExpenseTransactionsList(
                      incomeExpense: 'Income',
                    ))
                : text == 'Expense'
                    ? CoreFunctions.pushToNext(
                        context,
                        const IncomeAndExpenseTransactionsList(
                          incomeExpense: 'Expense',
                        ))
                    : text == 'Today'
                        ? CoreFunctions.pushToNext(
                            context, const TodayTransactionsList())
                        : text == 'Last Week'
                            ? CoreFunctions.pushToNext(
                                context,
                                const LastWeekAndMonthList(
                                    days: 7, text: 'Last Week'))
                            : text == 'Last Month'
                                ? CoreFunctions.pushToNext(
                                    context,
                                    const LastWeekAndMonthList(
                                        days: 30, text: 'Last Month'))
                                : text == 'Date'
                                    ? ViewAllFunctions.selectDate(context)
                                    : text == 'Month'
                                        ? ViewAllFunctions.selectMonth(
                                            context: context, locale: 'en')
                                        : ViewAllFunctions.selectPeriod(
                                            context);
      },
    );
  }
}
