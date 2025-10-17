import 'package:flutter/material.dart';
import 'pages/number_to_words_page.dart';
import 'pages/nested_sum_page.dart';

void main() {
  runApp(const Homework1SBApp());
}

class Homework1SBApp extends StatefulWidget {
  const Homework1SBApp({super.key});

  @override
  State<Homework1SBApp> createState() => _Homework1SBAppState();
}

class _Homework1SBAppState extends State<Homework1SBApp> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'homework_1_SB',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(_index == 0
              ? 'Number → Words'
              : 'Nested Structure Summation'),
        ),
        body: IndexedStack(
          index: _index,
          children: const [
            NumberToWordsPage(),
            NestedSumPage(),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: (i) => setState(() => _index = i),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.text_fields_outlined),
              selectedIcon: Icon(Icons.text_fields),
              label: 'Words',
            ),
            NavigationDestination(
              icon: Icon(Icons.calculate_outlined),
              selectedIcon: Icon(Icons.calculate),
              label: 'Sum',
            ),
          ],
        ),
      ),
    );
  }
}
