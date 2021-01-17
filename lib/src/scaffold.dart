import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../custom_widgets_wj.dart';

class AScaffold extends StatelessWidget {
  final Widget title;
  final Widget body;
  final Widget action;
  final bool isScrollable;
  AScaffold({this.title, this.body, this.action, this.isScrollable = true});

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) fixNavigationBarColor(context);
    final Widget defaultBodyWidget = SafeArea(child: body);

    if (Platform.isIOS) {
      if (title == null) return CupertinoPageScaffold(child: defaultBodyWidget);

      final Color navBorderColor = MediaQuery.of(context).platformBrightness == Brightness.dark ? DIVIDER_COLOR_DARK : DIVIDER_COLOR;
      final Border navBorder = Border(bottom: BorderSide(color: navBorderColor, width: 0.0, style: BorderStyle.solid));
      Widget appBar;

      if (isScrollable) {
        final Color color = CupertinoDynamicColor.withBrightness(color: SLIVER_COLOR, darkColor: SLIVER_COLOR_DARK);
        appBar = CupertinoSliverNavigationBar(border: navBorder, largeTitle: title, transitionBetweenRoutes: false, backgroundColor: color, trailing: action);
        return CupertinoPageScaffold(child: Scrollbar(child: CustomScrollView(slivers: [appBar, SliverToBoxAdapter(child: body)])));
      } else {
        appBar = CupertinoNavigationBar(border: navBorder, middle: title, transitionBetweenRoutes: false, trailing: action);
        return CupertinoPageScaffold(navigationBar: appBar, child: defaultBodyWidget);
      }
    } else {
      final Widget body = isScrollable ? Scrollbar(child: SingleChildScrollView(child: defaultBodyWidget)) : defaultBodyWidget;
      if (title == null) return Scaffold(resizeToAvoidBottomPadding: false, appBar: null, body: body);
      if (action == null) return Scaffold(resizeToAvoidBottomPadding: false, appBar: AppBar(title: title), body: body);
      return Scaffold(resizeToAvoidBottomPadding: false, appBar: AppBar(title: title, actions: [action]), body: body);
    }
  }
}

class ATabScaffold extends StatefulWidget {
  final List<Widget> tabTitleList;
  final List<BottomNavigationBarItem> tabItemList;
  final List<Widget> tabBodyList;
  final int initialIndex;
  ATabScaffold({@required this.tabTitleList, @required this.tabItemList, @required this.tabBodyList, this.initialIndex = 0});

  @override
  _ATabScaffoldState createState() => _ATabScaffoldState();
}

class _ATabScaffoldState extends State<ATabScaffold> {
  CupertinoTabController _tabController;
  int _selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    if (_selectedIndex == -1) _selectedIndex = widget.initialIndex;

    if (_tabController == null && Platform.isIOS) {
      _tabController = CupertinoTabController(initialIndex: widget.initialIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    try {
      final List<Widget> tabTitleList = widget.tabTitleList;
      final List<BottomNavigationBarItem> tabItemList = widget.tabItemList;
      final List<Widget> tabBodyList = widget.tabBodyList;

      if (Platform.isIOS) {
        return CupertinoTabScaffold(
          controller: _tabController,
          tabBar: CupertinoTabBar(items: tabItemList),
          tabBuilder: (_, index) => CupertinoTabView(builder: (context) => tabBodyList[index]),
        );
      } else {
        return WillPopScope(
          onWillPop: _onAndroidTabPop,
          child: Scaffold(
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(title: tabTitleList[_selectedIndex]),
            body: tabBodyList.elementAt(_selectedIndex),
            bottomNavigationBar: BottomNavigationBar(
              items: tabItemList,
              onTap: _onAndroidNavBarTapped,
              currentIndex: _selectedIndex,
            ),
          ),
        );
      }
    } catch (error) {
      print(error);
      return SafeArea(child: Center(child: AText("Malformed parameters.")));
    }
  }

  Future<bool> _onAndroidTabPop() async {
    if (_selectedIndex == 0) return true;
    setState(() => _selectedIndex = 0);
    return false;
  }

  void _onAndroidNavBarTapped(int index) {
    setState(() => _selectedIndex = index);
  }
}
