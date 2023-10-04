import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  bool isExpense = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Transaction",
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Row(
              children: [
                Switch(
                  value: isExpense,
                  onChanged: (bool value) {
                    setState(() {
                      isExpense = value;
                    });
                  },
                  inactiveThumbColor: Colors.green,
                  inactiveTrackColor: Colors.green[200],
                  activeColor: Colors.red,
                ),
                Text(
                  (isExpense) ? "Expense" : "Income",
                  style:
                      GoogleFonts.montserrat(fontSize: 16, color: Colors.black),
                )
              ],
            ),
          ],
        )),
      ),
    );
  }
}
