import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import 'constants.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const chatapp());
}

class chatapp extends StatefulWidget {
  const chatapp({super.key});

  @override
  State<chatapp> createState() => _chatappState();
}

class _chatappState extends State<chatapp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: whitecolor
      ),
      home: welcomescreen(),
    );
  }
}
