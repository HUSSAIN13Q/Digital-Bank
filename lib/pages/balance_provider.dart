import 'package:flutter/material.dart';

class BalanceProvider extends ChangeNotifier {
  double _balance = 100.00;

  double get balance => _balance;

  void addMoney(double amount) {
    _balance += amount;
    notifyListeners();
  }
}
