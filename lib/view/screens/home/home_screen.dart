import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_wallet/controller/home_provider.dart';
import 'package:my_wallet/controller/transaction_list_provider.dart';
import 'package:my_wallet/view/core/colors.dart';
import 'package:my_wallet/view/screens/view_all/widgets/text_widget.dart';
import 'package:my_wallet/view/widgets/all_transactions.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeProvider>(context, listen: false).getSharedPrefName();
    });
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Wallet'),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
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
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TitleText(
                                text: 'Hai',
                                color: kAmberColor,
                                fontSize: 15,
                              ),
                              TitleText(
                                  text: Provider.of<HomeProvider>(context)
                                      .userName,
                                  color: kWhiteColor,
                                  fontSize: 18)
                            ],
                          ),
                          SvgPicture.asset(
                            'assets/images/masterCardLogo.svg',
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: MediaQuery.of(context).size.height * 0.08,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const TitleText(
                        text: 'Your Total Balance',
                        color: kAmberColor,
                        fontSize: 15,
                      ),
                      Consumer<TransactionListProvider>(
                          builder: (context, transactionData, Widget? _) {
                        List<double> valueList =
                            transactionData.totalStatistics();
                        return TitleText(
                          text: '₹ ${valueList[0]}',
                          color: valueList[0] > 0 ? kGreenColor : kRedColor,
                          fontSize: 18,
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 12),
              child: TitleText(
                text: 'All Transactions',
                color: kBlackColor,
                fontSize: 15,
              ),
            ),
            const Expanded(child: AllTransactionList(isHomeScreen: true)),
          ],
        )));
  }
}
