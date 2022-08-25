import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/navigation_bar/custom_bottom_navigation.dart';
import 'package:flutter_boilerplate/page/homepage.dart';

class Dashboard extends StatefulWidget {
  static const routeName = "/dashboard";
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final PageController _pageController = PageController(initialPage: 0);
  int _selectedPageIndex = 0;

  final Homepage _homePage = const Homepage();
  final Homepage _searchPage = const Homepage();
  final Homepage _eventPage = const Homepage();
  final Homepage _historyPage = const Homepage();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void handlePageChanged(int idx) {
    setState(() {
      _selectedPageIndex = idx;
      _pageController.animateToPage(idx,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {}),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[_homePage, _searchPage, _eventPage, _historyPage],
        ),
        bottomNavigationBar: CustomBottomNavigation(
          currentIndex: _selectedPageIndex,
          onTap: handlePageChanged,
          children: const <Icon>[
            Icon(Icons.home_outlined),
            Icon(Icons.search_outlined),
            Icon(Icons.edit_calendar_outlined),
            Icon(Icons.history_outlined)
          ],
        ));
  }
}
