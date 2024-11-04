import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF0669A5),
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 100.0,
                backgroundImage: AssetImage('assets/img/w.png'),
              ),
              SizedBox(height: 20),

              Text(
                "Abdulwahab Abdal",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0669A5),
                ),
              ),
              SizedBox(height: 10),

              // Email
              Text(
                'Hussainalsaffar18@gmail.com',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF4A494B),
                ),
              ),
              SizedBox(height: 30),

              Divider(
                color: Color(0xFF0190D3),
                thickness: 1.5,
                indent: 50,
                endIndent: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
