import 'package:first_1_flutter_application/pages/completed.dart';
import 'package:first_1_flutter_application/pages/home_page.dart';
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
          backgroundColor: Theme.of(context).colorScheme.secondary,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).colorScheme.tertiary,
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
                  ? const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Icon(Icons.list),
                    )
                  : const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Icon(Icons.list_outlined),
                    ),
              label: "To-dos",
            ),
            BottomNavigationBarItem(
              icon: myIndex == 1
                  ? const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Icon(Icons.check_circle),
                    )
                  : const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Icon(Icons.check_circle_outline),
                    ),
              label: "Completed",
            ),
          ]),
    );
  }
}
