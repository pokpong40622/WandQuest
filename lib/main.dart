import "package:flutter/material.dart";
import "package:flutter/services.dart"; // <-- import this
import "package:wandquest/MembershipPages/BMIResultPage.dart";
import "package:wandquest/MembershipPages/LoginPage.dart";
import "package:wandquest/MembershipPages/SignupPage.dart";
import "package:wandquest/MembershipPages/StartPage.dart";
import "package:wandquest/Pages/HomePage.dart";
import "package:wandquest/PoseGame/PosePlayingLevel3.dart";
import "package:wandquest/PoseGame/PoseStartLevel3.dart";
import "package:wandquest/RaceGame/RaceStartLevel3.dart";
import "package:wandquest/SqueezeGame/SqueezeStartLevel3.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hide status bar and navigation bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
