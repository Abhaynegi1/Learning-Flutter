import 'package:flutter/material.dart';

// StatefulWidget: A widget that has mutable state (data that can change).
// It consists of two classes: the configuration Widget and the State object.
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

  // Logic to update the strength value.
  void increaseStrength() {
    setState(() {
      strength = strength < 5 ? strength + 1 : 5;
    });
  }

  void decreaseStrength() {
    setState(() {
      strength = strength > 1 ? strength - 1 : 1;
    });
  }

  // Logic to update the sugar value.
  void increaseSugar() {
    setState(() {
      sugar = sugar < 5 ? sugar + 1 : 5;
    });
  }

  void decreaseSugar() {
    setState(() {
      sugar = sugar > 0 ? sugar - 1 : 0;
    });
  }

  bool isBrewing = false;
  bool coffeeReady = false;

  // makeCoffee: demonstration of an asynchronous function (async).
  void makeCoffee() async {
    // setState: Notifies the framework that the internal state has changed.
    // This triggers the build() method to run again and update the UI.
    setState(() {
      isBrewing = true;
      coffeeReady = false;
    });

    // Future.delayed: Pauses the execution for a set duration.
    // 'await' tells the function to wait here until the timer is finished.
    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      isBrewing = false;
      coffeeReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              "Strength : ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.brown,
              ),
            ),

            // AnimatedSwitcher: Automatically handles transitions between widgets.
            // It looks for changes in 'key' or 'widget type' to start animating.
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Row(
                key: ValueKey(strength),
                children: [
                  for (int i = 0; i < strength; i++)
                    Padding(
                      padding: const EdgeInsets.only(right: 2.0),
                      child: Image.asset(
                        "assets/img/coffee_bean.png",
                        width: 25,
                        color: Colors.brown[50],
                        colorBlendMode: BlendMode.multiply,
                      ),
                    ),
                ],
              ),
            ),

            const Expanded(child: SizedBox()),

            IconButton(
              onPressed: decreaseStrength,
              icon: const Icon(
                Icons.remove_circle_outline,
                color: Colors.brown,
              ),
            ),
            IconButton(
              onPressed: increaseStrength,
              icon: const Icon(Icons.add_circle_outline, color: Colors.brown),
            ),
          ],
        ),

        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Divider(color: Colors.brown, thickness: 0.1),
        ),

        Row(
          children: [
            const Text(
              "Sugar : ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.brown,
              ),
            ),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Row(
                key: ValueKey(sugar),
                children: [
                  if (sugar == 0)
                    const Text(
                      "No sugar",
                      style: TextStyle(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  for (int i = 0; i < sugar; i++)
                    Padding(
                      padding: const EdgeInsets.only(right: 2.0),
                      child: Image.asset(
                        "assets/img/sugar_cube.png",
                        width: 25,
                        // Note: Using BlendMode.multiply with the exact same color as
                        // the Card background hides the white edges of the image assets.
                        color: Colors.brown[50],
                        colorBlendMode: BlendMode.multiply,
                      ),
                    ),
                ],
              ),
            ),

            const Expanded(child: SizedBox()),

            IconButton(
              onPressed: decreaseSugar,
              icon: const Icon(
                Icons.remove_circle_outline,
                color: Colors.brown,
              ),
            ),
            IconButton(
              onPressed: increaseSugar,
              icon: const Icon(Icons.add_circle_outline, color: Colors.brown),
            ),
          ],
        ),

        const SizedBox(height: 25),

        ElevatedButton(
          onPressed: isBrewing ? null : makeCoffee,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.brown[700],
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(isBrewing ? "Brewing..." : "Make Coffee"),
        ),

        const SizedBox(height: 20),

        SizedBox(
          height: 100,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: isBrewing
                ? const Column(
                    key: ValueKey('brewing'),
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: Colors.brown),
                      SizedBox(height: 12),
                      Text(
                        "Pouring your coffee...",
                        style: TextStyle(
                          color: Colors.brown,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                : coffeeReady
                ? const Column(
                    key: ValueKey('ready'),
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.coffee, size: 60, color: Colors.brown),
                      Text(
                        "Enjoy your coffee!",
                        style: TextStyle(
                          color: Colors.brown,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(key: ValueKey('idle')),
          ),
        ),
      ],
    );
  }
}
