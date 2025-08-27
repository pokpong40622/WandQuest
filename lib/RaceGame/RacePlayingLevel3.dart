import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wandquest/colors.dart'; // Assuming this is where ColorsAsset.primary is.
import 'package:wandquest/Pages/HomePage.dart'; // Import your HomePage

// Reusable widget for text with a stroke and solid color fill
class StrokedText extends StatelessWidget {
  const StrokedText({
    super.key,
    required this.text,
    required this.color,
    this.fontSize = 14,
    this.strokeWidth = 3,
    this.fontWeight = FontWeight.w600,
    this.letterSpacing,
    this.strokeColor = Colors.white,
    this.shadows,
  });

  final String text;
  final Color color;
  final double fontSize;
  final double strokeWidth;
  final FontWeight fontWeight;
  final double? letterSpacing;
  final Color strokeColor;
  final List<Shadow>? shadows;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: fontSize,
            fontWeight: fontWeight,
            letterSpacing: letterSpacing,
            shadows: shadows,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = strokeColor,
          ),
        ),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: fontSize,
            fontWeight: fontWeight,
            letterSpacing: letterSpacing,
            shadows: shadows,
            color: color,
          ),
        ),
      ],
    );
  }
}

// Reusable widget for text with a stroke and gradient fill
class StrokedGradientText extends StatelessWidget {
  const StrokedGradientText({
    super.key,
    required this.text,
    required this.gradient,
    this.fontSize = 48,
    this.strokeWidth = 6,
    this.fontWeight = FontWeight.w800,
    this.shadows,
  });

  final String text;
  final Gradient gradient;
  final double fontSize;
  final double strokeWidth;
  final FontWeight fontWeight;
  final List<Shadow>? shadows;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // The Text Border (bottom layer)
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: fontSize,
            fontWeight: fontWeight,
            shadows: shadows,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = Colors.white,
          ),
        ),
        // The Gradient Fill (top layer)
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: fontSize,
            fontWeight: fontWeight,
            shadows: shadows,
            foreground: Paint()
              ..shader = gradient.createShader(
                Rect.fromLTWH(0.0, 0.0, fontSize * text.length * 0.5, fontSize),
              ),
          ),
        ),
      ],
    );
  }
}

class RacePlayingLevel3 extends StatefulWidget {
  const RacePlayingLevel3({super.key});

  @override
  State<RacePlayingLevel3> createState() => _RacePlayingLevel3State();
}

class _RacePlayingLevel3State extends State<RacePlayingLevel3> {
  // Timer and progress variables
  Timer? _timer;
  int _remainingSeconds = 150; // 2 minutes and 30 seconds
  final int _totalSqueezes = 300;
  int _currentSqueezes = 150;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
        print("times up!");
        _showRewardDialog(); // Show reward dialog when timer ends
      }
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // Helper to format the time
  String _formatTime(int seconds) {
    final minutes = (seconds / 60).floor().toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }

  // --- NEW REWARD DIALOG ---
  void _showRewardDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFF8827D7), width: 4),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const StrokedGradientText(
                  text: 'CONGRATULATION!',
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  strokeWidth: 5,
                  gradient: LinearGradient(colors: [Color(0xFFFE5190), Color(0xFF8827D7)]),
                ),
                const SizedBox(height: 22),
                const StrokedText(
                  text: 'REWARDS',
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  strokeWidth: 4,
                  strokeColor: Color(0xFF4c0082),
                ),
                const SizedBox(height: 6),
                const StrokedText(
                  text: '200',
                  color: Color(0xFF333333),
                  fontSize: 100,
                  fontWeight: FontWeight.w800,
                  strokeWidth: 8,
                  strokeColor: Colors.white,
                  shadows: [Shadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 5))],
                ),
                const StrokedGradientText(
                  text: 'R-POINTS',
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  strokeWidth: 4,
                  gradient: LinearGradient(colors: [Color(0xFFF99F3B), Color(0xFFE87A1C)]),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) =>  HomePage()),
                    );
                  },
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) =>  HomePage()),
                    );
                    },
                    child: Container(
                      width: 200,
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF06A59),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF4c0082), width: 3),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 8, offset: const Offset(0, 4))],
                      ),
                      child: const Center(
                        child: StrokedText(
                          text: 'RETURN',
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          strokeWidth: 4,
                          strokeColor: Color(0xFF4c0082),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // --- PAUSE DIALOG ---
  void _showPauseDialog() {
    _pauseTimer();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFF8827D7), width: 4),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    _startTimer();
                  },
                  child: Container(
                    width: 200,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFF63FF94),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF4c0082), width: 3),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 8, offset: const Offset(0, 4))],
                    ),
                    child: const Center(
                      child: StrokedText(
                        text: 'RESUME',
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        strokeWidth: 4,
                        strokeColor: Color(0xFF4c0082),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) =>  HomePage()),
                    );
                  },
                  child: Container(
                    width: 200,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF06A59),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF4c0082), width: 3),
                       boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 8, offset: const Offset(0, 4))],
                    ),
                    child: const Center(
                      child: StrokedText(
                        text: 'EXIT',
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        strokeWidth: 4,
                        strokeColor: Color(0xFF4c0082),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final progressPercent = _currentSqueezes / _totalSqueezes;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/SqueezeStartLevel3BG.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: BoxDecoration(gradient: ColorsAsset.primary),
                child: const Center(child: Text('Background not found', style: TextStyle(color: Colors.white))),
              );
            },
          ),
          // Main Content Column
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.042),
                  // "SQUEEZE" Title
                  Center(
                    child: GestureDetector(
                      onTap: _showPauseDialog,
                      child: Text(
                        'SQUEEZE',
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.156,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 3.2,
                        ),
                      ),
                    ),
                  ),
                  // Main content row
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Progress Bar
                        Container(
                          width: screenWidth * 0.35,
                          height: screenHeight * 0.55,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              // Filled portion of the progress bar
                              FractionallySizedBox(
                                heightFactor: progressPercent,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [Color(0xFFF99F3B), Color(0xFFF06A59)],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                              ),
                              // Progress Text
                              Positioned(
                                bottom: 16,
                                child: Text(
                                  '$_currentSqueezes/$_totalSqueezes',
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.056),
                        // Quest Info and Icon Column
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const StrokedText(
                                text: 'Quest:',
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.w800,
                                strokeWidth: 6,
                                strokeColor: Color(0xFF4c0082),
                              ),
                              const StrokedText(
                                text: '300 TIMES',
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                                strokeWidth: 6,
                                strokeColor: Color(0xFF4c0082),
                              ),
                              SizedBox(height: screenHeight * 0.08),
                              Image.asset(
                                'assets/SqueezeIcon.png',
                                width: screenWidth * 0.54,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.image_not_supported, size: 100, color: Colors.white,);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Timer at the bottom
                  Center(
                    child: StrokedGradientText(
                      text: _formatTime(_remainingSeconds),
                      fontSize: 80,
                      fontWeight: FontWeight.w800,
                      strokeWidth: 8,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF8E2DE2), Color(0xFFFE5190)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
