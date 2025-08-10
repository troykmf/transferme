import 'package:flutter/material.dart';

class WalletsPage extends StatefulWidget {
  const WalletsPage({super.key});

  @override
  State<WalletsPage> createState() => _WalletsPageState();
}

class _WalletsPageState extends State<WalletsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wallets')),
      body: Center(
        child: Text(
          'This is the Wallets Page',
          // style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }
}
