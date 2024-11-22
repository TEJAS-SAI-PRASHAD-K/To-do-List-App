import 'package:first_1_flutter_application/completed.dart';
import 'package:first_1_flutter_application/home_page.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<Widget> pagelist = const [
    HomePage(),
    CompletedListPage(),
  ];
  int myIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pagelist[myIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          iconSize: 28,
          selectedFontSize: 14,
          unselectedFontSize: 14,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              myIndex = index;
            });
          },
          currentIndex: myIndex,
          items: [
            BottomNavigationBarItem(
              icon: myIndex == 0
                  ? const Icon(Icons.event_note)
                  : const Icon(Icons.event_note_outlined),
              label: "To-dos",
            ),
            BottomNavigationBarItem(
              icon: myIndex == 1
                  ? const Icon(Icons.check_circle)
                  : const Icon(Icons.check_circle_outline),
              label: "Completed",
            ),
          ]),
    );
  }
}
