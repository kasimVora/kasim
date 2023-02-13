import 'package:firebase__test/Helper/Color.dart';
import 'package:firebase__test/Screen/ChatScreen.dart';
import 'package:firebase__test/Screen/SearchScreen.dart';
import 'package:flutter/material.dart';import 'MediaPicker.dart';


import 'MainScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  Widget currentScreen = PostScreen();
  String appBarText = "Home Screen";


  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: null,
      body: currentScreen,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "",
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: blueColor,
        unselectedItemColor: grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (value){
          setState(() {
            selectedIndex = value;
            selectedIndex == 0 ? currentScreen = const PostScreen() : selectedIndex == 1 ? currentScreen = const MediaPicker() :selectedIndex == 2 ? currentScreen = const SearchScreen(): currentScreen = const ChatScreen();
          });
        },
      ),
    );
  }
}
