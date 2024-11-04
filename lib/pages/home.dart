import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:burgan_api/pages/deposit.dart';
import 'package:burgan_api/pages/trasfer.dart';
import 'package:burgan_api/pages/withdraw/atm.dart';
import 'package:burgan_api/pages/balance_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double balance = 0.0;
  List<String> transactions = [];

  final String accountNumber = 'XXXX XXXX XXXX 1234'; // Example account number
  final String accountHolderName = 'KHADEEJAH ISMAEIL'; // Example name

  @override
  void initState() {
    super.initState();
    loadTransactionHistory(); // Load transaction history on startup
  }

  // Function to load transaction history from shared preferences
  Future<void> loadTransactionHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      balance = prefs.getDouble('balance') ?? 0.0;
      transactions = prefs.getStringList('transactions') ?? [];
    });
  }

  // Function to update balance and transaction history
  void updateTransaction(String type, double amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      if (type == 'Deposit') {
        balance += amount; // Add deposit amount to balance
      } else if (type == 'Withdraw' || type == 'Transfer') {
        balance -= amount; // Subtract amount for withdraw or transfer
      }

      // Record the transaction in history
      transactions.insert(0, "$type: $amount KWD");
    });

    // Save updated balance and transactions to shared preferences
    prefs.setDouble('balance', balance);
    prefs.setStringList('transactions', transactions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 50, 50, 50),
        title: Row(
          children: [
            Image.asset(
              'assets/img/logo.png',
              height: 40,
              width: 40,
            ),
            SizedBox(width: 10),
            Text('Home Page', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Color.fromARGB(255, 191, 191, 191),
              elevation: 10,
              shadowColor: const Color.fromARGB(255, 0, 0, 0),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Available Balance:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '${balance.toStringAsFixed(2)} KWD',
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 50, 50, 50),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          accountNumber,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          accountHolderName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 30),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Image.asset(
                            'assets/img/mc.png',
                            width: 60,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Image.asset(
                      'assets/img/logo.png',
                      width: 60,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.white,
                elevation: 10,
                shadowColor: Colors.black45,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Transaction History',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0069AA),
                        ),
                      ),
                      Divider(color: Colors.grey),
                      Expanded(
                        child: transactions.isEmpty
                            ? Center(
                                child: Text(
                                  'No transactions yet',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              )
                            : ListView.builder(
                                itemCount: transactions.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: Icon(
                                      transactions[index].contains('Deposit')
                                          ? Icons.add_circle_outline
                                          : transactions[index]
                                                  .contains('Transfer')
                                              ? Icons.swap_horiz
                                              : Icons.remove_circle_outline,
                                      color: transactions[index]
                                              .contains('Deposit')
                                          ? Color(0xFFF78F1E)
                                          : transactions[index]
                                                  .contains('Transfer')
                                              ? Colors.blue
                                              : Colors.red,
                                    ),
                                    title: Text(
                                      transactions[index],
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Buttons to simulate deposit, withdraw, and transfer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final depositAmount =
                        await context.push('/deposit', extra: balance);
                    if (depositAmount != null) {
                      updateTransaction(
                          'Deposit',
                          depositAmount
                              as double); // Update balance and transaction history
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color(0xFFF78F1E), // Orange for Deposit button
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Deposit',
                    style: TextStyle(color: Colors.white), // White text
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final withdrawAmount =
                        await context.push('/withdraw', extra: balance);
                    if (withdrawAmount != null) {
                      updateTransaction(
                          'Withdraw',
                          withdrawAmount
                              as double); // Update balance and transaction history
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color(0xFF0069AA), // Dark Blue for Withdraw button
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Withdraw',
                    style: TextStyle(color: Colors.white), // White text
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final transferAmount =
                        await context.push('/transfer', extra: balance);
                    if (transferAmount != null) {
                      updateTransaction(
                          'Transfer',
                          transferAmount
                              as double); // Update balance and transaction history
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(
                        255, 50, 50, 50), // Blue for Transfer button
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Transfer',
                    style: TextStyle(color: Colors.white), // White text
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
