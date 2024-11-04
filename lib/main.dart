import 'package:burgan_api/login.dart/signup.dart';
import 'package:burgan_api/pages/trasfer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:burgan_api/pages/withdraw/withdraw.dart';
import 'package:burgan_api/pages/home.dart';
import 'package:burgan_api/pages/deposit.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:burgan_api/pages/balance_provider.dart';
import 'package:burgan_api/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BalanceProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => RegisterPage(),
        ),
        // GoRoute(
        //   path: '/register',
        //   builder: (context, state) => RegisterPage(),
        // ),
        GoRoute(
          path: '/home',
          builder: (context, state) => HomePage(),
        ),
        GoRoute(
          path: '/deposit',
          builder: (context, state) =>
              DepositPage(balance: state.extra as double),
        ),
        GoRoute(
          path: '/transfer',
          builder: (context, state) {
            final balance = state.extra as double?;
            if (balance == null) {
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Error: Balance not provided."),
                    backgroundColor: Colors.red,
                  ),
                );
              });
              return Scaffold();
            }
            return TransferPage(availableBalance: balance);
          },
        ),
        GoRoute(
          path: '/withdraw',
          builder: (context, state) {
            final balance = state.extra as double?;
            if (balance == null) {
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Error: Balance not provided."),
                    backgroundColor: Colors.red,
                  ),
                );
              });
              return Scaffold(); // Empty scaffold for error notification
            }
            return WithdrawPage(availableBalance: balance);
          },
        ),
      ],
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
