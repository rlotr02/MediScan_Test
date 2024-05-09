import 'package:flutter/material.dart';
import 'package:mediscan/capsluescan.dart';
import 'package:mediscan/theme/colors.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: whiteColor),
      home: const MyApp(),
    ));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        scrolledUnderElevation: 0,
        toolbarHeight: 65,
        title: const Text(
          'MediScan',
          style:
              TextStyle(color: mainColor, fontFamily: 'Inter900', fontSize: 24),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CapslueScan(),
              ),
            );
          },
          child: const Text('알약 스캔'),
        ),
      ),
    );
  }
}
