// ignore_for_file: non_constant_identifier_names
// import 'dart:convert';
import 'dart:convert';

import 'package:ccnust/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bkash/flutter_bkash.dart';
import 'dart:developer' as dev;

import 'package:quickalert/quickalert.dart';
class PaymentPage extends StatefulWidget {
  final AppBar OurAppBar;
  final Drawer OurDrawer;
  final String email;
  /// Number Keyboard should added
  const PaymentPage({super.key, required this.OurAppBar, required this.OurDrawer,required this.email});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}
class _PaymentPageState extends State<PaymentPage> {
  bool isLoading = false;
  final GlobalKey<BkashPaymentState> _bkashKey = GlobalKey<BkashPaymentState>();
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWeight = MediaQuery.of(context).size.height;
    var isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      appBar: widget.OurAppBar,
      drawer: widget.OurDrawer,
      body: ListView(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: screenHeight,
                color: Colors.white,
              ),
              Positioned(
                top:isKeyboardOpen==0? -56:-190,
                height: screenHeight,
                left: 10,
                width: screenWeight/2-50,
                child: BkashPayment(
                  key: _bkashKey,
                  accessToken: widget.email,
                  isSandbox: false,amount: '20',
                  currency: 'BDT',
                  refNo: widget.email,
                  createBKashUrl: 'https://merchantserver.sandbox.bka.sh/api/checkout/v1.2.0-beta/payment/create',
                  executeBKashUrl: 'https://merchantserver.sandbox.bka.sh/api/checkout/v1.2.0-beta/payment/execute',
                  intent: 'sale',
                  scriptUrl: 'https://scripts.sandbox.bka.sh/versions/1.2.0-beta/checkout/bKash-checkout-sandbox.js',
                  paymentStatus: (status, data) {
                    /// Close Keyboard
                    FocusManager.instance.primaryFocus?.unfocus();
                dev.log('return status => $status');
                dev.log('return data => $data');
                /// when payment success
                if (status == 'paymentSuccess') {
                if (data['transactionStatus'] == 'Completed') {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    onConfirmBtnTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage(tabbarpos: 0),)),
                    text: 'Transaction Completed Successfully! Transaction id: ${data["trxID"]} paymentID: ${data["paymentID"]}',
                  );
                  // _showSnackbar("Payment Success");
                  // Style.basicToast('Payment Success');
                }
                }

                /// when payment failed
                else if (status == 'paymentFailed') {
                if (data.isEmpty) {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: 'Oops...',
                    onConfirmBtnTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage(tabbarpos: 0),)),
                    text: 'Payment Failed',
                  );
                  // _showSnackbar("Payment Failed");
                  // Style.errorToast('Payment Failed');
                } else if (data[0]['errorMessage'].toString() != 'null'){
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: 'Oops...',
                    onConfirmBtnTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage(tabbarpos: 0),)),
                    text: 'Payment Failed ${data[0]['errorMessage']}',
                  );
                  // _showSnackbar("Payment Failed ${data[0]['errorMessage']}");
                  // Style.errorToast("Payment Failed ${data[0]['errorMessage']}");
                } else {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: 'Oops...',
                    onConfirmBtnTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage(tabbarpos: 0),)),
                    text: 'Payment Failed',
                  );
                  // _showSnackbar("Payment Failed");
                  // Style.errorToast("Payment Failed");
                }
                }

                /// when payment on error
                else if (status == 'paymentError') {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: 'Oops...',
                    onConfirmBtnTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage(tabbarpos: 0),)),
                    text: jsonDecode(data['responseText'])['error'],
                  );
                // _showSnackbar(jsonDecode(data['responseText'])['error']);
                // Style.errorToast(jsonDecode(data['responseText'])['error']);
                }

                /// when payment close on demand closed the windows
                else if (status == 'paymentClose') {
                if (data == 'closedWindow') {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: 'Oops...',
                    onConfirmBtnTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage(tabbarpos: 0),)),
                    text: 'Failed to payment, closed screen',
                  );
                  // _showSnackbar("Failed to payment, closed screen");
                  // Style.errorToast('');
                } else if (data == 'scriptLoadedFailed') {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: 'Oops...',
                    onConfirmBtnTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage(tabbarpos: 0),)),
                    text: 'Payment screen loading failed',
                  );
                  // _showSnackbar("Payment screen loading failed");
                  // Style.errorToast('');
                }
                }
                /// back to screen to pop()
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage(tabbarpos: 0),));
    },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  /// show snack-bar with message
  // void _showSnackbar(String message) => ScaffoldMessenger.of(context)
  //   ..hideCurrentSnackBar()
  //   ..showSnackBar(SnackBar(content: Text(message)));
}