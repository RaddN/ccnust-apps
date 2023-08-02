// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
class PaymentPage extends StatefulWidget {
  final AppBar OurAppBar;
  final Drawer OurDrawer;

  const PaymentPage({super.key, required this.OurAppBar, required this.OurDrawer});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.OurAppBar,
      drawer: widget.OurDrawer,
    );
  }
}
