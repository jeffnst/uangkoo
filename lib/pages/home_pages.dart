import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: SafeArea(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // dahsboard total incaome dan expense
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(16)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      child: Icon(Icons.download, color: Colors.green),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Income",
                          style: GoogleFonts.montserrat(
                              color: Colors.white, fontSize: 12),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Rp. 3.800.000",
                            style: GoogleFonts.montserrat(
                                color: Colors.white, fontSize: 14)),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      child: Icon(Icons.upload, color: Colors.red),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Expense",
                          style: GoogleFonts.montserrat(
                              color: Colors.white, fontSize: 12),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Rp. 3.800.000",
                            style: GoogleFonts.montserrat(
                                color: Colors.white, fontSize: 14)),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text("Transaction",
              style: GoogleFonts.montserrat(
                  fontSize: 15, fontWeight: FontWeight.bold)),
        ),

        // list transaksi
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Card(
            elevation: 10,
            child: ListTile(
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.delete),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.edit)
                ],
              ),
              title: Text("Rp.20.000"),
              subtitle: Text("makan siang"),
              leading: Container(
                child: Icon(Icons.upload, color: Colors.red),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Card(
            elevation: 10,
            child: ListTile(
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.delete),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.edit)
                ],
              ),
              title: Text("Rp.20.000.000"),
              subtitle: Text("Gaji Bulanan"),
              leading: Container(
                child: Icon(Icons.download, color: Colors.green),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
        )
      ],
    )));
  }
}
