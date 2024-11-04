import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class TransferPage extends StatefulWidget {
  final double availableBalance;

  TransferPage({required this.availableBalance});

  @override
  _TransferPageState createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Wamd Transfer",
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
           
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              maxLength: 8, 
              style: const TextStyle(color: Color(0xFFF78F1E)), 
              decoration: const InputDecoration(
                labelText: "Enter 8-digit Phone Number",
                labelStyle: TextStyle(color: Color(0xFF0190D3)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF0190D3)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF0669A5)),
                ),
                counterText: "", 
              ),
            ),
            const SizedBox(height: 200),
            
          
            Row(
  
              mainAxisAlignment: MainAxisAlignment.start, 
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.right, 
                    style: const TextStyle(
                      color: Color(0xFFF78F1E), 
                      fontSize: 40,
                    ),
                    decoration: const InputDecoration(
                      hintText: "0.00",
                      hintStyle: TextStyle(color: Color(0xFFF78F1E)),
                      
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      border: InputBorder.none, 
                    ),
                  ),
                ),
              
                const Text(
                  "KWD",
                  style: TextStyle(
                    color: Color(0xFF0190D3),
                    fontSize: 40, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 160),
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
            const SizedBox(height: 300),
            ElevatedButton(
              onPressed: () {
                double transferAmount = double.tryParse(_amountController.text) ?? 0.0;

                if (transferAmount > widget.availableBalance) {
                  setState(() {
                    _errorMessage = "Insufficient funds. Available balance: ${widget.availableBalance} KWD";
                  });
                } else if (_phoneController.text.length != 8) {
                  setState(() {
                    _errorMessage = "Please enter a valid 8-digit phone number.";
                  });
                } else {
                  context.pop(transferAmount); 
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0669A5), 
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text(
                'Transfer',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
