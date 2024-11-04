import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WithdrawPage extends StatefulWidget {
  final double availableBalance;

  WithdrawPage({required this.availableBalance});

  @override
  _WithdrawPageState createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  TextEditingController _amountController = TextEditingController();
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Withdraw",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF0669A5), 
      ),
      backgroundColor: Colors.white, 
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                const Text(
                  "KWD",
                  style: TextStyle(
                    color: Color(0xFF0190D3),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Color(0xFFF78F1E),
                    fontSize: 28), // White text for the entered amount
                    decoration: const InputDecoration(
                      hintText: "Enter Amount",
                      hintStyle: TextStyle(color: Colors.white54),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF0190D3)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF0669A5)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                double withdrawAmount = double.tryParse(_amountController.text) ?? 0.0;

                if (withdrawAmount > widget.availableBalance) {
                  setState(() {
                    _errorMessage = "Insufficient funds. Available balance: ${widget.availableBalance} KWD";
                  });
                } else {
                 
                  context.pop(withdrawAmount);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0669A5), 
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text(
                'Withdraw',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  buildATMCard('Head Office ATM', 'Sharq, Kuwait City', 'assets/img/HQ.jpeg'),
                  buildATMCard('Avenues ATM', 'Avenues Mall, Al Rai', 'assets/img/AvenuesBranch.jpeg'),
                  buildATMCard('Salmiya ATM', 'Salem Al Mubarak St, Salmiya', 'assets/img/SalmiyaBranch.jpeg'),
                  buildATMCard('Jabriya ATM', 'Block 12, Jabriya', 'assets/img/JabriyaBranch.jpeg'),
                  buildATMCard('Fahaheel ATM', 'Fahaheel, Block 7', 'assets/img/FahaheelBranch.jpeg'),
                  buildATMCard('Farwaniya ATM', 'Farwaniya Block 4, Street 105', 'assets/img/FarwaniyaBranch.jpg'),
                  buildATMCard('Hawalli ATM', 'Hawalli Block 6, Beirut Street', 'assets/img/HawalliBranch.JPG'),
                  buildATMCard('Ahmadi ATM', 'Block 1, Ahmadi, Kuwait', 'assets/img/AhmadiBranch.jpg'),
                  buildATMCard('Mishref ATM', 'Mishref, Block 4, Kuwait', 'assets/img/MishrefBranch.jpeg'),
                  buildATMCard('Adailiya ATM', 'Adailiya, Block 3, Kuwait', 'assets/img/AdailiyaBranch.jpeg'),
                  buildATMCard('Sabah Al-Salem ATM', 'Sabah Al-Salem, Block 2, Kuwait', 'assets/img/SalmiyaBranch.jpeg'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildATMCard(String name, String address, String imageUrl) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(imageUrl),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    address,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
