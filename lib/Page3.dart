// Page3.dart
import 'package:flutter/material.dart';

import 'navigation.dart';

class Page3 extends StatefulWidget {

  const Page3({super.key});

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  void pushPage() {
    Navigation.page3Key.currentState!.push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(),
          body: const Center(child: Text('New route for Page 3')),
        ),
      ),
    );
  }

  void pushInnerPage() {
    Navigation.page3InnerNavigatorKey.currentState!.push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(),
          body: const Center(child: Text('New route for inner Navigator in Page 3')),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Navigation.page3Key,
      onGenerateRoute: (settings) => MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Page 3'),
          ),
          body: Center(
            child: WillPopScope(
              onWillPop: () async {
                return !await Navigation.page3InnerNavigatorKey.currentState!.maybePop();
              },
              child: Navigator(
                key: Navigation.page3InnerNavigatorKey,
                onGenerateRoute: (settings) => MaterialPageRoute(
                  builder: (context) => Scaffold(
                    body: Center(
                      child: ElevatedButton(
                        onPressed: pushInnerPage,
                        child: const Text('Push Page on inner Navigator'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}