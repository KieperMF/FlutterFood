import 'package:flutter/material.dart';
import 'package:flutter_food/views/home_screen/home_page.dart';
import 'package:flutter_food/views/user_screen/user_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class GoogleNavBar extends StatefulWidget {
  const GoogleNavBar({super.key});

  @override
  State<GoogleNavBar> createState() => _GoogleNavBarState();
}

class _GoogleNavBarState extends State<GoogleNavBar> {
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedPage,
        children: [
          HomePage.create(),
          UserPage.create(),
        ],
      ),
      bottomNavigationBar: GNav(
        backgroundColor: Colors.grey,
        tabs: const [
          GButton(text: 'Home', icon: Icons.home),
          GButton(text: 'Profile', icon: Icons.person),
        ],
        selectedIndex: selectedPage,
        onTabChange: (value) {
          setState(() {
            selectedPage = value;
          });
        },
      ),
    );
  }
}
