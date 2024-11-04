import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DepositPage extends StatefulWidget {
  final double balance;

  DepositPage({required this.balance});

  @override
  _DepositPageState createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Deposit",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF0669A5),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Color(0xFFF78F1E),
                      fontSize: 28,
                    ),
                    decoration: const InputDecoration(
                      hintText: "0.00",
                      hintStyle: TextStyle(color: Colors.white54),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  "KWD",
                  style: TextStyle(
                    color: Color(0xFF0190D3),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 160),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                double depositAmount =
                    double.tryParse(_amountController.text) ?? 0.0;
                context.pop(depositAmount);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0669A5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text(
                'Deposit',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
