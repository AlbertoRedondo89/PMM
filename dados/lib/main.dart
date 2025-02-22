import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(DiceApp());
}

class DiceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dice Roller',
      home: DiceRollerScreen(),
    );
  }
}

class DiceRollerScreen extends StatefulWidget {
  @override
  _DiceRollerScreenState createState() => _DiceRollerScreenState();
}

class _DiceRollerScreenState extends State<DiceRollerScreen> {
  int numberOfDice = 6; // Default number of dice
  List<int> diceResults = [];
  List<bool> selectedRows = [];

  // Simulate dice rolls
  void rollDice() {
    setState(() {
      diceResults =
          List.generate(numberOfDice, (index) => Random().nextInt(6) + 1);
      selectedRows =
          List.generate(6, (index) => false); // Default: No rows selected
    });
  }

  // Re-roll only selected dice
  void reRollSelected() {
    setState(() {
      List<int> newRolls = [];

      for (int i = 1; i <= 6; i++) {
        if (selectedRows[i - 1]) {
          // Re-roll all dice of this value
          int count = diceResults.where((result) => result == i).length;
          newRolls
              .addAll(List.generate(count, (index) => Random().nextInt(6) + 1));
        }
      }

      diceResults = newRolls;
      selectedRows = List.generate(6, (index) => false); // Reset selection
    });
  }

  // Get GIF asset path for a given dice face value
  String getDiceGif(int faceValue) {
    return 'assets/$faceValue.png'; // Ensure these files are in the assets folder
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dice Roller'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Number of dice selector
            Row(
              children: [
                Text('Number of dice: '),
                DropdownButton<int>(
                  value: numberOfDice,
                  items: [
                    for (int i = 1; i <= 60; i++)
                      DropdownMenuItem(value: i, child: Text('$i'))
                  ],
                  onChanged: (value) {
                    setState(() {
                      numberOfDice = value ?? 6;
                    });
                  },
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: rollDice,
                  child: Text('Roll Dice'),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Display dice results by rows
            if (diceResults.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    int faceValue = index + 1;
                    List<int> faceResults = diceResults
                        .where((result) => result == faceValue)
                        .toList();

                    return Row(
                      children: [
                        Checkbox(
                          value: selectedRows[index],
                          onChanged: (bool? value) {
                            setState(() {
                              selectedRows[index] = value ?? false;
                            });
                          },
                        ),
                        Text('Face $faceValue: '),
                        Expanded(
                          child: Wrap(
                            spacing: 8,
                            children: faceResults
                                .map((e) => Image.asset(
                                      getDiceGif(e),
                                      width: 50,
                                      height: 50,
                                    ))
                                .toList(),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

            // Re-roll button
            if (diceResults.isNotEmpty)
              Center(
                child: ElevatedButton(
                  onPressed: reRollSelected,
                  child: Text('Re-roll Selected'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
