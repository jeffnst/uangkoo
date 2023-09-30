import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:flutter/material.dart';

class MainPages extends StatefulWidget {
  const MainPages({super.key});

  @override
  State<MainPages> createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CalendarAppBar(
          accent: Colors.green,
          backButton: false,
          locale: 'id',
          firstDate: DateTime.now().subtract(const Duration(days: 140)),
          lastDate: DateTime.now(),
          onDateChanged: () {}),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        isExtended: true,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
          const SizedBox(
            width: 20,
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.menu))
        ],
      )),
    );
  }
}
