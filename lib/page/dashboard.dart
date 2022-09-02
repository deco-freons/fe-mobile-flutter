import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/layout/custom_bottom_navigation.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/page/create_event.dart';
import 'package:flutter_boilerplate/page/homepage.dart';
import 'package:flutter_boilerplate/page/search_events.dart';

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
  final SearchEvents _searchPage = const SearchEvents();
  final Widget _eventPage = const SizedBox();
  final Widget _historyPage = const SizedBox();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void handlePageChanged(int idx) {
    setState(() {
      _selectedPageIndex = idx;
      _pageController.animateToPage(idx,
          duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: Container(
          padding: const EdgeInsets.only(top: CustomPadding.lg),
          width: 80,
          height: 80,
          child: FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(
                Icons.add,
                size: 50,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () {
                Navigator.pushNamed(context, CreateEvent.routeName);
              }),
        ),
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
