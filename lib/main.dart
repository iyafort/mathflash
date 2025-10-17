import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

// Conditional imports for web and non-web platforms
import 'web_download_stub.dart'
    if (dart.library.html) 'web_download_web.dart'
    as web_download;

void main() {
  runApp(const FlashcardApp());
}

class FlashcardApp extends StatelessWidget {
  const FlashcardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math Flash by Rea Mae Ragay',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const OpeningScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class OpeningScreen extends StatefulWidget {
  const OpeningScreen({super.key});

  @override
  _OpeningScreenState createState() => _OpeningScreenState();
}

class _OpeningScreenState extends State<OpeningScreen> {
  int numFlashcards = 10;
  List<String> operators = ['+']; // Only addition enabled by default
  int scrollTime = 0; // Default to "Off" (no auto-scrolling)
  int maxNumeratorDigits = 1; // Maximum number of digits for numerators
  int maxDenominatorDigits = 1; // Maximum number of digits for denominators
  int flashcardsOnScreen = 5;
  bool allowNegativeIntegers = false; // New setting for negative integers
  bool showAllAtOnce = false; // New setting: show all cards at once
  bool divisionWholeOnly = false; // New setting for division whole-only

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/BG.png'),
            fit: BoxFit.none,
            repeat: ImageRepeat.repeat,
            scale: 4.0, // 25% of original size (1/4 = 0.25)
            colorFilter: ColorFilter.matrix([
              .9, 0, 0, 0, 0, // Red channel * 1.1 (110% brightness)
              0, .9, 0, 0, 0, // Green channel * 1.1
              0, 0, .9, 0, 0, // Blue channel * 1.1
              0, 0, 0, 1, 0, // Alpha channel unchanged
            ]),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/Logo.png',
                width: MediaQuery.of(context).size.width < 1024 ? 200 : 300,
                height: MediaQuery.of(context).size.width < 1024 ? 200 : 300,
              ),
              const SizedBox(height: 10),
              const Text(
                'Math Flash',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Text(
                'by Rea Mae Ragay',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder:
                        (context) => Dialog(
                          child: Container(
                            width: 500,
                            height: 600,
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                const Text(
                                  'App Guide',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          child: const Text(
                                            '"Bridging traditional drills with digital practice."',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        const Text(
                                          'The E-Drill Generator is a digital flashcard tool designed to support teachers in reinforcing learners\' basic arithmetic skills. It provides interactive drills that promote accuracy and mastery of fundamental operations, making classroom practice more efficient and engaging.',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(height: 16),
                                        const Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Math Flash ',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    'aims to help learners build speed, accuracy, and confidence in solving basic arithmetic through fun and interactive drill exercises.',
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        const Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text:
                                                    'The best way to utilize the Math Flash is to ',
                                                style: TextStyle(fontSize: 14),
                                              ),
                                              TextSpan(
                                                text:
                                                    'project your laptop screen onto a monitor',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    ' or other large display, allowing the entire class to easily view and follow the drill exercises simultaneously.',
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        const Text(
                                          'How to Use Math Flash',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        const Text(
                                          '1. Quick Drills',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(text: '• Choose from '),
                                              TextSpan(
                                                text: 'Addition',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(text: ', '),
                                              TextSpan(
                                                text: 'Subtraction',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(text: ', '),
                                              TextSpan(
                                                text: 'Multiplication',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(text: ', or '),
                                              TextSpan(
                                                text: 'Division',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    ' buttons to automatically start a ready-made drill that consists of 30 items of the chosen operation.',
                                              ),
                                            ],
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        const Text(
                                          '2. Customize your Drills',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(text: '• Click '),
                                              TextSpan(
                                                text: 'Customize Drill',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    ' to adjust settings such as the number of items, operators, speed, digits, and flashcards on screen.',
                                              ),
                                            ],
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                        const Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(text: '• Tick '),
                                              TextSpan(
                                                text: 'Quiz Mode',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    ' to show all cards at once (maximum 10 per slide).',
                                              ),
                                            ],
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),

                                        const SizedBox(height: 12),
                                        const Text(
                                          '3. Start the Drill',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(text: '• Press '),
                                              TextSpan(
                                                text: 'Start',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    ' to begin. Flashcards will automatically slide to the left at the set speed.',
                                              ),
                                            ],
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                        const Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(text: '• '),
                                              TextSpan(
                                                text: 'Click the Gear button',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    ' at the upper right corner to end the drill.',
                                              ),
                                            ],
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        const Text(
                                          '4. Check and Review',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(text: '• '),
                                              TextSpan(
                                                text: 'Click',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    ' a card to see its answer, or use the ',
                                              ),
                                              TextSpan(
                                                text: 'Show Answers',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    ' button to reveal all answers at once for review.',
                                              ),
                                            ],
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('Close'),
                                ),
                              ],
                            ),
                          ),
                        ),
                  );
                },
                child: const Text('App Guide'),
              ),
              const SizedBox(height: 12),
              // Quick Start box with preset buttons
              Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.shade300, width: 2),
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.blue.shade50.withOpacity(0.3),
                ),
                child: Column(
                  children: [
                    Text(
                      'Quick Start',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      alignment: WrapAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () => _startPreset('+'),
                          child: const Text('Addition'),
                        ),
                        ElevatedButton(
                          onPressed: () => _startPreset('-'),
                          child: const Text('Subtraction'),
                        ),
                        ElevatedButton(
                          onPressed: () => _startPreset('*'),
                          child: const Text('Multiplication'),
                        ),
                        ElevatedButton(
                          onPressed: () => _startPreset('/'),
                          child: const Text('Division'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => _openSettings(context),
                child: const Text('Customize Drill'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _startApp(context),
                child: const Text('Start'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openSettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Settings',
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                _buildNumberOfItemsSlider(),
                _buildOperatorCheckboxes(),
                _buildScrollTimeSlider(),
                _buildFlashcardsOnScreenSlider(),
                _buildNumeratorDigitsSlider(),
                _buildDenominatorDigitsSlider(),
                _buildAllowNegativeIntegersCheckbox(),
                _buildShowAllAtOnceCheckbox(),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildOperatorCheckboxes() {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setInnerState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Operations:'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (String operator in ['+', '-', '×', '÷', '%'])
                  GestureDetector(
                    onTap: () {
                      setInnerState(() {
                        String internalOperator = operator;
                        // Convert display operators to internal operators
                        if (operator == '×') internalOperator = '*';
                        if (operator == '÷') internalOperator = '/';

                        if (operators.contains(internalOperator)) {
                          // Only allow deselection if there are other operators selected
                          if (operators.length > 1) {
                            operators.remove(internalOperator);
                          }
                          // If this is the only selected operator, do nothing (prevent deselection)
                        } else {
                          operators.add(internalOperator);
                        }
                      });
                    },
                    child: Container(
                      width: 50, // Fixed width for square shape
                      height: 50, // Fixed height for square shape
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              operators.contains(
                                    operator == '×'
                                        ? '*'
                                        : operator == '÷'
                                        ? '/'
                                        : operator,
                                  )
                                  ? Colors.blue
                                  : Colors.grey,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color:
                            operators.contains(
                                  operator == '×'
                                      ? '*'
                                      : operator == '÷'
                                      ? '/'
                                      : operator,
                                )
                                ? Colors.blue.shade50
                                : Colors.transparent,
                      ),
                      child: Center(
                        child: Text(
                          operator,
                          style: TextStyle(
                            fontSize: 28, // Adjusted for square container
                            fontWeight: FontWeight.w900,
                            color:
                                operators.contains(
                                      operator == '×'
                                          ? '*'
                                          : operator == '÷'
                                          ? '/'
                                          : operator,
                                    )
                                    ? Colors.blue.shade700
                                    : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20), // Ample space below operations buttons
          ],
        );
      },
    );
  }

  Widget _buildScrollTimeSlider() {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setInnerState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Card display time (seconds):'),
            Row(
              children: [
                const Text('Off'), // Removed fontSize: 12 to use default size
                Expanded(
                  child: Slider(
                    value: (scrollTime / 1000).toDouble(),
                    min: 0,
                    max: 30,
                    divisions: 6,
                    label:
                        scrollTime == 0
                            ? 'Off'
                            : (scrollTime / 1000).toString(),
                    onChanged: (double value) {
                      setInnerState(() {
                        scrollTime = (value * 1000).toInt();
                        // Allow 0 for instant display, otherwise ensure multiple of 5
                        if (scrollTime > 0) {
                          scrollTime = ((scrollTime ~/ 5000) * 5000);
                          if (scrollTime < 5000) scrollTime = 5000;
                        }
                      });
                    },
                  ),
                ),
                const Text('30'), // Removed fontSize: 12 to use default size
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildNumberOfItemsSlider() {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setInnerState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Number of items:'),
            Row(
              children: [
                const Text('5'), // Removed fontSize: 12 to use default size
                Expanded(
                  child: Slider(
                    value: numFlashcards.toDouble(),
                    min: 5,
                    max: 50,
                    divisions: 9,
                    label: numFlashcards.toString(),
                    onChanged: (double value) {
                      setInnerState(() {
                        numFlashcards = value.round();
                        // Ensure the value is a multiple of 5
                        numFlashcards = (numFlashcards ~/ 5) * 5;
                        if (numFlashcards < 5) numFlashcards = 5;
                      });
                    },
                  ),
                ),
                const Text('50'), // Removed fontSize: 12 to use default size
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildNumeratorDigitsSlider() {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setInnerState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Maximum number of digits for numerators:'),
            Row(
              children: [
                const Text('1'), // Removed fontSize: 12 to use default size
                Expanded(
                  child: Slider(
                    value: maxNumeratorDigits.toDouble(),
                    min: 1,
                    max: 3,
                    divisions: 2,
                    label: maxNumeratorDigits.toString(),
                    onChanged: (double value) {
                      setInnerState(() {
                        maxNumeratorDigits = value.round();
                      });
                    },
                  ),
                ),
                const Text('3'), // Removed fontSize: 12 to use default size
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildDenominatorDigitsSlider() {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setInnerState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Maximum number of digits for denominators:'),
            Row(
              children: [
                const Text('1'), // Removed fontSize: 12 to use default size
                Expanded(
                  child: Slider(
                    value: maxDenominatorDigits.toDouble(),
                    min: 1,
                    max: 3,
                    divisions: 2,
                    label: maxDenominatorDigits.toString(),
                    onChanged: (double value) {
                      setInnerState(() {
                        maxDenominatorDigits = value.round();
                      });
                    },
                  ),
                ),
                const Text('3'), // Removed fontSize: 12 to use default size
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildFlashcardsOnScreenSlider() {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setInnerState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Number of flashcards on screen:'),
            Row(
              children: [
                const Text('1'),
                Expanded(
                  child: Slider(
                    value: flashcardsOnScreen.toDouble(),
                    min: 1,
                    max: 5,
                    divisions: 2, // Only 3 divisions for values 1, 3, 5
                    label: flashcardsOnScreen.toString(),
                    onChanged: (double value) {
                      setInnerState(() {
                        // Snap to nearest valid value: 1, 3, or 5
                        if (value <= 2) {
                          flashcardsOnScreen = 1;
                        } else if (value <= 4) {
                          flashcardsOnScreen = 3;
                        } else {
                          flashcardsOnScreen = 5;
                        }
                      });
                    },
                  ),
                ),
                const Text('5'),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildAllowNegativeIntegersCheckbox() {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setInnerState) {
        return Row(
          children: [
            Checkbox(
              value: allowNegativeIntegers,
              onChanged: (bool? value) {
                setInnerState(() {
                  allowNegativeIntegers = value ?? false;
                });
              },
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setInnerState(() {
                    allowNegativeIntegers = !allowNegativeIntegers;
                  });
                },
                child: const Text('Allow Negative Integers'),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildShowAllAtOnceCheckbox() {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setInnerState) {
        return Row(
          children: [
            Checkbox(
              value: showAllAtOnce,
              onChanged: (bool? value) {
                setInnerState(() {
                  showAllAtOnce = value ?? false;
                });
              },
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setInnerState(() {
                    showAllAtOnce = !showAllAtOnce;
                  });
                },
                child: const Text('Quiz Mode (Show 10 cards per set)'),
              ),
            ),
          ],
        );
      },
    );
  }

  void _startApp(BuildContext context) {
    // If quiz mode (showAllAtOnce is true), go directly to FlashCardAppScreen
    // Otherwise, show countdown screen first
    if (showAllAtOnce) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder:
              (context) => FlashCardAppScreen(
                numFlashcards: numFlashcards,
                operators: operators,
                scrollTime: scrollTime,
                maxNumeratorDigits: maxNumeratorDigits,
                maxDenominatorDigits: maxDenominatorDigits,
                flashcardsOnScreen: flashcardsOnScreen,
                allowNegativeIntegers: allowNegativeIntegers,
                showAllAtOnce: showAllAtOnce,
                divisionWholeOnly: divisionWholeOnly,
              ),
        ),
        (Route<dynamic> route) => false, // Remove all previous routes
      );
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder:
              (context) => CountdownScreen(
                numFlashcards: numFlashcards,
                operators: operators,
                scrollTime: scrollTime,
                maxNumeratorDigits: maxNumeratorDigits,
                maxDenominatorDigits: maxDenominatorDigits,
                flashcardsOnScreen: flashcardsOnScreen,
                allowNegativeIntegers: allowNegativeIntegers,
                showAllAtOnce: showAllAtOnce,
                divisionWholeOnly: divisionWholeOnly,
              ),
        ),
        (Route<dynamic> route) => false, // Remove all previous routes
      );
    }
  }

  void _startPreset(String operator) {
    setState(() {
      operators = [operator];

      // Set number of flashcards based on operator
      if (operator == '*' || operator == '/') {
        numFlashcards = 20; // 20 flashcards for multiplication and division
      } else {
        numFlashcards = 30; // 30 flashcards for addition and subtraction
      }

      // Set max numerator digits based on operator
      if (operator == '*') {
        maxNumeratorDigits =
            2; // 2 digits for multiplication (will be capped at 50 in generation)
      } else if (operator == '/' || operator == '+' || operator == '-') {
        maxNumeratorDigits =
            2; // 2 digits for division, addition, and subtraction
      } else {
        maxNumeratorDigits = 1; // 1 digit for others
      }

      maxDenominatorDigits = 1;

      // Set scroll time based on operator
      if (operator == '*' || operator == '/') {
        scrollTime = 15000; // 15 seconds for multiplication and division
      } else {
        scrollTime = 8000; // 8 seconds for addition and subtraction
      }

      flashcardsOnScreen = 5;
      allowNegativeIntegers = true;
      showAllAtOnce = false;
      divisionWholeOnly = operator == '/';
    });

    // If quiz mode (showAllAtOnce is true), go directly to FlashCardAppScreen
    // Otherwise, show countdown screen first
    if (showAllAtOnce) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder:
              (context) => FlashCardAppScreen(
                numFlashcards: numFlashcards,
                operators: operators,
                scrollTime: scrollTime,
                maxNumeratorDigits: maxNumeratorDigits,
                maxDenominatorDigits: maxDenominatorDigits,
                flashcardsOnScreen: flashcardsOnScreen,
                allowNegativeIntegers: allowNegativeIntegers,
                showAllAtOnce: showAllAtOnce,
                divisionWholeOnly: divisionWholeOnly,
              ),
        ),
        (Route<dynamic> route) => false,
      );
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder:
              (context) => CountdownScreen(
                numFlashcards: numFlashcards,
                operators: operators,
                scrollTime: scrollTime,
                maxNumeratorDigits: maxNumeratorDigits,
                maxDenominatorDigits: maxDenominatorDigits,
                flashcardsOnScreen: flashcardsOnScreen,
                allowNegativeIntegers: allowNegativeIntegers,
                showAllAtOnce: showAllAtOnce,
                divisionWholeOnly: divisionWholeOnly,
              ),
        ),
        (Route<dynamic> route) => false,
      );
    }
  }
}

class CountdownScreen extends StatefulWidget {
  final int numFlashcards;
  final List<String> operators;
  final int scrollTime;
  final int maxNumeratorDigits;
  final int maxDenominatorDigits;
  final int flashcardsOnScreen;
  final bool allowNegativeIntegers;
  final bool showAllAtOnce;
  final bool divisionWholeOnly;

  const CountdownScreen({
    super.key,
    required this.numFlashcards,
    required this.operators,
    required this.scrollTime,
    required this.maxNumeratorDigits,
    required this.maxDenominatorDigits,
    required this.flashcardsOnScreen,
    required this.allowNegativeIntegers,
    required this.showAllAtOnce,
    this.divisionWholeOnly = false,
  });

  @override
  _CountdownScreenState createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen> {
  int _countdown = 3;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _countdown--;
      });

      if (_countdown <= 0) {
        timer.cancel();
        _navigateToFlashcards();
      }
    });
  }

  void _navigateToFlashcards() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder:
            (context) => FlashCardAppScreen(
              numFlashcards: widget.numFlashcards,
              operators: widget.operators,
              scrollTime: widget.scrollTime,
              maxNumeratorDigits: widget.maxNumeratorDigits,
              maxDenominatorDigits: widget.maxDenominatorDigits,
              flashcardsOnScreen: widget.flashcardsOnScreen,
              allowNegativeIntegers: widget.allowNegativeIntegers,
              showAllAtOnce: widget.showAllAtOnce,
              divisionWholeOnly: widget.divisionWholeOnly,
            ),
      ),
    );
  }

  String _getCountdownText() {
    switch (_countdown) {
      case 3:
        return "Sign check";
      case 2:
        return "Ready";
      case 1:
        return "Go!";
      default:
        return "Go!";
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/BG.png'),
            fit: BoxFit.none,
            repeat: ImageRepeat.repeat,
            scale: 4.0,
            colorFilter: ColorFilter.matrix([
              .9,
              0,
              0,
              0,
              0,
              0,
              .9,
              0,
              0,
              0,
              0,
              0,
              .9,
              0,
              0,
              0,
              0,
              0,
              1,
              0,
            ]),
          ),
        ),
        child: Center(
          child: Text(
            _getCountdownText(),
            style: const TextStyle(
              fontSize: 144,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              shadows: [
                Shadow(
                  offset: Offset(2, 2),
                  blurRadius: 4,
                  color: Colors.white54,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class FlashCardAppScreen extends StatefulWidget {
  final int numFlashcards;
  final List<String> operators;
  final int scrollTime;
  final int maxNumeratorDigits;
  final int maxDenominatorDigits;
  final int flashcardsOnScreen;
  final bool allowNegativeIntegers;
  final bool showAllAtOnce;
  final bool divisionWholeOnly;

  const FlashCardAppScreen({
    super.key,
    required this.numFlashcards,
    required this.operators,
    required this.scrollTime,
    required this.maxNumeratorDigits,
    required this.maxDenominatorDigits,
    required this.flashcardsOnScreen,
    required this.allowNegativeIntegers,
    required this.showAllAtOnce,
    this.divisionWholeOnly = false,
  });

  @override
  _FlashCardAppScreenState createState() => _FlashCardAppScreenState();
}

class _FlashCardAppScreenState extends State<FlashCardAppScreen>
    with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> flashcards = [];
  int currentIndex = 0;
  int previousIndex = 0;
  bool showAnswer = false;
  bool isFlipping = false;
  late AnimationController _controller;
  late Animation<double> _animation;
  // Track which card indices have their answers revealed
  Set<int> revealedCards = {};
  // For grid mode pagination (show-all-at-once)
  int currentSetStartIndex = 0;
  bool _autoAdvanceActive = false;
  bool _autoAdvanceCanceled = false; // Stop auto-advance after manual nav
  Timer? _countdownTimer;
  Timer? _autoAdvanceTimer;
  int _countdownSeconds = 0;
  String _slideDirection = 'right'; // 'left' or 'right'
  late AudioPlayer _audioPlayer;
  bool _isPaused = false; // Track if user manually paused
  bool _isTimerRunning = false; // Track if timer is actively running
  int _remainingTimeOnPause = 0; // Track remaining time when paused

  @override
  void initState() {
    super.initState();
    generateFlashcards();
    _audioPlayer = AudioPlayer();
    _controller = AnimationController(
      duration: const Duration(
        milliseconds: 800,
      ), // Longer duration for smoother slide
      vsync: this,
    );
    _animation =
        Tween(begin: 0.0, end: 1.0).animate(_controller)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              isFlipping = false;
            }
          });

    // Use Future.delayed to allow Flutter to fully build the UI before maximizing
    Future.delayed(Duration.zero, () {
      // Maximize the window - this would typically be handled by a platform-specific plugin
      // For example, window_manager package in desktop apps
      // This is a placeholder, as Flutter doesn't have direct window maximizing capabilities
    });
    // Initialize countdown seconds immediately so timer shows on start
    if (!widget.showAllAtOnce && widget.scrollTime > 0) {
      _countdownSeconds = widget.scrollTime ~/ 1000;
      _startAutoAdvance();
    }
  }

  void generateFlashcards() {
    flashcards.clear();
    List<String> answerKeyLines = [];
    answerKeyLines.add('MATH FLASH ANSWER KEY');
    answerKeyLines.add(
      'Generated on: ${DateTime.now().toString().split('.')[0]}',
    );
    answerKeyLines.add('');
    answerKeyLines.add('Questions and Answers:');
    answerKeyLines.add('');

    // Set to track unique questions to prevent repetition
    Set<String> uniqueQuestions = {};
    // Set to track unique numerators to prevent repetition for preset buttons
    Set<int> usedNumerators = {};

    // Check if we're using a preset button (single operator)
    bool isPresetButton = widget.operators.length == 1;

    for (int i = 0; i < widget.numFlashcards; i++) {
      int num1 = 0;
      int num2 = 0;
      String operator = '+';
      String questionKey = '';
      int attempts = 0;
      const int maxAttempts = 100; // Prevent infinite loops

      // Generate unique question
      do {
        attempts++;
        if (attempts > maxAttempts) {
          // If we can't generate a unique question after max attempts, break
          break;
        }

        // For preset buttons, generate unique numerator first
        if (isPresetButton) {
          int numeratorAttempts = 0;
          const int maxNumeratorAttempts = 100;

          do {
            numeratorAttempts++;
            if (numeratorAttempts > maxNumeratorAttempts) {
              // If we can't generate a unique numerator, break
              break;
            }

            // Generate numbers based on allowNegativeIntegers setting
            if (widget.allowNegativeIntegers) {
              // Generate numbers that can be negative
              num1 =
                  Random().nextInt(
                    pow(10, widget.maxNumeratorDigits).toInt() * 2,
                  ) -
                  pow(10, widget.maxNumeratorDigits).toInt();
              num2 =
                  Random().nextInt(
                    pow(10, widget.maxDenominatorDigits).toInt() * 2,
                  ) -
                  pow(10, widget.maxDenominatorDigits).toInt();
            } else {
              // Generate only positive numbers
              num1 = Random().nextInt(
                pow(10, widget.maxNumeratorDigits).toInt(),
              );
              num2 = Random().nextInt(
                pow(10, widget.maxDenominatorDigits).toInt(),
              );
            }

            operator =
                widget.operators[0]; // For presets, use the single operator

            // Special case for multiplication: cap numerator at 50
            if (operator == '*') {
              if (num1 > 50) {
                num1 = Random().nextInt(51); // 0-50
              } else if (num1 < -50) {
                num1 = -Random().nextInt(51); // -50 to 0
              }
            }

            // Ensure non-zero denominator for division and modulo
            if (operator == '/' || operator == '%') {
              // Make sure num2 is not zero for division and modulo
              if (num2 == 0) {
                num2 = Random().nextInt(9) + 1; // Always positive 1-9
              }

              // For modulo, ensure denominator is never 0 and generate appropriate numbers
              if (operator == '%') {
                // For modulo, ensure denominator is positive and not 0
                num2 = Random().nextInt(9) + 1; // Always positive 1-9
                // Generate numerator that's larger than denominator for meaningful modulo
                num1 = Random().nextInt(9) + num2; // Ensures num1 > num2
              } else {
                // For division, ensure numerator is larger than denominator
                if (num1.abs() < num2.abs()) {
                  // Swap num1 and num2 to ensure num1 is larger
                  int temp = num1;
                  num1 = num2;
                  num2 = temp;
                }
              }
            }

            // Always generate whole number results for division
            if (operator == '/') {
              int maxDen = pow(10, widget.maxDenominatorDigits).toInt() - 1;
              int maxNum = pow(10, widget.maxNumeratorDigits).toInt() - 1;
              if (maxDen < 1) maxDen = 1;
              int baseDen = Random().nextInt(maxDen) + 1; // positive 1..maxDen
              int maxMultiplier = (maxNum ~/ baseDen.abs()).clamp(1, 9);
              if (maxMultiplier < 1) maxMultiplier = 1;
              int multiplier =
                  Random().nextInt(maxMultiplier) + 1; // 1..maxMultiplier

              // Only generate negative results if allowNegativeIntegers is true
              int sign =
                  widget.allowNegativeIntegers && Random().nextBool() ? -1 : 1;
              int product = baseDen * multiplier * sign;
              num2 = baseDen;
              num1 = product;
            }
          } while (usedNumerators.contains(num1));
        } else {
          // For custom settings, use original logic
          // Generate numbers based on allowNegativeIntegers setting
          if (widget.allowNegativeIntegers) {
            // Generate numbers that can be negative
            num1 =
                Random().nextInt(
                  pow(10, widget.maxNumeratorDigits).toInt() * 2,
                ) -
                pow(10, widget.maxNumeratorDigits).toInt();
            num2 =
                Random().nextInt(
                  pow(10, widget.maxDenominatorDigits).toInt() * 2,
                ) -
                pow(10, widget.maxDenominatorDigits).toInt();
          } else {
            // Generate only positive numbers
            num1 = Random().nextInt(pow(10, widget.maxNumeratorDigits).toInt());
            num2 = Random().nextInt(
              pow(10, widget.maxDenominatorDigits).toInt(),
            );
          }

          operator =
              widget.operators[Random().nextInt(widget.operators.length)];

          // Special case for multiplication: cap numerator at 50
          if (operator == '*') {
            if (num1 > 50) {
              num1 = Random().nextInt(51); // 0-50
            } else if (num1 < -50) {
              num1 = -Random().nextInt(51); // -50 to 0
            }
          }

          // Ensure non-zero denominator for division and modulo
          if (operator == '/' || operator == '%') {
            // Make sure num2 is not zero for division and modulo
            if (num2 == 0) {
              num2 = Random().nextInt(9) + 1; // Always positive 1-9
            }

            // For modulo, ensure denominator is never 0 and generate appropriate numbers
            if (operator == '%') {
              // For modulo, ensure denominator is positive and not 0
              num2 = Random().nextInt(9) + 1; // Always positive 1-9
              // Generate numerator that's larger than denominator for meaningful modulo
              num1 = Random().nextInt(9) + num2; // Ensures num1 > num2
            } else {
              // For division, ensure numerator is larger than denominator
              if (num1.abs() < num2.abs()) {
                // Swap num1 and num2 to ensure num1 is larger
                int temp = num1;
                num1 = num2;
                num2 = temp;
              }
            }
          }

          // Always generate whole number results for division
          if (operator == '/') {
            int maxDen = pow(10, widget.maxDenominatorDigits).toInt() - 1;
            int maxNum = pow(10, widget.maxNumeratorDigits).toInt() - 1;
            if (maxDen < 1) maxDen = 1;
            int baseDen = Random().nextInt(maxDen) + 1; // positive 1..maxDen
            int maxMultiplier = (maxNum ~/ baseDen.abs()).clamp(1, 9);
            if (maxMultiplier < 1) maxMultiplier = 1;
            int multiplier =
                Random().nextInt(maxMultiplier) + 1; // 1..maxMultiplier

            // Only generate negative results if allowNegativeIntegers is true
            int sign =
                widget.allowNegativeIntegers && Random().nextBool() ? -1 : 1;
            int product = baseDen * multiplier * sign;
            num2 = baseDen;
            num1 = product;
          }
        }

        // Create unique key for this question
        questionKey = '$num1$operator$num2';
      } while (uniqueQuestions.contains(questionKey));

      // Add to unique questions set
      uniqueQuestions.add(questionKey);

      // Add numerator to used set if using preset button
      if (isPresetButton) {
        usedNumerators.add(num1);
      }

      // Convert * to × for display
      String displayOperator = operator;
      if (operator == '*') {
        displayOperator = '×';
      } else if (operator == '/') {
        displayOperator = '÷';
      }

      // Right aligned expression formatting
      String expression = '$num1\n$displayOperator $num2\n________';
      double answer = _calculateAnswer(num1, num2, operator);
      flashcards.add({'expression': expression, 'answer': answer});

      // Add to answer key
      String questionText = '$num1 $displayOperator $num2';
      String answerText = _formatAnswer(answer);
      answerKeyLines.add('${i + 1}. $questionText = $answerText');
    }
  }

  void _generateAnswerKeyFile(List<String> lines) async {
    try {
      DateTime now = DateTime.now();
      String fileName =
          '${_getMonthName(now.month)}_${now.day.toString().padLeft(2, '0')}_${now.year}_${now.hour.toString().padLeft(2, '0')}_${now.minute.toString().padLeft(2, '0')}.txt';

      if (kIsWeb) {
        // Web version: trigger download using conditional import
        String content = lines.join('\n');
        web_download.downloadFile(content, fileName);
      } else {
        // Desktop/mobile version: save to file system
        Directory? targetDir;

        try {
          targetDir = await getDownloadsDirectory();
        } catch (e) {
          print('Downloads directory not accessible: $e');
        }

        if (targetDir == null) {
          try {
            targetDir = await getApplicationDocumentsDirectory();
          } catch (e) {
            print('Documents directory not accessible: $e');
          }
        }

        if (targetDir == null) {
          // Fallback: just print to console
          print('=== ANSWER KEY FILE: $fileName ===');
          for (String line in lines) {
            print(line);
          }
          print('=== END ANSWER KEY ===');
          return;
        }

        String filePath = '${targetDir.path}/$fileName';
        File file = File(filePath);

        await file.writeAsString(lines.join('\n'));
        print('Answer key saved to: $filePath');
      }
    } catch (e) {
      print('Error generating answer key: $e');
      // Fallback: print to console
      print('=== ANSWER KEY (Console Output) ===');
      for (String line in lines) {
        print(line);
      }
      print('=== END ANSWER KEY ===');
    }
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  double _calculateAnswer(int num1, int num2, String operator) {
    switch (operator) {
      case '+':
        return num1 + num2.toDouble();
      case '-':
        return num1 - num2.toDouble();
      case '*':
        return num1 * num2.toDouble();
      case '/':
        return num1 / num2;
      case '%':
        return num1 % num2.toDouble();
      default:
        return 0.0;
    }
  }

  void updateFlashcard() {
    setState(() {});
  }

  void scrollFlashcards() {
    previousIndex = currentIndex;
    currentIndex = currentIndex + 1;
    // Don't loop back to the beginning when reaching the end
    if (currentIndex >= flashcards.length) {
      currentIndex = flashcards.length - 1;
      return; // Stop scrolling when reaching the end
    }
    isFlipping = false;
    _controller.forward(from: 0.0);
    updateFlashcard();
    Future.delayed(Duration(milliseconds: widget.scrollTime), scrollFlashcards);
  }

  void scrollBack() {
    setState(() {
      previousIndex = currentIndex;
      _autoAdvanceCanceled = true; // stop auto-scroll on manual navigation
      _isPaused = true; // Mark as paused
      _pauseTimer(); // Pause timer on manual navigation
      _autoAdvanceTimer?.cancel(); // Stop auto-advance timer
      _slideDirection = 'left'; // Set slide direction for back navigation
      // Don't loop to the end when at the beginning
      if (widget.showAllAtOnce) {
        int step = 10;
        currentSetStartIndex = (currentSetStartIndex - step).clamp(
          0,
          flashcards.length,
        );
      } else {
        if (currentIndex > 0) {
          currentIndex = currentIndex - 1;
        }
      }
      showAnswer = false;
      isFlipping = true;
      _controller.forward(from: 0.0);
    });
  }

  void scrollForward() {
    setState(() {
      previousIndex = currentIndex;
      _autoAdvanceCanceled = true; // stop auto-scroll on manual navigation
      _isPaused = true; // Mark as paused
      _pauseTimer(); // Pause timer on manual navigation
      _autoAdvanceTimer?.cancel(); // Stop auto-advance timer
      _slideDirection = 'right'; // Set slide direction for forward navigation
      // Don't loop to the beginning when at the end
      if (widget.showAllAtOnce) {
        int step = 10;
        if (currentSetStartIndex + step < flashcards.length) {
          currentSetStartIndex = (currentSetStartIndex + step).clamp(
            0,
            flashcards.length - 1,
          );
        }
      } else {
        if (currentIndex < flashcards.length - 1) {
          currentIndex = currentIndex + 1;
        }
      }
      showAnswer = false;
      isFlipping = true;
      _controller.forward(from: 0.0);
    });
  }

  void toggleAnswer() {
    setState(() {
      if (revealedCards.contains(currentIndex)) {
        revealedCards.remove(currentIndex);
      } else {
        revealedCards.add(currentIndex);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _countdownTimer?.cancel();
    _autoAdvanceTimer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _startAutoAdvance() {
    if (widget.showAllAtOnce) return; // Disable auto-scroll in show-all mode
    if (widget.scrollTime == 0) return; // Disable auto-scroll when set to "Off"
    if (_autoAdvanceActive) return;
    if (_autoAdvanceCanceled) return; // Do not start if canceled
    if (_isPaused) return; // Do not start if paused

    _autoAdvanceActive = true;
    _startCountdownTimer();

    // Use a separate timer for auto-advance to avoid conflicts
    _autoAdvanceTimer?.cancel();
    _autoAdvanceTimer = Timer(Duration(milliseconds: widget.scrollTime), () {
      if (!mounted) return;
      if (_autoAdvanceCanceled || _isPaused) {
        _autoAdvanceActive = false;
        _stopCountdownTimer();
        return;
      }

      if (!widget.showAllAtOnce && currentIndex < flashcards.length - 1) {
        _autoAdvanceForward();
      }

      _autoAdvanceActive = false;
      _stopCountdownTimer();

      // Restart if not canceled and not paused
      if (mounted && !_autoAdvanceCanceled && !_isPaused) {
        _startAutoAdvance();
      }
    });
  }

  void _restartAutoAdvance() {
    // Force restart auto-advance by resetting states
    _autoAdvanceActive = false;
    _autoAdvanceCanceled = false;
    _isPaused = false;
    _autoAdvanceTimer?.cancel();
    _startAutoAdvance();
  }

  // Separate method for auto-advance that doesn't cancel auto-scroll
  void _autoAdvanceForward() {
    setState(() {
      previousIndex = currentIndex;
      _slideDirection = 'right'; // Auto-advance always goes right
      // Don't cancel auto-scroll when advancing automatically
      if (currentIndex < flashcards.length - 1) {
        currentIndex = currentIndex + 1;
      }
      showAnswer = false;
      isFlipping = true;
      _controller.forward(from: 0.0);
    });
  }

  void _startCountdownTimer() {
    if (widget.scrollTime == 0) return;
    if (_isTimerRunning) return; // Prevent multiple timers

    _isTimerRunning = true;
    // Only reset to full time if not resuming from pause
    if (_remainingTimeOnPause == 0) {
      _countdownSeconds = widget.scrollTime ~/ 1000;
    }

    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!mounted || _isPaused || _autoAdvanceCanceled) {
        timer.cancel();
        _isTimerRunning = false;
        return;
      }

      setState(() {
        _countdownSeconds--;
      });

      // Play sound in the last 3 seconds
      if (_countdownSeconds <= 3 && _countdownSeconds > 0) {
        _playCountdownSound();
      }

      if (_countdownSeconds <= 0) {
        timer.cancel();
        _isTimerRunning = false;
      }
    });
  }

  void _stopCountdownTimer() {
    _countdownTimer?.cancel();
    _isTimerRunning = false;
    setState(() {
      _countdownSeconds = 0;
    });
  }

  void _pauseTimer() {
    if (!_isTimerRunning) return;

    _countdownTimer?.cancel();
    _isTimerRunning = false;
    _remainingTimeOnPause = _countdownSeconds;
    _audioPlayer.stop(); // Stop any playing sound
  }

  void _resumeTimer() {
    if (_isTimerRunning) return;

    // If no remaining time or timer was at 0, reset to full time
    if (_remainingTimeOnPause <= 0) {
      _countdownSeconds = widget.scrollTime ~/ 1000;
    } else {
      _countdownSeconds = _remainingTimeOnPause;
    }

    _remainingTimeOnPause = 0;
    _startCountdownTimer();
  }

  void _playCountdownSound() async {
    try {
      // Stop any currently playing sound first to ensure clean playback
      await _audioPlayer.stop();
      // Play the beep sound from assets
      await _audioPlayer.play(AssetSource('sounds/beep.mp3'));
    } catch (e) {
      // Fallback: print to console
      print('BEEP! Countdown: $_countdownSeconds');
      print('Could not play sound: $e');
    }
  }

  Future<void> _saveAnswerFile() async {
    try {
      // Create answer key lines with header
      List<String> answerKeyLines = [];

      // Add header information
      answerKeyLines.add('MATH FLASH ANSWER KEY');
      answerKeyLines.add('');

      // Add generation timestamp
      DateTime now = DateTime.now();
      String timestamp =
          '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
      answerKeyLines.add('Generated on: $timestamp');
      answerKeyLines.add('');
      answerKeyLines.add('Questions and Answers:');
      answerKeyLines.add('');

      for (int i = 0; i < flashcards.length; i++) {
        final card = flashcards[i];
        String expression = card['expression'] as String;
        double answer = card['answer'] as double;

        // Parse the expression to get the question text
        List<String> lines = expression.split('\n');
        if (lines.length >= 2) {
          String num1 = lines[0].trim();
          String operator = lines[1].trim().split(' ')[0];
          String num2 = lines[1].trim().split(' ')[1];

          // Convert display operators back to standard format
          if (operator == '×') operator = '*';
          if (operator == '÷') operator = '/';

          String questionText = '$num1 $operator $num2';
          String answerText = _formatAnswer(answer);
          answerKeyLines.add('${i + 1}. $questionText = $answerText');
        }
      }

      // Generate the answer key file using the existing method
      _generateAnswerKeyFile(answerKeyLines);
    } catch (e) {
      print('Error saving answer file: $e');
    }
  }

  // Calculate the scale factor for a card based on its distance from the center
  double _getScaleFactor(int index, int centerIndex, double screenWidth) {
    // Calculate distance from centerIndex
    int distance = (index - centerIndex).abs();

    // Center card gets normal scale (will be multiplied in the widget)
    if (distance == 0) {
      return 1.0; // Center card - normal size
    } else {
      // More conservative scaling for better centering
      double baseScale = max(0.6, 1.0 - (distance * 0.15));

      // For very small screens, reduce scale even more to prevent overlapping
      if (screenWidth < 600) {
        baseScale = max(0.5, baseScale - (600 - screenWidth) / 2000);
      }

      return baseScale;
    }
  }

  // Format the expression for better display
  List<String> _formatExpression(String expression) {
    // Parse the expression string into separate lines
    List<String> lines = expression.split('\n');
    if (lines.length >= 3) {
      return [
        lines[0], // Numerator
        lines[1], // Operator and denominator
        lines[2], // Underline
      ];
    }
    return lines;
  }

  // Get responsive font size that shrinks up to 50% when window shrinks
  double _getResponsiveFontSize(double screenWidth, double baseFontSize) {
    // Base width for full size (e.g., 1200px)
    double baseWidth = 1200.0;

    // Calculate scale factor (minimum 0.5, maximum 1.0)
    double scaleFactor = (screenWidth / baseWidth).clamp(0.5, 1.0);

    return baseFontSize * scaleFactor;
  }

  // Get card colors based on position relative to center
  List<Color> _getCardColors(int index, int centerIndex) {
    bool isCenterCard = index == centerIndex;
    int distance = (index - centerIndex).abs();

    if (isCenterCard) {
      // Center card - full blue colors
      return [Colors.lightBlue.shade50, Colors.lightBlue.shade100];
    } else if (distance == 1) {
      // Side cards (2 cards beside center) - solid light blue background
      return [
        const Color(0xFFE6F7FE), // rgba(230, 247, 254, 1)
        const Color(0xFFE6F7FE), // rgba(230, 247, 254, 1)
      ];
    } else {
      // Edge cards - white/grey at 100% opacity
      return [Colors.white, Colors.grey[300]!];
    }
  }

  // Get card border color based on position relative to center
  Color _getCardBorderColor(int index, int centerIndex) {
    bool isCenterCard = index == centerIndex;
    int distance = (index - centerIndex).abs();

    if (isCenterCard) {
      return Colors.blue.shade700;
    } else if (distance == 1) {
      // Side cards - solid blue border
      return Colors.blue.shade700;
    } else {
      // Edge cards - blue border at 100% opacity
      return Colors.blue;
    }
  }

  // Interpolate colors smoothly during animation
  List<Color> _interpolateCardColors(
    int oldPosition,
    int newPosition,
    int centerIndex,
    double t,
  ) {
    List<Color> oldColors = _getCardColors(oldPosition, centerIndex);
    List<Color> newColors = _getCardColors(newPosition, centerIndex);

    return [
      Color.lerp(oldColors[0], newColors[0], t)!,
      Color.lerp(oldColors[1], newColors[1], t)!,
    ];
  }

  // Interpolate border color smoothly during animation
  Color _interpolateBorderColor(
    int oldPosition,
    int newPosition,
    int centerIndex,
    double t,
  ) {
    Color oldColor = _getCardBorderColor(oldPosition, centerIndex);
    Color newColor = _getCardBorderColor(newPosition, centerIndex);

    return Color.lerp(oldColor, newColor, t)!;
  }

  // Calculate card dimensions with proper aspect ratio and height constraints
  Map<String, double> _calculateCardDimensions(
    double baseCardWidth,
    double finalScale,
    Size screenSize,
  ) {
    const double aspectRatio = 1.6; // Width to height ratio
    const double minCardHeight = 360.0; // Minimum height to prevent overflow
    const double maxHeightPercentage = 0.8; // Maximum 80% of screen height

    // Calculate maximum allowed height based on screen size
    double maxAllowedHeight = screenSize.height * maxHeightPercentage;

    // Start with the desired dimensions based on baseCardWidth and scale
    double desiredWidth = baseCardWidth * finalScale;
    double desiredHeight = desiredWidth * aspectRatio;

    // Determine the limiting factor and scale accordingly
    double finalWidth, finalHeight;

    // Only apply height constraints if they would actually prevent overflow
    // and if the resulting card would still be reasonably sized
    if (desiredHeight > maxAllowedHeight && maxAllowedHeight >= minCardHeight) {
      // Height constraint is the limiting factor, but only if it's reasonable
      finalHeight = maxAllowedHeight;
      finalWidth = finalHeight / aspectRatio;
    } else if (desiredHeight < minCardHeight) {
      // Check if minimum height is achievable with current baseCardWidth
      double minWidthRequired = minCardHeight / aspectRatio;
      if (minWidthRequired <= baseCardWidth) {
        // Minimum height constraint is achievable
        finalHeight = minCardHeight;
        finalWidth = finalHeight / aspectRatio;
      } else {
        // Minimum height not achievable, use desired dimensions
        finalWidth = desiredWidth;
        finalHeight = desiredHeight;
      }
    } else {
      // No height constraints hit, use desired dimensions
      finalWidth = desiredWidth;
      finalHeight = desiredHeight;
    }

    return {'width': finalWidth, 'height': finalHeight};
  }

  // Format answer to not show decimal places for whole numbers
  String _formatAnswer(double answer) {
    // Guard against invalid numeric results
    if (!answer.isFinite) {
      return 'undefined';
    }
    if (answer == answer.roundToDouble()) {
      return answer.toInt().toString();
    } else {
      // Get the decimal part as a string
      String decimalPart = (answer - answer.truncateToDouble())
          .toString()
          .substring(2);
      // If decimal part has 4 or fewer digits, show as is
      if (decimalPart.length <= 4) {
        return answer.toString();
      } else {
        // Otherwise, limit to 4 decimal places
        return answer.toStringAsFixed(4);
      }
    }
  }

  Widget _buildFlashcard(
    int index,
    bool isCurrentCard,
    Size screenSize, {
    List<Color>? overrideColors,
    Color? overrideBorderColor,
  }) {
    int cardIndex = isCurrentCard ? currentIndex : previousIndex;
    // Compute base index so that the center position corresponds to the current card
    int centerIndex = widget.flashcardsOnScreen ~/ 2;
    int actualIndex = (cardIndex - centerIndex) + index;

    // Ensure index is within bounds
    if (actualIndex < 0 || actualIndex >= flashcards.length) {
      // Return an empty container for out-of-bounds indices
      return Container(
        width: screenSize.width * 0.3 * 0.5, // Small placeholder width
        margin: EdgeInsets.symmetric(horizontal: screenSize.width * 0.02),
      );
    }

    // Calculate card width based on screen size and number of visible cards
    // Use a more consistent approach for better centering
    double availableWidth = screenSize.width * 0.85;
    double spacing = screenSize.width * 0.02 * (widget.flashcardsOnScreen - 1);
    double totalCardWidth = availableWidth - spacing;

    // Calculate base card width - ensure consistent sizing
    double baseCardWidth = totalCardWidth / widget.flashcardsOnScreen;

    // Cap the maximum card width for very large screens
    baseCardWidth = min(baseCardWidth, screenSize.width * 0.4);

    // Consider width and height constraints more intelligently
    const double aspectRatio = 1.6;
    const double minCardHeight = 360.0;
    const double maxHeightPercentage =
        0.8; // Increased from 0.6 to 0.8 to maximize card height
    double maxAllowedHeight = screenSize.height * maxHeightPercentage;

    // Calculate maximum width that fits in available space
    double maxWidthFromSpace = totalCardWidth / widget.flashcardsOnScreen;

    // Only apply height constraints if they would actually prevent overflow
    // and if the resulting card would still be reasonably sized
    double maxWidthFromHeight = maxAllowedHeight / aspectRatio;
    double minWidthFromHeight = minCardHeight / aspectRatio;

    // Apply constraints more conservatively
    if (maxWidthFromHeight < maxWidthFromSpace &&
        maxAllowedHeight >= minCardHeight) {
      // Height constraint is more restrictive and reasonable
      double maxAllowedWidth = min(maxWidthFromHeight, maxWidthFromSpace);
      if (minWidthFromHeight > maxAllowedWidth) {
        baseCardWidth = maxAllowedWidth;
      } else {
        baseCardWidth = baseCardWidth.clamp(
          minWidthFromHeight,
          maxAllowedWidth,
        );
      }
    } else {
      // Space constraint is more restrictive, or height constraint is unreasonable
      if (minWidthFromHeight > maxWidthFromSpace) {
        baseCardWidth = maxWidthFromSpace;
      } else {
        baseCardWidth = baseCardWidth.clamp(
          minWidthFromHeight,
          maxWidthFromSpace,
        );
      }
    }

    // Calculate scale factor based on position relative to center
    double scaleFactor = _getScaleFactor(index, centerIndex, screenSize.width);

    // Center card gets a more moderate scale factor for better centering
    bool isCenterCard = index == centerIndex;
    double centerMultiplier =
        widget.flashcardsOnScreen == 3 ? 1.5 : 1.3; // More conservative scaling
    double finalScale =
        isCenterCard ? scaleFactor * centerMultiplier : scaleFactor;

    // Determine horizontal spacing based on screen width
    double horizontalSpacing = screenSize.width * 0.02;

    // Calculate card dimensions with proper aspect ratio and height constraints
    Map<String, double> dimensions = _calculateCardDimensions(
      baseCardWidth,
      finalScale,
      screenSize,
    );
    double cardWidth = dimensions['width']!;
    double cardHeight = dimensions['height']!;

    // Dynamically calculate font sizes based on card dimensions
    // Item number font size (scales with card width)
    double titleFontSize = cardWidth * 0.10;

    // Expression font size (scales with card width, larger for center card)
    double expressionFontSize =
        isCenterCard ? cardWidth * 0.22 : cardWidth * 0.18;
    // Cap expression font size relative to height to prevent overflow
    expressionFontSize = min(expressionFontSize, cardHeight * 0.24);

    // Answer font size (scales with card width)
    double answerFontSize = cardWidth * 0.18;
    // Cap answer font size relative to height to prevent overflow
    answerFontSize = min(answerFontSize, cardHeight * 0.22);

    // Format the expression for display
    List<String> expressionLines = _formatExpression(
      flashcards[actualIndex]['expression'].toString(),
    );

    return Container(
      width: cardWidth,
      height: cardHeight,
      margin: EdgeInsets.symmetric(horizontal: horizontalSpacing),
      padding: EdgeInsets.all(isCenterCard ? 16.0 : 12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: overrideColors ?? _getCardColors(index, centerIndex),
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: overrideBorderColor ?? _getCardBorderColor(index, centerIndex),
          width: isCenterCard ? 3.0 : 1.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow:
            isCenterCard
                ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ]
                : null,
      ),
      child: Opacity(
        opacity: 1.0, // All cards at 100% opacity
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Item number - left aligned with dynamic font size
            Text(
              '# ${actualIndex + 1}',
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Complete expression and answer section unified
            Expanded(
              flex: 4,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final String numerator =
                      expressionLines.isNotEmpty ? expressionLines[0] : '';
                  final String opDen =
                      expressionLines.length >= 2 ? expressionLines[1] : '';
                  String operatorChar = '';
                  String denominator = '';
                  if (opDen.isNotEmpty) {
                    final parts = opDen.trim().split(' ');
                    operatorChar = parts.isNotEmpty ? parts[0] : '';
                    denominator =
                        parts.length > 1 ? parts.sublist(1).join(' ') : '';
                  }
                  final double exprFont = min(
                    expressionFontSize * 2,
                    cardHeight * 0.2,
                  );
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          numerator,
                          style: TextStyle(
                            fontSize: exprFont,
                            fontFamily: 'Courier',
                            fontWeight: FontWeight.w600,
                            height: 1.0,
                          ),
                          textAlign: TextAlign.right,
                          softWrap: false,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      SizedBox(height: cardHeight * 0.01),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          '$operatorChar     $denominator', // 5 spaces between operator and denominator
                          style: TextStyle(
                            fontSize: exprFont,
                            fontFamily: 'Courier',
                            fontWeight: FontWeight.w600,
                            height: 1.0,
                          ),
                          textAlign: TextAlign.right,
                          softWrap: false,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      Container(
                        width: cardWidth * 0.95, // Extend line to both ends
                        margin: EdgeInsets.only(
                          top: max(1.0, cardHeight * 0.003),
                        ),
                        height: max(1.0, cardHeight * 0.005),
                        color: Colors.black,
                      ),
                      SizedBox(height: cardHeight * 0.005),
                      // Answer integrated in the same section
                      Container(
                        height: cardHeight * 0.20,
                        alignment: Alignment.centerRight,
                        child:
                            (actualIndex >= 0 &&
                                    actualIndex < flashcards.length &&
                                    revealedCards.contains(actualIndex))
                                ? FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    _formatAnswer(
                                      flashcards[actualIndex]['answer'],
                                    ),
                                    style: TextStyle(
                                      fontSize: exprFont,
                                      fontFamily: 'Courier',
                                      fontWeight: FontWeight.w600,
                                      height: 1.0,
                                    ),
                                    textAlign: TextAlign.right,
                                    softWrap: false,
                                    overflow: TextOverflow.clip,
                                  ),
                                )
                                : null,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlideAnimation(int index, Size screenSize) {
    // For 1-card mode, use flip animation instead of slide animation
    if (widget.flashcardsOnScreen == 1) {
      return _buildFlipAnimation(index, screenSize);
    }

    int centerIndex = widget.flashcardsOnScreen ~/ 2;

    // Calculate card dimensions (same logic as _buildFlashcard)
    double availableWidth = screenSize.width * 0.85;
    double spacing = screenSize.width * 0.02 * (widget.flashcardsOnScreen - 1);
    double totalCardWidth = availableWidth - spacing;
    double baseCardWidth = totalCardWidth / widget.flashcardsOnScreen;
    baseCardWidth = min(baseCardWidth, screenSize.width * 0.4);

    // Consider width and height constraints more intelligently
    const double aspectRatio = 1.6;
    const double minCardHeight = 360.0;
    const double maxHeightPercentage =
        0.8; // Increased from 0.6 to 0.8 to maximize card height
    double maxAllowedHeight = screenSize.height * maxHeightPercentage;

    // Calculate maximum width that fits in available space
    double maxWidthFromSpace = totalCardWidth / widget.flashcardsOnScreen;

    // Only apply height constraints if they would actually prevent overflow
    // and if the resulting card would still be reasonably sized
    double maxWidthFromHeight = maxAllowedHeight / aspectRatio;
    double minWidthFromHeight = minCardHeight / aspectRatio;

    // Apply constraints more conservatively
    if (maxWidthFromHeight < maxWidthFromSpace &&
        maxAllowedHeight >= minCardHeight) {
      // Height constraint is more restrictive and reasonable
      double maxAllowedWidth = min(maxWidthFromHeight, maxWidthFromSpace);
      if (minWidthFromHeight > maxAllowedWidth) {
        baseCardWidth = maxAllowedWidth;
      } else {
        baseCardWidth = baseCardWidth.clamp(
          minWidthFromHeight,
          maxAllowedWidth,
        );
      }
    } else {
      // Space constraint is more restrictive, or height constraint is unreasonable
      if (minWidthFromHeight > maxWidthFromSpace) {
        baseCardWidth = maxWidthFromSpace;
      } else {
        baseCardWidth = baseCardWidth.clamp(
          minWidthFromHeight,
          maxWidthFromSpace,
        );
      }
    }

    double horizontalSpacing = screenSize.width * 0.02;

    // Calculate actual card indices (not needed in slide animation, used by phantom cards)

    if (_slideDirection == 'right') {
      // Moving FORWARD (next card): cards slide LEFT
      // Leftmost card (index 0) fades out
      // All other cards slide left and scale to their new positions
      // Rightmost position gets a new card fading in

      if (index == 0) {
        // Leftmost card: fade out while moving left
        double opacity = 1.0 - _animation.value;
        double slideOffset = -baseCardWidth * _animation.value;

        return Transform.translate(
          offset: Offset(slideOffset, 0),
          child: Opacity(
            opacity: opacity,
            child: _buildFlashcard(index, false, screenSize),
          ),
        );
      } else {
        // All other cards: slide from right position to left position
        // This card is moving from position 'index' to position 'index - 1'
        // It should match the color/size of the card that was at position 'index - 1'

        int currentPosition = index; // Where this card currently is
        int replacedPosition = index - 1; // The position this card will replace

        // Calculate scales - this card should end up with the scale of the replaced position
        double currentScaleFactor = _getScaleFactor(
          currentPosition,
          centerIndex,
          screenSize.width,
        );
        double targetScaleFactor = _getScaleFactor(
          replacedPosition,
          centerIndex,
          screenSize.width,
        );

        bool currentIsCenter = currentPosition == centerIndex;
        bool targetIsCenter = replacedPosition == centerIndex;

        double centerMultiplier = widget.flashcardsOnScreen == 3 ? 1.5 : 1.3;
        double currentScale =
            currentIsCenter
                ? currentScaleFactor * centerMultiplier
                : currentScaleFactor;
        double targetScale =
            targetIsCenter
                ? targetScaleFactor * centerMultiplier
                : targetScaleFactor;

        // Interpolate scale - this card should become the size of the card it's replacing
        double animatedScale =
            currentScale + (targetScale - currentScale) * _animation.value;

        // Calculate positions using proper card dimensions
        Map<String, double> currentDimensions = _calculateCardDimensions(
          baseCardWidth,
          currentScale,
          screenSize,
        );
        Map<String, double> targetDimensions = _calculateCardDimensions(
          baseCardWidth,
          targetScale,
          screenSize,
        );
        double avgCardWidth =
            (currentDimensions['width']! + targetDimensions['width']!) / 2;
        double slideDistance = avgCardWidth + horizontalSpacing * 2;
        double slideOffset = -slideDistance * _animation.value;

        // Interpolate colors - this card should become the color of the card it's replacing
        List<Color> interpolatedColors = _interpolateCardColors(
          currentPosition,
          replacedPosition,
          centerIndex,
          _animation.value,
        );
        Color interpolatedBorderColor = _interpolateBorderColor(
          currentPosition,
          replacedPosition,
          centerIndex,
          _animation.value,
        );

        // For the rightmost position, don't show new card (phantom card handles it)
        double opacity = 1.0;
        bool showNewCard = false;
        // Removed: if (index == widget.flashcardsOnScreen - 1 && newCardExists) {
        //   showNewCard = true; // New card shows new content
        // }

        // For edge cards moving to non-edge positions, maintain current content
        int currentDistance = (currentPosition - centerIndex).abs();
        if (currentDistance > 1) {
          showNewCard =
              false; // Edge cards keep their current content during animation
        }

        // All cards maintain 100% opacity
        opacity = 1.0;

        return Transform.translate(
          offset: Offset(slideOffset, 0),
          child: Transform.scale(
            scale: animatedScale / currentScale,
            child: Opacity(
              opacity: opacity,
              child: _buildFlashcard(
                index,
                showNewCard, // Only show new content for the fading in card
                screenSize,
                overrideColors: interpolatedColors,
                overrideBorderColor: interpolatedBorderColor,
              ),
            ),
          ),
        );
      }
    } else {
      // Moving BACKWARD (previous card): cards slide RIGHT
      // Rightmost card fades out
      // All other cards slide right and scale to their new positions
      // Leftmost position gets a new card fading in

      if (index == widget.flashcardsOnScreen - 1) {
        // Rightmost card: fade out while moving right
        double opacity = 1.0 - _animation.value;
        double slideOffset = baseCardWidth * _animation.value;

        return Transform.translate(
          offset: Offset(slideOffset, 0),
          child: Opacity(
            opacity: opacity,
            child: _buildFlashcard(index, false, screenSize),
          ),
        );
      } else {
        // All other cards: slide from left position to right position
        // This card is moving from position 'index' to position 'index + 1'
        // It should match the color/size of the card that was at position 'index + 1'

        int currentPosition = index; // Where this card currently is
        int replacedPosition = index + 1; // The position this card will replace

        // Calculate scales - this card should end up with the scale of the replaced position
        double currentScaleFactor = _getScaleFactor(
          currentPosition,
          centerIndex,
          screenSize.width,
        );
        double targetScaleFactor = _getScaleFactor(
          replacedPosition,
          centerIndex,
          screenSize.width,
        );

        bool currentIsCenter = currentPosition == centerIndex;
        bool targetIsCenter = replacedPosition == centerIndex;

        double centerMultiplier = widget.flashcardsOnScreen == 3 ? 1.5 : 1.3;
        double currentScale =
            currentIsCenter
                ? currentScaleFactor * centerMultiplier
                : currentScaleFactor;
        double targetScale =
            targetIsCenter
                ? targetScaleFactor * centerMultiplier
                : targetScaleFactor;

        // Interpolate scale - this card should become the size of the card it's replacing
        double animatedScale =
            currentScale + (targetScale - currentScale) * _animation.value;

        // Calculate positions using proper card dimensions
        Map<String, double> currentDimensions = _calculateCardDimensions(
          baseCardWidth,
          currentScale,
          screenSize,
        );
        Map<String, double> targetDimensions = _calculateCardDimensions(
          baseCardWidth,
          targetScale,
          screenSize,
        );
        double avgCardWidth =
            (currentDimensions['width']! + targetDimensions['width']!) / 2;
        double slideDistance = avgCardWidth + horizontalSpacing * 2;
        double slideOffset = slideDistance * _animation.value;

        // Interpolate colors - this card should become the color of the card it's replacing
        List<Color> interpolatedColors = _interpolateCardColors(
          currentPosition,
          replacedPosition,
          centerIndex,
          _animation.value,
        );
        Color interpolatedBorderColor = _interpolateBorderColor(
          currentPosition,
          replacedPosition,
          centerIndex,
          _animation.value,
        );

        // For the leftmost position, don't show new card (phantom card handles it)
        double opacity = 1.0;
        bool showNewCard = false;
        // Removed: if (index == 0 && newCardExists) {
        //   showNewCard = true; // New card shows new content
        // }

        // For edge cards moving to non-edge positions, maintain current content
        int currentDistance = (currentPosition - centerIndex).abs();
        if (currentDistance > 1) {
          showNewCard =
              false; // Edge cards keep their current content during animation
        }

        // All cards maintain 100% opacity
        opacity = 1.0;

        return Transform.translate(
          offset: Offset(slideOffset, 0),
          child: Transform.scale(
            scale: animatedScale / currentScale,
            child: Opacity(
              opacity: opacity,
              child: _buildFlashcard(
                index,
                showNewCard, // Only show new content for the fading in card
                screenSize,
                overrideColors: interpolatedColors,
                overrideBorderColor: interpolatedBorderColor,
              ),
            ),
          ),
        );
      }
    }
  }

  Widget _buildFlipAnimation(int index, Size screenSize) {
    // For 1-card mode, create a flip animation
    // The card flips around its Y-axis to reveal the next card

    // Calculate card dimensions for 1-card mode
    double availableWidth = screenSize.width * 0.85;
    double baseCardWidth = min(availableWidth, screenSize.width * 0.4);

    // Apply height constraints
    const double aspectRatio = 1.6;
    const double minCardHeight = 360.0;
    const double maxHeightPercentage = 0.8;
    double maxAllowedHeight = screenSize.height * maxHeightPercentage;

    double maxWidthFromHeight = maxAllowedHeight / aspectRatio;
    double minWidthFromHeight = minCardHeight / aspectRatio;

    if (maxWidthFromHeight < baseCardWidth &&
        maxAllowedHeight >= minCardHeight) {
      double maxAllowedWidth = min(maxWidthFromHeight, baseCardWidth);
      if (minWidthFromHeight > maxAllowedWidth) {
        baseCardWidth = maxAllowedWidth;
      } else {
        baseCardWidth = baseCardWidth.clamp(
          minWidthFromHeight,
          maxAllowedWidth,
        );
      }
    } else {
      if (minWidthFromHeight > baseCardWidth) {
        baseCardWidth = baseCardWidth;
      } else {
        baseCardWidth = baseCardWidth.clamp(minWidthFromHeight, baseCardWidth);
      }
    }

    // Create the flip animation
    return Transform(
      alignment: Alignment.center,
      transform:
          Matrix4.identity()
            ..setEntry(3, 2, 0.001) // perspective
            ..rotateY(_animation.value * 3.14159), // flip around Y axis
      child:
          _animation.value < 0.5
              ? _buildFlashcard(index, false, screenSize) // Show previous card
              : Transform(
                alignment: Alignment.center,
                transform:
                    Matrix4.identity()..rotateY(3.14159), // flip the new card
                child: _buildFlashcard(
                  index,
                  true,
                  screenSize,
                ), // Show current card
              ),
    );
  }

  List<Widget> _buildPhantomCards(Size screenSize) {
    // Create phantom cards that slide in from the edges during animation
    List<Widget> phantomCards = [];

    if (widget.flashcardsOnScreen == 1) {
      // No phantom cards needed for 1-card mode (uses flip animation)
      return phantomCards;
    }

    int centerIndex = widget.flashcardsOnScreen ~/ 2;

    // Calculate card dimensions
    double availableWidth = screenSize.width * 0.85;
    double spacing = screenSize.width * 0.02 * (widget.flashcardsOnScreen - 1);
    double totalCardWidth = availableWidth - spacing;
    double baseCardWidth = totalCardWidth / widget.flashcardsOnScreen;
    baseCardWidth = min(baseCardWidth, screenSize.width * 0.4);

    // Apply height constraints
    const double aspectRatio = 1.6;
    const double minCardHeight = 360.0;
    const double maxHeightPercentage = 0.8;
    double maxAllowedHeight = screenSize.height * maxHeightPercentage;

    double maxWidthFromSpace = totalCardWidth / widget.flashcardsOnScreen;
    double maxWidthFromHeight = maxAllowedHeight / aspectRatio;
    double minWidthFromHeight = minCardHeight / aspectRatio;

    if (maxWidthFromHeight < maxWidthFromSpace &&
        maxAllowedHeight >= minCardHeight) {
      double maxAllowedWidth = min(maxWidthFromHeight, maxWidthFromSpace);
      if (minWidthFromHeight > maxAllowedWidth) {
        baseCardWidth = maxAllowedWidth;
      } else {
        baseCardWidth = baseCardWidth.clamp(
          minWidthFromHeight,
          maxAllowedWidth,
        );
      }
    } else {
      if (minWidthFromHeight > maxWidthFromSpace) {
        baseCardWidth = maxWidthFromSpace;
      } else {
        baseCardWidth = baseCardWidth.clamp(
          minWidthFromHeight,
          maxWidthFromSpace,
        );
      }
    }

    double horizontalSpacing = screenSize.width * 0.02;

    if (_slideDirection == 'right') {
      // Moving FORWARD: phantom card slides in from the right to replace [5]
      int phantomIndex = widget.flashcardsOnScreen - 1; // Position [5]
      int newActualIndex = (currentIndex - centerIndex) + phantomIndex;
      bool newCardExists =
          newActualIndex >= 0 && newActualIndex < flashcards.length;

      if (newCardExists) {
        // Use the EXACT same sizing logic as the [5] card in the main cards
        // Get the same scale factor as the [5] card
        double currentScaleFactor = _getScaleFactor(
          phantomIndex,
          centerIndex,
          screenSize.width,
        );
        bool currentIsCenter = phantomIndex == centerIndex;
        double centerMultiplier = widget.flashcardsOnScreen == 3 ? 1.5 : 1.3;
        double currentScale =
            currentIsCenter
                ? currentScaleFactor * centerMultiplier
                : currentScaleFactor;

        // Use the EXACT same _calculateCardDimensions method as main cards
        Map<String, double> phantomDimensions = _calculateCardDimensions(
          baseCardWidth,
          currentScale,
          screenSize,
        );
        double phantomCardWidth = phantomDimensions['width']!;
        double phantomCardHeight = phantomDimensions['height']!;

        // Use the same slide distance calculation as main cards
        // The phantom card should slide the same distance as other cards
        double slideDistance = phantomCardWidth + horizontalSpacing * 2;
        // For forward animation: phantom [6] starts at [5] position and slides off-screen left
        // Start at 0 (at [5] position), end at -slideDistance (off-screen left)
        double slideOffset = -slideDistance * _animation.value;

        // Calculate colors for the phantom card (same as [5] position)
        List<Color> phantomColors = _getCardColors(phantomIndex, centerIndex);
        Color phantomBorderColor = _getCardBorderColor(
          phantomIndex,
          centerIndex,
        );

        // Calculate opacity: fade in from 0 to 100% opacity for [1] and [5] cards
        double phantomOpacity = _animation.value; // Always fade to 100% opacity

        // No need for vertical positioning calculation since we're using Transform.translate
        // The phantom card will be positioned relative to the main cards' Row

        phantomCards.add(
          Transform.translate(
            offset: Offset(
              slideOffset,
              0,
            ), // Use same relative positioning as main cards
            child: Opacity(
              opacity: phantomOpacity, // Fade in from 0 to target opacity
              child: Transform.scale(
                scale: 1.0, // Scale already applied in _calculateCardDimensions
                child: Container(
                  width: phantomCardWidth,
                  height: phantomCardHeight,
                  margin: EdgeInsets.symmetric(horizontal: horizontalSpacing),
                  padding: EdgeInsets.all(currentIsCenter ? 16.0 : 12.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: phantomColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(
                      color: phantomBorderColor,
                      width: currentIsCenter ? 3.0 : 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow:
                        currentIsCenter
                            ? [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ]
                            : null,
                  ),
                  child: _buildFlashcardContent(
                    newActualIndex,
                    phantomCardWidth,
                    phantomCardHeight,
                  ),
                ),
              ),
            ),
          ),
        );
      }
    } else {
      // Moving BACKWARD: phantom card slides in from the left to replace [1]
      int phantomIndex = 0; // Position [1]
      int newActualIndex = (currentIndex - centerIndex) + phantomIndex - 1;
      bool newCardExists =
          newActualIndex >= 0 && newActualIndex < flashcards.length;

      if (newCardExists) {
        // Use the EXACT same sizing logic as the [1] card in the main cards
        // Get the same scale factor as the [1] card
        double currentScaleFactor = _getScaleFactor(
          phantomIndex,
          centerIndex,
          screenSize.width,
        );
        bool currentIsCenter = phantomIndex == centerIndex;
        double centerMultiplier = widget.flashcardsOnScreen == 3 ? 1.5 : 1.3;
        double currentScale =
            currentIsCenter
                ? currentScaleFactor * centerMultiplier
                : currentScaleFactor;

        // Use the EXACT same _calculateCardDimensions method as main cards
        Map<String, double> phantomDimensions = _calculateCardDimensions(
          baseCardWidth,
          currentScale,
          screenSize,
        );
        double phantomCardWidth = phantomDimensions['width']!;
        double phantomCardHeight = phantomDimensions['height']!;

        // Calculate the exact position where the [1] card should be
        // This matches the Row's MainAxisAlignment.center behavior
        double totalCardsWidth =
            phantomCardWidth * widget.flashcardsOnScreen +
            horizontalSpacing * (widget.flashcardsOnScreen - 1);
        double rowStartX = (screenSize.width - totalCardsWidth) / 2;
        double cardPosition =
            rowStartX + phantomIndex * (phantomCardWidth + horizontalSpacing);

        // Calculate starting position (real left edge of the screen)
        double startOffset = -phantomCardWidth; // Start from real window edge
        double endOffset =
            cardPosition; // Final position (exact [1] card position)
        double slideOffset =
            startOffset + (endOffset - startOffset) * _animation.value;

        // Calculate colors for the phantom card (same as [1] position)
        List<Color> phantomColors = _getCardColors(phantomIndex, centerIndex);
        Color phantomBorderColor = _getCardBorderColor(
          phantomIndex,
          centerIndex,
        );

        // Calculate opacity: fade in from 0 to 100% opacity for [1] and [5] cards
        double phantomOpacity = _animation.value; // Always fade to 100% opacity

        // Calculate the exact vertical position to match the main cards
        // The main cards are positioned within a Container with padding inside a Center widget
        double timerHeight = widget.showAllAtOnce ? 0 : 80; // Timer height
        double stackHeight =
            screenSize.height - timerHeight; // Full height of the Stack

        // The Container has vertical padding that affects the main cards' position
        double verticalPadding =
            widget.showAllAtOnce
                ? screenSize.height *
                    0.02 // Minimal padding in quiz mode
                : widget.flashcardsOnScreen == 1
                ? screenSize.height *
                    0.05 // More padding for flip animation in 1-card mode
                : screenSize.height *
                    0.03; // Minimal padding for slide animation in multi-card mode

        // The main cards are centered within the Container's content area (after padding)
        double containerContentHeight = stackHeight - verticalPadding * 2;
        double cardCenterY =
            (containerContentHeight - phantomCardHeight) / 2 + verticalPadding;

        phantomCards.add(
          Positioned(
            left: slideOffset,
            top:
                cardCenterY, // Position to match the main cards' vertical center
            child: Opacity(
              opacity: phantomOpacity, // Fade in from 0 to target opacity
              child: Transform.scale(
                scale: 1.0, // Scale already applied in _calculateCardDimensions
                child: Container(
                  width: phantomCardWidth,
                  height: phantomCardHeight,
                  margin: EdgeInsets.symmetric(horizontal: horizontalSpacing),
                  padding: EdgeInsets.all(currentIsCenter ? 16.0 : 12.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: phantomColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(
                      color: phantomBorderColor,
                      width: currentIsCenter ? 3.0 : 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow:
                        currentIsCenter
                            ? [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ]
                            : null,
                  ),
                  child: _buildFlashcardContent(
                    newActualIndex,
                    phantomCardWidth,
                    phantomCardHeight,
                  ),
                ),
              ),
            ),
          ),
        );
      }
    }

    return phantomCards;
  }

  Widget _buildFlashcardContent(
    int actualIndex,
    double cardWidth,
    double cardHeight,
  ) {
    // Extract the content part from _buildFlashcard for use in phantom cards
    int centerIndex = widget.flashcardsOnScreen ~/ 2;
    int distance = (actualIndex - centerIndex).abs();
    bool isCenterCard = distance == 0;
    bool isEdgeCard = distance > 1;

    // Item number font size (scales with card width)
    double titleFontSize = cardWidth * 0.10;

    // Expression font size (scales with card width, larger for center card)
    double expressionFontSize =
        isCenterCard ? cardWidth * 0.22 : cardWidth * 0.18;
    // Cap expression font size relative to height to prevent overflow
    expressionFontSize = min(expressionFontSize, cardHeight * 0.24);

    // Format the expression for display
    List<String> expressionLines = _formatExpression(
      flashcards[actualIndex]['expression'].toString(),
    );

    return Opacity(
      opacity: isEdgeCard ? 0.25 : 1.0, // 25% opacity for edge cards
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Item number - left aligned with dynamic font size
          Text(
            '# ${actualIndex + 1}',
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Complete expression and answer section unified
          Expanded(
            flex: 4,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final String numerator =
                    expressionLines.isNotEmpty ? expressionLines[0] : '';
                final String opDen =
                    expressionLines.length >= 2 ? expressionLines[1] : '';
                String operatorChar = '';
                String denominator = '';
                if (opDen.isNotEmpty) {
                  final parts = opDen.trim().split(' ');
                  operatorChar = parts.isNotEmpty ? parts[0] : '';
                  denominator =
                      parts.length > 1 ? parts.sublist(1).join(' ') : '';
                }
                final double exprFont = min(
                  expressionFontSize * 2,
                  cardHeight * 0.2,
                );
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        numerator,
                        style: TextStyle(
                          fontSize: exprFont,
                          fontFamily: 'Courier',
                          fontWeight: FontWeight.w600,
                          height: 1.0,
                        ),
                        textAlign: TextAlign.right,
                        softWrap: false,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    SizedBox(height: cardHeight * 0.01),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '$operatorChar     $denominator', // 5 spaces between operator and denominator
                        style: TextStyle(
                          fontSize: exprFont,
                          fontFamily: 'Courier',
                          fontWeight: FontWeight.w600,
                          height: 1.0,
                        ),
                        textAlign: TextAlign.right,
                        softWrap: false,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Container(
                      width: cardWidth * 0.95, // Extend line to both ends
                      margin: EdgeInsets.only(
                        top: max(1.0, cardHeight * 0.003),
                      ),
                      height: max(1.0, cardHeight * 0.005),
                      color: Colors.black,
                    ),
                    SizedBox(height: cardHeight * 0.005),
                    // Answer integrated in the same section
                    Container(
                      height: cardHeight * 0.20,
                      alignment: Alignment.centerRight,
                      child:
                          (actualIndex >= 0 &&
                                  actualIndex < flashcards.length &&
                                  revealedCards.contains(actualIndex))
                              ? FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  _formatAnswer(
                                    flashcards[actualIndex]['answer'],
                                  ),
                                  style: TextStyle(
                                    fontSize: exprFont,
                                    fontFamily: 'Courier',
                                    fontWeight: FontWeight.w600,
                                    height: 1.0,
                                  ),
                                  textAlign: TextAlign.right,
                                  softWrap: false,
                                  overflow: TextOverflow.clip,
                                ),
                              )
                              : null,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/BG.png'),
          fit: BoxFit.none,
          repeat: ImageRepeat.repeat,
          scale: 4.0, // 25% of original size (1/4 = 0.25)
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Solve the given operations.',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: _getResponsiveFontSize(screenSize.width, 40),
                ),
              ),
              if (!widget.showAllAtOnce)
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Progress ${flashcards.isEmpty ? "0" : "${currentIndex + 1}"} of ${flashcards.length}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: _getResponsiveFontSize(
                              screenSize.width,
                              screenSize.width < 1024 ? 28 : 32,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          width: screenSize.width < 1024 ? 150 : 200,
                          height: 12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.grey.shade300,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: LinearProgressIndicator(
                              value:
                                  flashcards.isEmpty
                                      ? 0
                                      : (currentIndex + 1) / flashcards.length,
                              backgroundColor: Colors.transparent,
                              color: Colors.blue,
                              minHeight: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 24),
                  ],
                ),
            ],
          ),
          centerTitle: false,
          automaticallyImplyLeading: false, // Hide back button
          actions: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () async {
                // Pause timer and stop auto-advance when dialog opens
                bool wasPaused = _isPaused;
                bool wasAutoAdvanceCanceled = _autoAdvanceCanceled;
                if (!_isPaused && widget.scrollTime > 0) {
                  _isPaused = true;
                  _autoAdvanceCanceled = true;
                  _pauseTimer();
                  _autoAdvanceTimer?.cancel();
                }

                final String? action = await showDialog<String>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Return to Home?'),
                      content: const Text(
                        'The current set will be lost if you proceed. Do you want to save the answer key?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop('cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop('exit'),
                          child: const Text('Exit without Saving'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop('save'),
                          child: const Text('Save and Exit'),
                        ),
                      ],
                    );
                  },
                );

                // Resume timer and auto-advance when dialog closes (if they weren't paused before)
                if (!wasPaused &&
                    !wasAutoAdvanceCanceled &&
                    widget.scrollTime > 0) {
                  _isPaused = false;
                  _autoAdvanceCanceled = false;
                  // Resume timer from where it was paused
                  _resumeTimer();
                  _restartAutoAdvance();
                }

                if (action == 'save') {
                  // Save the answer file before exiting
                  await _saveAnswerFile();
                  if (!mounted) return;
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const OpeningScreen(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                } else if (action == 'exit') {
                  if (!mounted) return;
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const OpeningScreen(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                }
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Countdown timer above cards (only in single card mode)
              if (!widget.showAllAtOnce && widget.scrollTime > 0)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Text(
                    _isPaused
                        ? 'Paused. Press arrow buttons to move cards or press "Resume" to auto-move cards again.'
                        : (_isTimerRunning
                            ? 'Time Remaining: ${_countdownSeconds}s'
                            : 'Starting...'),
                    style: TextStyle(
                      fontSize: _getResponsiveFontSize(screenSize.width, 24),
                      fontWeight: FontWeight.bold,
                      color:
                          _isPaused
                              ? Colors.orange.shade700
                              : (_countdownSeconds <= 3
                                  ? Colors.red.shade700
                                  : Colors.blue.shade700),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              // Flashcards container with background - give it most of the available space
              Expanded(
                flex: widget.showAllAtOnce ? 6 : 5, // More space in quiz mode
                child: Stack(
                  clipBehavior:
                      widget.flashcardsOnScreen == 1
                          ? Clip
                              .hardEdge // Clip for 1-card mode to prevent overlap
                          : Clip
                              .none, // Allow cards to extend beyond bounds during slide animation
                  children: [
                    // Cards on top of the background with extra padding for animation
                    Center(
                      child: Container(
                        // Add extra padding to prevent clipping during 3D rotation
                        padding: EdgeInsets.symmetric(
                          vertical:
                              widget.showAllAtOnce
                                  ? screenSize.height *
                                      0.02 // Minimal padding in quiz mode
                                  : widget.flashcardsOnScreen == 1
                                  ? screenSize.height *
                                      0.05 // More padding for flip animation in 1-card mode
                                  : screenSize.height *
                                      0.03, // Minimal padding for slide animation in multi-card mode
                          horizontal: screenSize.width * 0.05,
                        ),
                        child:
                            widget.showAllAtOnce
                                ? _buildGrid(screenSize)
                                : SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  physics: const NeverScrollableScrollPhysics(),
                                  clipBehavior:
                                      Clip.none, // Prevent clipping during animation
                                  child: Stack(
                                    children: [
                                      // Main cards row with phantom cards
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // Main cards
                                          for (
                                            int i = 0;
                                            i < widget.flashcardsOnScreen;
                                            i++
                                          )
                                            Center(
                                              child: GestureDetector(
                                                onTap: () {
                                                  bool showingCurrent =
                                                      !isFlipping ||
                                                      _animation.value >= 0.5;
                                                  int activeIndex =
                                                      showingCurrent
                                                          ? currentIndex
                                                          : previousIndex;
                                                  int centerIndex =
                                                      widget
                                                          .flashcardsOnScreen ~/
                                                      2;
                                                  int actualIndex =
                                                      (activeIndex -
                                                          centerIndex) +
                                                      i;
                                                  if (actualIndex >= 0 &&
                                                      actualIndex <
                                                          flashcards.length) {
                                                    setState(() {
                                                      if (revealedCards
                                                          .contains(
                                                            actualIndex,
                                                          )) {
                                                        revealedCards.remove(
                                                          actualIndex,
                                                        );
                                                      } else {
                                                        revealedCards.add(
                                                          actualIndex,
                                                        );
                                                      }
                                                    });
                                                  }
                                                },
                                                child:
                                                    isFlipping
                                                        ? _buildSlideAnimation(
                                                          i,
                                                          screenSize,
                                                        )
                                                        : _buildFlashcard(
                                                          i,
                                                          true,
                                                          screenSize,
                                                        ),
                                              ),
                                            ),
                                          // Phantom cards for smooth edge transitions
                                          if (isFlipping)
                                            ..._buildPhantomCards(screenSize),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                      ),
                    ),
                  ],
                ),
              ),
              // Navigation buttons - fixed height at bottom
              Container(
                height: 80,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed:
                          (widget.showAllAtOnce
                                  ? currentSetStartIndex > 0
                                  : currentIndex > 0)
                              ? scrollBack
                              : null, // Disable when at first card
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.05,
                          vertical: 12,
                        ),
                      ),
                      child: Icon(Icons.arrow_back),
                    ),
                    SizedBox(width: screenSize.width * 0.05),
                    if (!(widget.scrollTime == 0 && !widget.showAllAtOnce)) ...[
                      ElevatedButton(
                        onPressed: () {
                          if (widget.showAllAtOnce) {
                            setState(() {
                              int end = (currentSetStartIndex + 10).clamp(
                                0,
                                flashcards.length,
                              );
                              bool allVisibleRevealed = true;
                              for (int i = currentSetStartIndex; i < end; i++) {
                                if (!revealedCards.contains(i)) {
                                  allVisibleRevealed = false;
                                  break;
                                }
                              }
                              if (allVisibleRevealed) {
                                for (
                                  int i = currentSetStartIndex;
                                  i < end;
                                  i++
                                ) {
                                  revealedCards.remove(i);
                                }
                              } else {
                                for (
                                  int i = currentSetStartIndex;
                                  i < end;
                                  i++
                                ) {
                                  revealedCards.add(i);
                                }
                              }
                            });
                          } else {
                            setState(() {
                              if (_autoAdvanceCanceled || _isPaused) {
                                // Resume
                                _autoAdvanceCanceled = false;
                                _isPaused = false;
                                _resumeTimer();
                                _restartAutoAdvance();
                              } else {
                                // Pause
                                _autoAdvanceCanceled = true;
                                _isPaused = true;
                                _pauseTimer();
                                _autoAdvanceTimer?.cancel();
                              }
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 0.05,
                            vertical: 12,
                          ),
                        ),
                        child: Text(
                          widget.showAllAtOnce
                              ? () {
                                // Check if all visible cards in current set are revealed
                                int end = (currentSetStartIndex + 10).clamp(
                                  0,
                                  flashcards.length,
                                );
                                bool allVisibleRevealed = true;
                                for (
                                  int i = currentSetStartIndex;
                                  i < end;
                                  i++
                                ) {
                                  if (!revealedCards.contains(i)) {
                                    allVisibleRevealed = false;
                                    break;
                                  }
                                }
                                return allVisibleRevealed
                                    ? 'Hide Answers'
                                    : 'Show Answers';
                              }()
                              : (_autoAdvanceCanceled ? 'Resume' : 'Pause'),
                        ),
                      ),
                    ],
                    if (!widget.showAllAtOnce) ...[
                      SizedBox(width: screenSize.width * 0.02),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            // Toggle all cards - if any are revealed, hide all; if none are revealed, show all
                            bool anyRevealed = revealedCards.isNotEmpty;
                            if (anyRevealed) {
                              revealedCards.clear();
                            } else {
                              for (int i = 0; i < flashcards.length; i++) {
                                revealedCards.add(i);
                              }
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 0.03,
                            vertical: 12,
                          ),
                        ),
                        child: Text(
                          revealedCards.isEmpty
                              ? 'Show Answers'
                              : 'Hide Answers',
                        ),
                      ),
                    ],
                    SizedBox(width: screenSize.width * 0.05),
                    ElevatedButton(
                      onPressed:
                          (widget.showAllAtOnce
                                  ? currentSetStartIndex + 10 <
                                      flashcards.length
                                  : currentIndex < flashcards.length - 1)
                              ? scrollForward
                              : null, // Disable when at last card
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.05,
                          vertical: 12,
                        ),
                      ),
                      child: Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGrid(Size screenSize) {
    // Show up to 10 cards per set in a balanced 2-row layout
    int end = (currentSetStartIndex + 10).clamp(0, flashcards.length);
    final visibleIndices = List<int>.generate(
      end - currentSetStartIndex,
      (i) => currentSetStartIndex + i,
    );

    int totalCards = visibleIndices.length;
    if (totalCards == 0) return const SizedBox.shrink();

    // Calculate optimal layout to avoid 3rd row
    int columns = _calculateOptimalColumns(totalCards, screenSize);
    int rows = (totalCards / columns).ceil();

    // Ensure we don't exceed 2 rows by adjusting columns if needed
    if (rows > 2) {
      columns = (totalCards / 2).ceil();
      rows = 2;
    }

    double gridPadding = screenSize.width * 0.02;
    double availableWidth =
        screenSize.width * 0.9 - gridPadding * (columns - 1);
    double cardWidth = availableWidth / columns;
    double cardHeight = cardWidth * 1.5;

    // Cap card height to prevent overflow
    double maxHeight = screenSize.height * 0.35;
    if (cardHeight > maxHeight) {
      cardHeight = maxHeight;
      cardWidth = cardHeight / 1.5;
    }

    // Create rows with balanced distribution
    List<Widget> rowWidgets = [];
    for (int row = 0; row < rows; row++) {
      List<Widget> rowCards = [];
      int startIndex = row * columns;
      int endIndex = min(startIndex + columns, totalCards);

      for (int i = startIndex; i < endIndex; i++) {
        int actualIndex = visibleIndices[i];
        rowCards.add(
          GestureDetector(
            onTap: () {
              setState(() {
                if (revealedCards.contains(actualIndex)) {
                  revealedCards.remove(actualIndex);
                } else {
                  revealedCards.add(actualIndex);
                }
              });
            },
            child: _buildGridCard(actualIndex, cardWidth, cardHeight),
          ),
        );

        // Add spacing between cards (except for the last card in the row)
        if (i < endIndex - 1) {
          rowCards.add(SizedBox(width: gridPadding));
        }
      }

      // Center the row if it has fewer cards than the maximum
      if (rowCards.length < columns * 2 - 1) {
        // *2 because we add spacing between cards
        rowWidgets.add(
          Row(mainAxisAlignment: MainAxisAlignment.center, children: rowCards),
        );
      } else {
        rowWidgets.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: rowCards,
          ),
        );
      }

      // Add spacing between rows (except for the last row)
      if (row < rows - 1) {
        rowWidgets.add(SizedBox(height: gridPadding));
      }
    }

    return SizedBox(
      width: screenSize.width * 0.95,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: rowWidgets,
      ),
    );
  }

  // Calculate optimal number of columns to avoid 3rd row
  int _calculateOptimalColumns(int totalCards, Size screenSize) {
    // Start with 5 columns for wide screens
    int columns = 5;

    // For smaller screens, reduce columns to prevent 3rd row
    if (screenSize.width < 800) {
      columns = 4;
    }
    if (screenSize.width < 600) {
      columns = 3;
    }
    if (screenSize.width < 400) {
      columns = 2;
    }

    // Ensure we don't create more than 2 rows
    int rows = (totalCards / columns).ceil();
    if (rows > 2) {
      columns = (totalCards / 2).ceil();
    }

    return columns;
  }

  Widget _buildGridCard(int actualIndex, double cardWidth, double cardHeight) {
    double titleFontSize = cardWidth * 0.10;
    double expressionFontSize = min(cardWidth * 0.18, cardHeight * 0.24);

    List<String> expressionLines = _formatExpression(
      flashcards[actualIndex]['expression'].toString(),
    );

    return Container(
      width: cardWidth,
      height: cardHeight,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.grey[300]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.blue, width: 1.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '# ${actualIndex + 1}',
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Complete expression and answer section unified
          Expanded(
            flex: 4,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final String numerator =
                    expressionLines.isNotEmpty ? expressionLines[0] : '';
                final String opDen =
                    expressionLines.length >= 2 ? expressionLines[1] : '';
                String operatorChar = '';
                String denominator = '';
                if (opDen.isNotEmpty) {
                  final parts = opDen.trim().split(' ');
                  operatorChar = parts.isNotEmpty ? parts[0] : '';
                  denominator =
                      parts.length > 1 ? parts.sublist(1).join(' ') : '';
                }
                final double exprFont = min(
                  expressionFontSize * 2,
                  cardHeight * 0.2,
                );
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        numerator,
                        style: TextStyle(
                          fontSize: exprFont,
                          fontFamily: 'Courier',
                          fontWeight: FontWeight.w600,
                          height: 1.0,
                        ),
                        textAlign: TextAlign.right,
                        softWrap: false,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    SizedBox(height: cardHeight * 0.01),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '$operatorChar     $denominator', // 5 spaces between operator and denominator
                        style: TextStyle(
                          fontSize: exprFont,
                          fontFamily: 'Courier',
                          fontWeight: FontWeight.w600,
                          height: 1.0,
                        ),
                        textAlign: TextAlign.right,
                        softWrap: false,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Container(
                      width: cardWidth * 0.95, // Extend line to both ends
                      margin: EdgeInsets.only(
                        top: max(1.0, cardHeight * 0.003),
                      ),
                      height: max(1.0, cardHeight * 0.005),
                      color: Colors.black,
                    ),
                    SizedBox(height: cardHeight * 0.005),
                    // Answer integrated in the same section
                    Container(
                      height: cardHeight * 0.20,
                      alignment: Alignment.centerRight,
                      child:
                          revealedCards.contains(actualIndex)
                              ? FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  _formatAnswer(
                                    flashcards[actualIndex]['answer'],
                                  ),
                                  style: TextStyle(
                                    fontSize: exprFont,
                                    fontFamily: 'Courier',
                                    fontWeight: FontWeight.w600,
                                    height: 1.0,
                                  ),
                                  textAlign: TextAlign.right,
                                  softWrap: false,
                                  overflow: TextOverflow.clip,
                                ),
                              )
                              : null,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
