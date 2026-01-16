// main.dart
import 'package:flutter/material.dart';
import 'Page1.dart';
import 'Page2.dart';
import 'Page3.dart';
import 'Page4.dart'; // Import the Page4 class
import 'navigation.dart'; // Import the Navigation class

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  TabController? _page2TabController;
  late List<Widget> _pages = [];

  @override
  initState() {
    super.initState();
     _pages = [
  const Page1(),
  Page2(onTabControllerCreated: (controller) => _page2TabController = controller),
  const Page3(),
  const Page4(),
  ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        GlobalKey<NavigatorState> currentKey;
        switch (_currentIndex) {
          case 0:
            currentKey = Navigation.page1Key;
            break;
          case 1:
            int tabIndex = _page2TabController!.index;
            switch (tabIndex) {
              case 0:
                currentKey = Navigation.page2Tab1Key;
                break;
              case 1:
                currentKey = Navigation.page2Tab2Key;
                break;
              case 2:
                currentKey = Navigation.page1Key;
                if (_currentIndex != 0) {
                  setState(() {
                    _currentIndex = 0;
                  });
                  return false;
                }
                break;
              default:
                throw Exception('Invalid tab index: $tabIndex');
            }
            break;

          case 2:
            currentKey = Navigation.page3Key;
            break;
          case 3:
            // For Page4, navigate back to Page1
            currentKey = Navigation.page1Key;
            if (_currentIndex != 0) {
              setState(() {
                _currentIndex = 0;
              });
              return false;
            }
            break;
          default:
            throw Exception('Invalid page index: $_currentIndex');
        }
        final isFirstRouteInCurrentTab =
            !await currentKey.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentIndex != 0) {
            setState(() {
              _currentIndex = 0;
            });
            return false;
          }
        }
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Page 1',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Page 2',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Page 3',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Page 4',
            ),
          ],
        ),
      ),
    );
  }
}
