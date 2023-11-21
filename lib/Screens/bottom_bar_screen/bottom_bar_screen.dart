import 'package:chat_app/Screens/more_screen/more_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:chat_app/Screens/home_screen/home_page.dart';

class BottomBarScreen extends StatefulWidget {
  BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 1;

  final pages = [Text('Chats a'), HomePage(), MoreScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/vectors/ic_user_group.svg'),
            label: '',
            activeIcon: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Contacts"),
                Stack(
                  children: [
                    Positioned(
                        child: Text(
                      '.',
                      style: TextStyle(fontSize: 40, height: .3),
                    ))
                  ],
                )
              ],
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/vectors/ic_chat.svg'),
            label: '',
            activeIcon: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Chats"),
                Stack(
                  children: [
                    Positioned(
                        child: Text(
                      '.',
                      style: TextStyle(fontSize: 40, height: .3),
                    ))
                  ],
                )
              ],
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/vectors/ic_more_horizontal.svg'),
            label: '',
            activeIcon: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("More"),
                Stack(
                  children: [
                    Positioned(
                        child: Text(
                      '.',
                      style: TextStyle(fontSize: 40, height: .3),
                    ))
                  ],
                )
              ],
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.shifting,
        elevation: 5,
        selectedFontSize: 0,
      ),
    );
  }
}
