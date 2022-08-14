import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_wallet/controller/add_provider.dart';
import 'package:my_wallet/view/core/category_list.dart';
import 'package:my_wallet/view/core/colors.dart';
import 'package:my_wallet/view/widgets/image_widget.dart';
import 'package:provider/provider.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Transactions'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Consumer<AddProvider>(
                builder: (ctx, addProvider, Widget? child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ImageWidget(
                      imagePath: 'assets/images/addSvg.svg', heightSize: 0.15),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Radio(
                              value: 'Income',
                              groupValue: addProvider.incomeOrExpense,
                              onChanged: (value) {
                                addProvider.incomeOrExpense = 'Income';
                                addProvider.categoryType = null;
                              }),
                          const Text('Income'),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                              value: 'Expense',
                              groupValue: addProvider.incomeOrExpense,
                              onChanged: (value) {
                                addProvider.incomeOrExpense = 'Expense';
                                addProvider.categoryType = null;
                              }),
                          const Text('Expense'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.009),
                  TextField(
                    controller: addProvider.amountController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      label: Text('Amount'),
                      prefixIcon: Icon(Icons.attach_money),
                      counterText: '',
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.category_outlined),
                    ),
                    value: addProvider.categoryType,
                    hint: const Text('Category'),
                    items: addProvider.incomeOrExpense == 'Income'
                        ? CategoryLists.instance.incomeCategories
                        : CategoryLists.instance.expenseCategories,
                    onChanged: (value) {
                      addProvider.categoryType = value;
                    },
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  SizedBox(
                    height: 58,
                    child: GestureDetector(
                      onTap: () async {
                        Provider.of<AddProvider>(context, listen: false)
                            .selectDate(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: kGreyColor,
                            width: 0.9,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.calendar_today_outlined,
                              color: kGreyColor,
                              size: 23,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              DateFormat.yMMMMd().format(addProvider.showDate),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  TextFormField(
                    controller: addProvider.noteController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        label: Text('Note'),
                        prefixIcon: Icon(Icons.note_alt_outlined),
                        counterText: ''),
                    maxLength: 15,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      addProvider.submission(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: kIndigoColor,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Submit',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
