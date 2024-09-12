import 'package:flutter/material.dart';
import 'package:loppeapp/screens/account.dart';
import 'package:loppeapp/screens/additem.dart';
import 'package:loppeapp/screens/chat.dart';
import 'package:loppeapp/screens/home.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({super.key});

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Color(0xFFB7A679),
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.add)),
            label: 'Add item',
          ),
          NavigationDestination(
            icon: Badge(
              // label: Text('2'),
              child: Icon(Icons.messenger),
            ),
            label: 'Messages',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.account_box_rounded)),
            label: 'Account',
          ),
        ],
      ),
      body: <Widget>[
        HomeScreen(),
        const AddItemScreen(),
        const ChatScreen(),
        const AccountScreen()
      ][currentPageIndex],
    );
  }
}
