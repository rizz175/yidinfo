import 'package:flutter/material.dart';


import '../Screens/Homescreen.dart';
import '../Screens/latestmusic.dart';
import '../Screens/latestnews.dart';
import '../Screens/setting.dart';


class menubar extends StatefulWidget {
  @override
  _menubarState createState() => _menubarState();
}

class _menubarState extends State<menubar> {
  int _pageIndex = 0;
  PageController _pageController = PageController(initialPage:0);

  final List<Widget> _screens =
  [
    homescreen(),latestnews(),latestmusic(),setting()
  ];
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();





  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (_pageIndex != 0) {
            _setPage(0);
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          key: _scaffoldKey,
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor:Colors.orange,

            showUnselectedLabels: true,
            currentIndex: _pageIndex,
            type: BottomNavigationBarType.fixed,
            items: [
              _barItem(Icons.home,"Home", 0),
              _barItem(Icons.assignment_outlined,"News By Filter", 1),
              _barItem(Icons.music_note_sharp,"Latest Music", 2),
              _barItem(Icons.settings,"Settings", 3),

            ],
            onTap: (int index) {
              _setPage(index);
            },
          ),

          body: PageView.builder(
            controller: _pageController,
            itemCount: _screens.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return _screens[index];
            },
          ),

        ));
  }
  BottomNavigationBarItem _barItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Stack(
        clipBehavior: Clip.none, children: [
        Icon(icon),
      ],
      ),
      label: label,
    );
  }
  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }
}
