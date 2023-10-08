import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:uangkoo/pages/category_pages.dart';
import 'package:uangkoo/pages/home_pages.dart';
import 'package:uangkoo/pages/transaction_pages.dart';

class MainPages extends StatefulWidget {
  const MainPages({super.key});

  @override
  State<MainPages> createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
  late DateTime selectedDate;
  late List<Widget> _children;
  late int currentIndex;

  /* void onTapTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  } */

  void updateView(int index, DateTime? date) {
    setState(() {
      if (date != null) {
        selectedDate = DateTime.parse(DateFormat('yyyy-MM-dd').format(date));
      }

      currentIndex = index;
      _children = [
        HomePages(
          selectedDate: selectedDate,
        ),
        const CategoryPage()
      ];
    });
  }

  @override
  void initState() {
    setState(() {
      updateView(0, DateTime.now());
      selectedDate = DateTime.now();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (currentIndex == 0)
          ? CalendarAppBar(
              onDateChanged: (value) {
                setState(() {
                  // print("selected date = " + value.toString());
                  selectedDate = value;
                  updateView(0, selectedDate);
                });
              },
              accent: Colors.green,
              backButton: false,
              locale: 'id',
              firstDate: DateTime.now().subtract(const Duration(days: 140)),
              lastDate: DateTime.now(),
            )
          : PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child: Container(
                  child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
                child: Text(
                  "Categories",
                  style: GoogleFonts.montserrat(fontSize: 20),
                ),
              ))),
      floatingActionButton: Visibility(
        visible: (currentIndex == 0) ? true : false,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (context) => const TransactionPage()))
                .then((value) {
              setState(() {});
            });
          },
          backgroundColor: Colors.blue,
          shape: const RoundedRectangleBorder(
            // <= Change BeveledRectangleBorder to RoundedRectangularBorder
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(10.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: _children[currentIndex],
      bottomNavigationBar: BottomAppBar(
        color: Colors.green,
        // this creates a notch in the center of the bottom bar
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(
                Icons.home,
                color: Colors.white,
              ),
              onPressed: () {
                updateView(0, DateTime.now());
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.people,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            const SizedBox(
              width: 20,
            ),
            IconButton(
              icon: const Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {
                updateView(1, null);
              },
            ),
          ],
        ),
      ),
    );
  }
}
