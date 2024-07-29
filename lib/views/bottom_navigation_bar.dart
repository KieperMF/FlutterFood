import 'package:flutter/material.dart';
import 'package:flutter_food/main.dart';
import 'package:flutter_food/views/home_screen/home_page.dart';
import 'package:flutter_food/views/user_screen/user_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class GoogleNavBar extends StatefulWidget {
  const GoogleNavBar({super.key});

  @override
  State<GoogleNavBar> createState() => _GoogleNavBarState();
}

class _GoogleNavBarState extends State<GoogleNavBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedPage,
        children: [HomePage.create(), UserPage.create()],
      ),
      backgroundColor: const Color.fromRGBO(24, 24, 24, 1),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24), topRight: Radius.circular(24)),
            color: Color.fromRGBO(38, 38, 38, 1)),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: GNav(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
              backgroundColor: const Color.fromRGBO(38, 38, 38, 1),
              gap: 8,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              tabs: const [
                GButton(
                  text: 'Menu',
                  icon: Icons.menu_book_rounded,
                  iconColor: Colors.white,
                  iconActiveColor: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                ),
                GButton(
                  text: 'Profile',
                  icon: Icons.person,
                  iconActiveColor: Colors.black,
                  iconColor: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                ),
              ],
              selectedIndex: selectedPage,
              onTabChange: (value) {
                setState(() {
                  selectedPage = value;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
