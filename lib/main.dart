import 'package:chat_app/Screens/auth_screen/SignInScreen.dart';
import 'package:chat_app/Screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

int? initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = await preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.grey),
      color: Colors.black,
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _showWelcomeScreen = true;

  @override
  void initState() {
    super.initState();
    _checkIfShowWelcomeScreen();
  }

  _checkIfShowWelcomeScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool showWelcomeScreen = prefs.getBool('showWelcomeScreen') ?? true;

    if (showWelcomeScreen) {
      // Hiển thị màn hình chào mừng
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => StartScreen()),
      );

      // Lưu trạng thái đã hiển thị màn hình chào mừng
      prefs.setBool('showWelcomeScreen', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignInScreen(),
    );
  }
}



// app

