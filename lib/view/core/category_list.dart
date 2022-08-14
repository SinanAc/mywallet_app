import 'package:flutter/material.dart';

class CategoryLists {
  CategoryLists.internal();
  static CategoryLists instance = CategoryLists.internal();
  factory CategoryLists() {
    return instance;
  }
  List<DropdownMenuItem<String>> get incomeCategories {
    List<DropdownMenuItem<String>> incomeMenu = const [
      DropdownMenuItem(value: 'Salary', child: Text('Salary')),
      DropdownMenuItem(value: 'Business', child: Text('Business')),
      DropdownMenuItem(value: 'Freelance', child: Text('Freelance')),
      DropdownMenuItem(value: 'Interest', child: Text('Interest')),
      DropdownMenuItem(value: 'Stocks', child: Text('Stocks')),
      DropdownMenuItem(value: 'Commission', child: Text('Commission')),
      DropdownMenuItem(value: 'Extra', child: Text('Extra')),
    ];
    return incomeMenu;
  }

  List<DropdownMenuItem<String>> get expenseCategories {
    List<DropdownMenuItem<String>> expenseMenu = const [
      DropdownMenuItem(value: 'Food', child: Text('Food')),
      DropdownMenuItem(value: 'Transportation', child: Text('Transportation')),
      DropdownMenuItem(value: 'Shopping', child: Text('Shopping')),
      DropdownMenuItem(value: 'Education', child: Text('Education')),
      DropdownMenuItem(value: 'EMI', child: Text('EMI')),
      DropdownMenuItem(value: 'Utilities', child: Text('Utilities')),
      DropdownMenuItem(value: 'Internet', child: Text('Internet')),
      DropdownMenuItem(value: 'Entertainment', child: Text('Entertainment')),
      DropdownMenuItem(value: 'Health Care', child: Text('Health Care')),
      DropdownMenuItem(value: 'Others', child: Text('Others')),
    ];
    return expenseMenu;
  }

  List<DropdownMenuItem<String>> get chartCategories {
    List<DropdownMenuItem<String>> chartMenu = const [
      DropdownMenuItem(value: 'Last 30 days', child: Text('Last 30 days')),
      DropdownMenuItem(value: 'Last 100 days', child: Text('Last 100 days')),
      DropdownMenuItem(value: 'All', child: Text('All')),
    ];
    return chartMenu;
  }
}
