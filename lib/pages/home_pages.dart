import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uangkoo/models/database.dart';
import 'package:uangkoo/models/transaction_with_category.dart';

class HomePages extends StatefulWidget {
  final DateTime selectedDate;
  const HomePages({super.key, required this.selectedDate});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  final AppDatabase database = AppDatabase();
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
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Icon(Icons.download, color: Colors.green),
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
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Icon(Icons.upload, color: Colors.red),
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
        StreamBuilder<List<TransactionWithCategory>>(
            stream: database.getTransactionByDateRepo(widget.selectedDate),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasData) {
                  if (snapshot.data!.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Card(
                            elevation: 10,
                            child: ListTile(
                              trailing: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.delete),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(Icons.edit)
                                ],
                              ),
                              title: Text("Rp. " +
                                  snapshot.data![index].transaction.amount
                                      .toString()),
                              subtitle: Text(
                                  snapshot.data![index].category.name +
                                      "(" +
                                      snapshot.data![index].transaction.name +
                                      ")"),
                              leading: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8)),
                                  child:
                                      (snapshot.data![index].category.id == 2)
                                          ? const Icon(Icons.upload,
                                              color: Colors.red)
                                          : const Icon(Icons.download,
                                              color: Colors.green)),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('No Data'),
                    );
                  }
                } else {
                  return const Center(
                    child: Text("NO data"),
                  );
                }
              }
            })

        // list transaksi
      ],
    )));
  }
}
