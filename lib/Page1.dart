// Page1.dart
import 'package:flutter/material.dart';

import 'navigation.dart';

class Page1 extends StatefulWidget {

  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  void pushPage() {
    Navigation.page1Key.currentState!.push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(),
          body: const Center(child: Text('New route for Page 1')),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Navigation.page1Key,
      onGenerateRoute: (settings) => MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Page 1'),
          ),
          body: Center(
            child: ElevatedButton(
              onPressed: pushPage,
              child: const Text('Push Page'),
            ),
          ),
        ),
      ),
    );
  }
}
