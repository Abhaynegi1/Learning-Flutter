import 'package:coffee_card/coffee_prefs.dart';
import 'package:flutter/material.dart';

// StatelessWidget: A widget that doesn't hold any data that changes over time.
// It is useful for building static parts of the UI that don't need to rebuild often.
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Coffee',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.brown[700],
        centerTitle: true,
      ),
      // Stack: Allows widgets to be layered on top of each other.
      // Widgets are Z-indexed based on their order in the children list.
      body: Stack(
        children: [
          // Positioned.fill: Expands a widget to fill the entire space of the Stack.
          Positioned.fill(
            child: Image.asset(
              "assets/img/coffee_bg.jpg",
              fit: BoxFit
                  .cover, // cover: Scales the image to fill the container, cropped if necessary.
            ),
          ),

          // 2. Semi-transparent overlay to make the content readable
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(
                0.2,
              ), // Darkens the image slightly
            ),
          ),

          // 3. The Actual Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                color: Colors.brown[600]?.withOpacity(
                  0.8,
                ), // Semi-transparent header
                child: const Text(
                  "How I like my coffee",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Colors
                      .brown[50], // Solid background helps the icon blending
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 10.0,
                    ),
                    child: CoffeePrefs(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
