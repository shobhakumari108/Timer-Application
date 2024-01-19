import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer_application/provider/timer_provider.dart';
import 'package:timer_application/screens/home_screen.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Timer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider<TimerProvider>(
        create: (context) => TimerProvider(),
        child: HomeScreen(),
      ),
    );
  }
}
