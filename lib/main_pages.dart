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
        color: Colors.pink,
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
              onPressed: () {},
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
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
