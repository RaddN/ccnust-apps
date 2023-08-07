import 'package:flutter/material.dart';

class BlankScreen extends StatefulWidget {
  final AppBar OurAppBar;
  final Drawer OurDrawer;

  const BlankScreen({super.key, required this.OurAppBar, required this.OurDrawer});

  @override
  State<BlankScreen> createState() => _BlankScreenState();
}

class _BlankScreenState extends State<BlankScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.OurAppBar,
      drawer: widget.OurDrawer,
      body: Center(child: Text("It's rainy here")),
    );
  }
}
