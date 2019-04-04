import 'package:flutter/material.dart';
import 'package:gerenciador_financeiro/screens/WalletsScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1;
  final _itemsList = [WalletScreen(), WalletScreen(), WalletScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _itemsList[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet), title: Text("Contas")),
          BottomNavigationBarItem(
              icon: Icon(Icons.attach_money), title: Text("Transações")),
          BottomNavigationBarItem(
              icon: Icon(Icons.list), title: Text("Resumo")),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
