import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:io';
import 'dart:convert';
import 'dart:html' as html;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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
  List<String> operators = ['+', '-', '*', '/'];
  int scrollTime = 5000;
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
              Image.asset('assets/Logo.png', width: 300, height: 300),
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
                                        const Text(
                                          '"Bridging traditional drills with digital practice."',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 16),
                                        const Text(
                                          'The E-Drill Generator is a digital flashcard tool designed to support teachers in reinforcing learners\' basic arithmetic skills. It provides interactive drills that promote accuracy and mastery of fundamental operations, making classroom practice more efficient and engaging.',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(height: 16),
                                        const Text(
                                          'Math Flash aims to help learners build speed, accuracy, and confidence in solving basic arithmetic through fun and interactive drill exercises.',
                                          style: TextStyle(fontSize: 14),
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
                                        const Text(
                                          '• Choose from Addition, Subtraction, Multiplication, or Division buttons to automatically start a ready-made drill that consists of 30 items of the chosen operation.',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(height: 12),
                                        const Text(
                                          '2. Customize your Drills',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const Text(
                                          '• Click Customize Drill ⚙️ to adjust settings such as the number of items, operators, speed, digits, and flashcards on screen.',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        const Text(
                                          '• Tick Quiz Mode to show all cards at once (maximum 10 per slide).',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(height: 12),
                                        const Text(
                                          '3. Start the Drill',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const Text(
                                          '• Press Start ▶️ to begin. Flashcards will automatically slide to the left at the set speed.',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(height: 12),
                                        const Text(
                                          '4. Check and Review',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const Text(
                                          '• Click a card 👆to see its answer, or use the Show Answers button to reveal all answers at once for review.',
                                          style: TextStyle(fontSize: 14),
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
          title: const Text('Settings'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                _buildNumberOfItemsSlider(),
                _buildOperatorCheckboxes(),
                _buildScrollTimeSlider(),
                _buildNumeratorDigitsSlider(),
                _buildDenominatorDigitsSlider(),
                _buildFlashcardsOnScreenSlider(),
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
            const Text('Operators:'),
            Wrap(
              spacing: 15.0,
              alignment: WrapAlignment.center,
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
                          operators.remove(internalOperator);
                        } else {
                          operators.add(internalOperator);
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        operator,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color:
                              operators.contains(
                                    operator == '×'
                                        ? '*'
                                        : operator == '÷'
                                        ? '/'
                                        : operator,
                                  )
                                  ? Colors.black
                                  : Colors.grey,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
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
                const Text('5', style: TextStyle(fontSize: 12)),
                Expanded(
                  child: Slider(
                    value: (scrollTime / 1000).toDouble(),
                    min: 5,
                    max: 60,
                    divisions: 11,
                    label: (scrollTime / 1000).toString(),
                    onChanged: (double value) {
                      setInnerState(() {
                        scrollTime = (value * 1000).toInt();
                        // Ensure the value is a multiple of 5
                        scrollTime = ((scrollTime ~/ 5000) * 5000);
                        if (scrollTime < 5000) scrollTime = 5000;
                      });
                    },
                  ),
                ),
                const Text('60', style: TextStyle(fontSize: 12)),
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
                const Text('5', style: TextStyle(fontSize: 12)),
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
                const Text('50', style: TextStyle(fontSize: 12)),
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
                const Text('1', style: TextStyle(fontSize: 12)),
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
                const Text('3', style: TextStyle(fontSize: 12)),
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
                const Text('1', style: TextStyle(fontSize: 12)),
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
                const Text('3', style: TextStyle(fontSize: 12)),
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
                const Text('1', style: TextStyle(fontSize: 12)),
                Expanded(
                  child: Slider(
                    value: flashcardsOnScreen.toDouble(),
                    min: 1,
                    max: 5, // Reduced max from 10 to 5 to prevent overlapping
                    divisions: 4,
                    label: flashcardsOnScreen.toString(),
                    onChanged: (double value) {
                      setInnerState(() {
                        flashcardsOnScreen = value.round();
                      });
                    },
                  ),
                ),
                const Text('5', style: TextStyle(fontSize: 12)),
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
            const Text('Allow Negative Integers'),
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
            const Expanded(child: Text('Quiz Mode (Show 10 cards per set)')),
          ],
        );
      },
    );
  }

  void _startApp(BuildContext context) {
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
  }

  void _startPreset(String operator) {
    setState(() {
      operators = [operator];
      numFlashcards = 30;
      maxNumeratorDigits =
          operator == '/' ? 2 : 1; // 2 digits for division, 1 for others
      maxDenominatorDigits = 1;
      scrollTime = 8000; // 8 seconds
      flashcardsOnScreen = 5;
      allowNegativeIntegers = true;
      showAllAtOnce = false;
      divisionWholeOnly = operator == '/';
    });

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

  @override
  void initState() {
    super.initState();
    generateFlashcards();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
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
    // Start auto-advance behavior only in single-card mode
    if (!widget.showAllAtOnce) {
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

    for (int i = 0; i < widget.numFlashcards; i++) {
      int num1;
      int num2;

      // Generate numbers based on allowNegativeIntegers setting
      if (widget.allowNegativeIntegers) {
        // Generate numbers that can be negative
        num1 =
            Random().nextInt(pow(10, widget.maxNumeratorDigits).toInt() * 2) -
            pow(10, widget.maxNumeratorDigits).toInt();
        num2 =
            Random().nextInt(pow(10, widget.maxDenominatorDigits).toInt() * 2) -
            pow(10, widget.maxDenominatorDigits).toInt();
      } else {
        // Generate only positive numbers
        num1 = Random().nextInt(pow(10, widget.maxNumeratorDigits).toInt());
        num2 = Random().nextInt(pow(10, widget.maxDenominatorDigits).toInt());
      }

      String operator =
          widget.operators[Random().nextInt(widget.operators.length)];

      // Ensure non-zero denominator for division and modulo
      if (operator == '/' || operator == '%') {
        // Make sure num2 is not zero for division and modulo
        if (num2 == 0) {
          num2 = Random().nextInt(9) + 1; // Always positive 1-9
        }

        // For division and modulo, ensure numerator is larger than denominator
        if (num1.abs() < num2.abs()) {
          // Swap num1 and num2 to ensure num1 is larger
          int temp = num1;
          num1 = num2;
          num2 = temp;
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
        int sign = widget.allowNegativeIntegers && Random().nextBool() ? -1 : 1;
        int product = baseDen * multiplier * sign;
        num2 = baseDen;
        num1 = product;
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

    // Generate answer key file
    _generateAnswerKeyFile(answerKeyLines);
  }

  void _generateAnswerKeyFile(List<String> lines) async {
    try {
      DateTime now = DateTime.now();
      String fileName =
          '${_getMonthName(now.month)}_${now.day.toString().padLeft(2, '0')}_${now.year}_${now.hour.toString().padLeft(2, '0')}_${now.minute.toString().padLeft(2, '0')}.txt';

      if (kIsWeb) {
        // Web version: create downloadable file
        String content = lines.join('\n');
        final bytes = utf8.encode(content);
        final blob = html.Blob([bytes]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor =
            html.AnchorElement(href: url)
              ..setAttribute('download', fileName)
              ..click();
        html.Url.revokeObjectUrl(url);
        print('Answer key downloaded: $fileName');
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
    super.dispose();
  }

  void _startAutoAdvance() {
    if (widget.showAllAtOnce) return; // Disable auto-scroll in show-all mode
    if (_autoAdvanceActive) return;
    if (_autoAdvanceCanceled) return; // Do not start if canceled
    _autoAdvanceActive = true;
    Future<void>.delayed(Duration(milliseconds: widget.scrollTime), () {
      if (!mounted) return;
      if (_autoAdvanceCanceled) {
        // Stop rescheduling if canceled
        _autoAdvanceActive = false;
        return;
      }
      if (!widget.showAllAtOnce) {
        if (currentIndex < flashcards.length - 1) {
          scrollForward();
        }
      }
      _autoAdvanceActive = false;
      if (mounted) {
        if (!widget.showAllAtOnce && !_autoAdvanceCanceled) {
          _startAutoAdvance();
        }
      }
    });
  }

  // Calculate the scale factor for a card based on its distance from the center
  double _getScaleFactor(int index, int centerIndex, double screenWidth) {
    // Calculate distance from centerIndex
    int distance = (index - centerIndex).abs();

    // Center card is twice as large (scale factor 1.0)
    // Cards further away get progressively smaller
    if (distance == 0) {
      return 1.0; // Center card - normal size (will be doubled in the widget)
    } else {
      // Scale decreases as distance increases, but also adjusted for screen width
      double baseScale = max(0.5, 1.0 - (distance * 0.2));

      // For very small screens, reduce scale even more to prevent overlapping
      if (screenWidth < 600) {
        baseScale = max(0.4, baseScale - (600 - screenWidth) / 2000);
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

  Widget _buildFlashcard(int index, bool isCurrentCard, Size screenSize) {
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

    // Calculate maximum card width based on screen size and number of visible cards
    double maxCardWidth = screenSize.width * 0.85 / widget.flashcardsOnScreen;
    // Adjust base card width - smaller for more cards on screen
    double baseCardWidth = min(screenSize.width * 0.35, maxCardWidth);

    // Calculate scale factor based on position relative to center
    double scaleFactor = _getScaleFactor(index, centerIndex, screenSize.width);

    // Center card gets a scale factor of 2.0 (twice as large)
    bool isCenterCard = index == centerIndex;
    double finalScale = isCenterCard ? scaleFactor * 2.0 : scaleFactor;

    // Determine horizontal spacing based on screen width
    double horizontalSpacing = screenSize.width * 0.02;

    // Adjust card size based on screen size and scale
    double cardWidth = baseCardWidth * finalScale;
    double cardHeight = cardWidth * 1.6; // Slightly taller for readability

    // For very small screens, cap the maximum card height
    if (cardHeight > screenSize.height * 0.6) {
      cardHeight = screenSize.height * 0.6;
      cardWidth = cardHeight / 1.5;
    }

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
          colors:
              isCenterCard
                  ? [Colors.lightBlue.shade50, Colors.lightBlue.shade100]
                  : [Colors.white, Colors.grey[300]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: isCenterCard ? Colors.blue.shade700 : Colors.blue,
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
          title: const Text(''),
          automaticallyImplyLeading: false, // Hide back button
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () async {
                final bool? confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Return to Start?'),
                      content: const Text(
                        'The current set will be lost if you proceed. Do you want to continue?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('Yes'),
                        ),
                      ],
                    );
                  },
                );
                if (confirm == true) {
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
              // Top row: instructions left, progress right
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Solve the given operations',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                    if (!widget.showAllAtOnce)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Progress ${flashcards.isEmpty ? "0" : "${currentIndex + 1}"} of ${flashcards.length}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            width: 150,
                            height: 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.grey.shade300,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value:
                                    flashcards.isEmpty
                                        ? 0
                                        : (currentIndex + 1) /
                                            flashcards.length,
                                backgroundColor: Colors.transparent,
                                color: Colors.blue,
                                minHeight: 8,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              // Flashcards container - give it most of the available space
              Expanded(
                flex: 5,
                child: Center(
                  child:
                      widget.showAllAtOnce
                          ? _buildGrid(screenSize)
                          : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (
                                  int i = 0;
                                  i < widget.flashcardsOnScreen;
                                  i++
                                )
                                  GestureDetector(
                                    onTap: () {
                                      bool showingCurrent =
                                          !isFlipping ||
                                          _animation.value >= 0.5;
                                      int activeIndex =
                                          showingCurrent
                                              ? currentIndex
                                              : previousIndex;
                                      int centerIndex =
                                          widget.flashcardsOnScreen ~/ 2;
                                      int actualIndex =
                                          (activeIndex - centerIndex) + i;
                                      if (actualIndex >= 0 &&
                                          actualIndex < flashcards.length) {
                                        setState(() {
                                          if (revealedCards.contains(
                                            actualIndex,
                                          )) {
                                            revealedCards.remove(actualIndex);
                                          } else {
                                            revealedCards.add(actualIndex);
                                          }
                                        });
                                      }
                                    },
                                    child:
                                        isFlipping
                                            ? Transform(
                                              transform:
                                                  Matrix4.identity()
                                                    ..setEntry(3, 2, 0.001)
                                                    ..rotateY(
                                                      _animation.value * pi,
                                                    ),
                                              alignment: Alignment.center,
                                              child:
                                                  _animation.value < 0.5
                                                      ? _buildFlashcard(
                                                        i,
                                                        false,
                                                        screenSize,
                                                      )
                                                      : Transform(
                                                        transform:
                                                            Matrix4.identity()
                                                              ..rotateY(pi),
                                                        alignment:
                                                            Alignment.center,
                                                        child: _buildFlashcard(
                                                          i,
                                                          true,
                                                          screenSize,
                                                        ),
                                                      ),
                                            )
                                            : _buildFlashcard(
                                              i,
                                              true,
                                              screenSize,
                                            ),
                                  ),
                              ],
                            ),
                          ),
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
                              for (int i = currentSetStartIndex; i < end; i++) {
                                revealedCards.remove(i);
                              }
                            } else {
                              for (int i = currentSetStartIndex; i < end; i++) {
                                revealedCards.add(i);
                              }
                            }
                          });
                        } else {
                          setState(() {
                            if (_autoAdvanceCanceled) {
                              _autoAdvanceCanceled = false;
                              _startAutoAdvance();
                            } else {
                              _autoAdvanceCanceled = true;
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
                              for (int i = currentSetStartIndex; i < end; i++) {
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
    // Show up to 10 cards per set in a 5x2 layout
    int end = (currentSetStartIndex + 10).clamp(0, flashcards.length);
    final visibleIndices = List<int>.generate(
      end - currentSetStartIndex,
      (i) => currentSetStartIndex + i,
    );

    double gridPadding = screenSize.width * 0.02;
    int columns = 5;
    double availableWidth =
        screenSize.width * 0.9 - gridPadding * (columns - 1);
    double cardWidth = availableWidth / columns;
    double cardHeight = cardWidth * 1.5;
    if (cardHeight > screenSize.height * 0.35) {
      cardHeight = screenSize.height * 0.35;
      cardWidth = cardHeight / 1.4;
    }

    return SizedBox(
      width: screenSize.width * 0.95,
      child: Wrap(
        spacing: gridPadding,
        runSpacing: gridPadding,
        alignment: WrapAlignment.center,
        children:
            visibleIndices.map((actualIndex) {
              return GestureDetector(
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
              );
            }).toList(),
      ),
    );
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
