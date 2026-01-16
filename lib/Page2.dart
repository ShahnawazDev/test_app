// Page2.dart
import 'package:flutter/material.dart';

import 'navigation.dart';

class Page2 extends StatefulWidget {
  final void Function(TabController) onTabControllerCreated;

  const Page2({super.key, required this.onTabControllerCreated});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  Route<dynamic> _generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Tab 1'),
          ),
          body: Center(
            child: ElevatedButton(
              onPressed: () {
                Navigation.page2Tab1Key.currentState!.pushNamed('/second');
              },
              child: const Text('Push Page'),
            ),
          ),
        ),
      );
    case '/second':
      return MaterialPageRoute(
        builder: (context) => const Center(child: Text('New route for Tab 1')),
      );
    default:
      throw Exception('Invalid route: ${settings.name}');
  }
}

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this,initialIndex: 1);
    widget.onTabControllerCreated(_tabController!);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 2'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.home)),
            Tab(icon: Icon(Icons.search)),
            Tab(icon: Icon(Icons.person)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          WillPopScope(
            onWillPop: () async {
              if (Navigation.page2Tab1Key.currentState!.canPop()) {
                Navigation.page2Tab1Key.currentState!.pop();
                return Future.value(false);
              }
              return Future.value(true);
            },
            child: Navigator(
              key: Navigation.page2Tab1Key,
              onGenerateRoute: _generateRoute,
            ),
          ),
          WillPopScope(
            onWillPop: () async {
              if (Navigation.page2Tab2Key.currentState!.canPop()) {
                Navigation.page2Tab2Key.currentState!.pop();
                return Future.value(false);
              }
              return Future.value(true);
            },
            child: Navigator(
              key: Navigation.page2Tab2Key,
              onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => const Center(child: Text('Tab 2')),
              ),
            ),
          ),
          const Center(child: Text('Tab 3')), // No separate navigation for Tab 3
        ],
      ),
    );
  }
}