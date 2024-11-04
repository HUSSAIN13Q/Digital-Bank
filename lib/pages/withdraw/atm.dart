import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BurganBankATMs extends StatefulWidget {
  @override
  State<BurganBankATMs> createState() => _BurganBankATMsState();
}

class _BurganBankATMsState extends State<BurganBankATMs> {
  final List<ATM> atms = [
    ATM(
      name: 'Head Office ATM',
      address: 'Sharq, Kuwait City',
      imageUrl: 'assets/img/HQ.jpeg',
    ),
    ATM(
      name: 'Avenues ATM',
      address: 'Avenues Mall, Al Rai',
      imageUrl: 'assets/img/AvenuesBranch.jpeg',
    ),
    ATM(
      name: 'Salmiya ATM',
      address: 'Salem Al Mubarak St, Salmiya',
      imageUrl: 'assets/img/SalmiyaBranch.jpeg',
    ),
    ATM(
      name: 'Jabriya ATM',
      address: 'Block 12, Jabriya',
      imageUrl: 'assets/img/JabriyaBranch.jpeg',
    ),
  ];

  double balance = 0.0;

  List<String> transactions = [];

  @override
  void initState() {
    super.initState();
    loadTransactionHistory();
  }

  //  load transaction history from shared preferences
  Future<void> loadTransactionHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      balance = prefs.getDouble('balance') ?? 0.0;
      transactions = prefs.getStringList('transactions') ?? [];
    });
  }

  // update balance and transaction history
  void updateTransaction(String type, double amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      if (type == 'Deposit') {
        balance += amount;
      } else if (type == 'Withdraw' || type == 'Transfer') {
        balance -= amount;
      }

      transactions.insert(0, "$type: $amount KWD");
    });

    prefs.setDouble('balance', balance);
    prefs.setStringList('transactions', transactions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/img/logo.png"),
        backgroundColor: const Color(0xFF0669A5),
      ),
      body: ListView.builder(
        itemCount: atms.length,
        itemBuilder: (context, index) {
          final atm = atms[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: const Color(0xFFFFFFFF),
            child: InkWell(
              onTap: () async {
                final withdrawAmount =
                    await context.push('/withdraw', extra: balance);
                if (withdrawAmount != null) {
                  updateTransaction('Withdraw', withdrawAmount as double);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(atm.imageUrl),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            atm.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0190D3),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            atm.address,
                            style: TextStyle(
                              fontSize: 16,
                              color: const Color(0xFF4A494B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      backgroundColor: const Color(0xFFFFFFFF),
    );
  }
}

class ATM {
  final String name;
  final String address;
  final String imageUrl;

  ATM({
    required this.name,
    required this.address,
    required this.imageUrl,
  });
}
