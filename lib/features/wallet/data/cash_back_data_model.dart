import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CashBackDataModel {
  final IconData icon;
  final String title;
  final String time;
  final String amount;
  final Color color;

  const CashBackDataModel({
    required this.icon,
    required this.title,
    required this.time,
    required this.amount,
    required this.color,
  });
}

final List<CashBackDataModel> cashBackDataList = [
  CashBackDataModel(
    icon: FontAwesomeIcons.wallet,
    title: 'Purchase',
    time: '4.34 PM',
    amount: '\$5.00',
    color: Colors.green,
  ),
  CashBackDataModel(
    icon: FontAwesomeIcons.gift,
    title: 'Referral',
    time: '9.00 AM',
    amount: '\$2.50',
    color: Colors.blue,
  ),
  CashBackDataModel(
    icon: FontAwesomeIcons.tag,
    title: 'Lend share Promotion',
    time: '12.30 PM',
    amount: '\$1.75',
    color: Colors.orange,
  ),
  CashBackDataModel(
    icon: FontAwesomeIcons.coins,
    title: 'Loyalty Program',
    time: '3.15 PM',
    amount: '\$3.25',
    color: Colors.purple,
  ),
  CashBackDataModel(
    icon: FontAwesomeIcons.moneyBillWave,
    title: 'Special Offer',
    time: '8.45 AM',
    amount: '\$4.00',
    color: Colors.red,
  ),
  CashBackDataModel(
    icon: FontAwesomeIcons.receipt,
    title: 'Jumia Seasonal Sale',
    time: '11.20 AM',
    amount: '\$6.50',
    color: Colors.teal,
  ),
  CashBackDataModel(
    icon: FontAwesomeIcons.creditCard,
    title: 'UBA Credit Card Usage',
    time: '9.30 AM',
    amount: '\$2.00',
    color: Colors.cyan,
  ),
  CashBackDataModel(
    icon: FontAwesomeIcons.cartShopping,
    title: 'Temu Online Shopping Mall',
    time: '1.23 PM',
    amount: '\$3.75',
    color: Colors.amber,
  ),
];
