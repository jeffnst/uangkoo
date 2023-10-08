import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:uangkoo/models/database.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  bool isExpense = true;
  late int type;
  final AppDatabase database = AppDatabase();
  // List<String> list = ['Makan', 'Transportasi', 'Sedekah'];
  //late String dropDownValue = list.first;
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  Category? selectedCategory;
  Future insert(
      int amount, DateTime date, String nameDetail, int categoryId) async {
    DateTime now = DateTime.now();

    final row = await database.into(database.transactions).insertReturning(
        TransactionsCompanion.insert(
            name: nameDetail,
            category_id: categoryId,
            transaction_date: date,
            amount: amount,
            createdAt: now,
            updatedAt: now));
    print("insert data$row");
  }

  Future<List<Category>> getAllCategory(int type) async {
    return await database.getAllCategoryRepo(type);
  }

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Switch(
                  value: isExpense,
                  onChanged: (bool value) {
                    setState(() {
                      isExpense = value;
                      type = (isExpense) ? 2 : 1;
                      selectedCategory = null;
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), labelText: "Amount"),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Category",
                style: GoogleFonts.montserrat(fontSize: 16),
              ),
            ),
            FutureBuilder<List<Category>>(
                future: getAllCategory((isExpense == true) ? 2 : 1),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isNotEmpty) {
                        selectedCategory ??= snapshot.data!.first;

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: DropdownButton<Category>(
                              value: (selectedCategory == null)
                                  ? snapshot.data!.first
                                  : selectedCategory,
                              isExpanded: true,
                              icon: const Icon(Icons.arrow_downward),
                              items: snapshot.data!.map((Category item) {
                                return DropdownMenuItem<Category>(
                                    value: item, child: Text(item.name));
                              }).toList(),
                              onChanged: (Category? value) {
                                setState(() {
                                  selectedCategory = value;
                                });
                              }),
                        );
                      } else {
                        return const Center(
                          child: Text(" ada kosong "),
                        );
                      }
                    } else {
                      return const Center(child: Text("tidak ada data"));
                    }
                  }
                }),

            /*  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DropdownButton<String>(
                  value: dropDownValue,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_downward),
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                        value: value, child: Text(value));
                  }).toList(),
                  onChanged: (String? value) {}),
            ), */
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                readOnly: true,
                controller: dateController,
                decoration: const InputDecoration(labelText: "Enter date"),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2024));

                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);

                    dateController.text = formattedDate;
                  }
                },
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: detailController,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), labelText: "Detail"),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  insert(
                      int.parse(amountController.text),
                      DateTime.parse(dateController.text),
                      detailController.text,
                      selectedCategory!.id);
                  Navigator.pop(context, true);

                  /// print('amount : ' + amountController.text.toString());
                  // print('date : ' + dateController.text.toString());
                  // print('detail : ' + detailController.text.toString());
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                ),
                child: Text(
                  'Save',
                  style: GoogleFonts.montserrat(color: Colors.white),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
