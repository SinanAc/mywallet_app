import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_wallet/controller/providers/edit_provider.dart';
import 'package:my_wallet/models/transaction_model.dart';
import 'package:my_wallet/view/core/category_list.dart';
import 'package:my_wallet/view/core/colors.dart';
import 'package:my_wallet/view/widgets/image_widget.dart';
import 'package:provider/provider.dart';

class EditScreen extends StatelessWidget {
  final TransactionModel data;
  const EditScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final editProvider = Provider.of<EditProvider>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Details'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ImageWidget(
                    imagePath: 'assets/images/editSvg.svg', heightSize: 0.15),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: editProvider.amountController,
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
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: kGreyColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.category_outlined),
                  ),
                  value: editProvider.categoryType,
                  items: editProvider.incomeOrExpense == 'Income'
                      ? CategoryLists().incomeCategories
                      : CategoryLists().expenseCategories,
                  hint: const Text('Category'),
                  onChanged: (value) {
                    editProvider.categoryType = value.toString();
                  },
                ),
                const SizedBox(
                  height: 7,
                ),
                SizedBox(
                  height: 60,
                  child: GestureDetector(
                    onTap: () async {
                      editProvider.selectDate(context);
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
                            DateFormat.yMMMMd().format(editProvider.showDate),
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
                    controller: editProvider.noteController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      label: Text('Note'),
                      prefixIcon: Icon(Icons.note_alt_outlined),
                      counterText: '',
                    ),
                    maxLength: 15),
                const SizedBox(
                  height: 7,
                ),
                ElevatedButton(
                  onPressed: () {
                    editProvider.updateSubmission(context, data.id!, data);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kIndigoColor,
                  ),
                  child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Update',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
