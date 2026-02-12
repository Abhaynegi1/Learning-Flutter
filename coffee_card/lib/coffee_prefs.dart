import 'package:flutter/material.dart';

// StatefulWidget: A widget that has mutable state.
// It consists of two classes: the widget itself and a State class.
class CoffeePrefs extends StatefulWidget {
  const CoffeePrefs({super.key});

  @override
  State<CoffeePrefs> createState() => _CoffeePrefsState();
}

// State class: This is where the actual logic and data (state) live.
// The '_' before the name makes this class private to this file.
class _CoffeePrefsState extends State<CoffeePrefs> {
  // These variables hold the "state" of our widget.
  int strength = 3;
  int sugar = 3;

  // increaseStrength: Logic to update the strength value.
  void increaseStrength() {
    // setState: This is the MOST IMPORTANT function in a StatefulWidget.
    // It tells Flutter that something changed, so it should rebuild the UI.
    setState(() {
      strength = strength < 5 ? strength + 1 : 1;
    });
  }

  // increaseSugar: Logic to update the sugar value.
  void increaseSugar() {
    setState(() {
      sugar = sugar < 5 ? sugar + 1 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Column: Arranges its children vertically.
    return Column(
      children: [
        // Row: Arranges its children horizontally.
        Row(
          children: [
            const Text("Strength : "),
            Text("$strength"),
            // Image.asset: Displays an image from the project's assets.
            Image.asset(
              "assets/img/coffee_bean.png",
              width: 25,
              color: Colors.brown[100],
              colorBlendMode: BlendMode.multiply,
            ),
            // Expanded: Makes its child fill the available space in a Row or Column.
            // Using it with SizedBox() creates a flexible spacer.
            const Expanded(child: SizedBox()),
            // TextButton: A button that triggers a function when pressed.
            TextButton(onPressed: increaseStrength, child: const Text("+")),
          ],
        ),
        Row(
          children: [
            const Text("Sugar : "),
            Text("$sugar"),
            Image.asset(
              "assets/img/sugar_cube.png",
              width: 25,
              color: Colors.brown[100],
              colorBlendMode: BlendMode.multiply,
            ),
            const Expanded(child: SizedBox()),
            TextButton(onPressed: increaseSugar, child: const Text("+")),
          ],
        ),
      ],
    );
  }
}
