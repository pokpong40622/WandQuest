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
  int _remainingSeconds = 240; // 4 minutes
  
  // Separate progress variables for each player
  final int _totalProgress = 500;
  int _player1Progress = 150;
  int _player2Progress = 200;

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
        _showRewardDialog();
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

  String _formatTime(int seconds) {
    final minutes = (seconds / 60).floor().toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }

  void _showRewardDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
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
                  text: '300',
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
              ],
            ),
          ),
        );
      },
    );
  }

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
                  // "RACE" Title
                  Center(
                    child: GestureDetector(
                      onTap: _showPauseDialog,
                      child: Text(
                        'RACE',
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.18,
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Player 1 Progress Bar
                        _buildProgressBar(
                          context,
                          'Player1',
                          _player1Progress,
                          _totalProgress,
                        ),
                        // Player 2 Progress Bar
                        _buildProgressBar(
                          context,
                          'Player2',
                          _player2Progress,
                          _totalProgress,
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

  // Reusable widget for building a player's progress bar
  Widget _buildProgressBar(
    BuildContext context,
    String playerName,
    int currentProgress,
    int totalProgress,
  ) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final progressPercent = currentProgress / totalProgress;

    return Container(
      width: screenWidth * 0.4,
      height: screenHeight * 0.6,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Filled portion
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
            child: Column(
              children: [
                Text(
                  playerName,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '$currentProgress/$totalProgress',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
