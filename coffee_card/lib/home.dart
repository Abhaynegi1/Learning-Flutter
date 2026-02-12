import 'package:coffee_card/coffee_prefs.dart';
import 'package:flutter/material.dart';

// StatelessWidget: A widget that doesn't hold any data that changes over time.
// Once built, it stays the same (until it is rebuilt by its parent).
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold: Provides a basic structural layout (like AppBar, Body, etc.)
    // for a screen or page.
    return Scaffold(
      appBar: AppBar(
        // title: The main text shown in the AppBar.
        title: const Text('My Coffee', style: TextStyle(color: Colors.white)),
        // backgroundColor: Sets the background color of the AppBar.
        backgroundColor: Colors.brown[700],
        // centerTitle: Centers the title text horizontally.
        centerTitle: true,
      ),
      // body: The main content of the screen.
      body: Column(
        // crossAxisAlignment: How children are aligned across the main axis (horizontal in a Column).
        // stretch: Children will fill the full width of the Column.
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.brown[400],
            // Padding/alignment or simple text decoration usually goes here.
            child: const Text("How I like my coffee"),
          ),
          // Our custom CoffeePrefs widget is used here.
          Container(color: Colors.brown[100], child: const CoffeePrefs()),
          // Expanded: Takes up all the remaining space in the Column.
          Expanded(
            child: Image.asset(
              "assets/img/coffee_bg.jpg",
              // fit: How the image should resize itself.
              // fitWidth: Makes the image fill the full width of its container.
              fit: BoxFit.fitWidth,
              // alignment: Where to position the image inside its container.
              alignment: Alignment.bottomCenter,
            ),
          ),
        ],
      ),
    );
  }
}
