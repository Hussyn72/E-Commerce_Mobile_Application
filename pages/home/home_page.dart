
import 'package:JF_InfoTech/pages/auth/sign_in_page.dart';
import 'package:JF_InfoTech/pages/auth/sign_up_page.dart';
import 'package:JF_InfoTech/pages/home/main_item_page.dart';
import 'package:JF_InfoTech/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../account/account_page.dart';
import '../cart/cart_history_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late PersistentTabController _controller;


  List pages = [
    const MainItemPage(),
    Container(child: const Center(child: Text("Next Page"),),),
    Container(child: const Center(child: const Text("Next next Page"),),),
    Container(child: const Center(child: const Text("Next next next Page"),),),
  ];

  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      MainItemPage(),
      Container(),
      CartHistory(),
      AccountPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary:  Colors.amberAccent,
        //CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.archivebox_fill),
        title: ("Archive"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: Colors.amberAccent,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.cart_fill),
        title: ("Cart"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: Colors.amberAccent,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person_alt),
        title: ("Me"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: Colors.amberAccent,
      ),
    ];
  }



 /*   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.amberAccent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        currentIndex:_selectedIndex,
        onTap: onTapNav,
        items:
        [
           BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined,),
             label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive,),
            label: "History",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined,),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,),
            label: "Account",
          ),

        ],
      ),
    );
  }
}*/
//created by self bottom navigationbar



@override
Widget build(BuildContext context) {
  return PersistentTabView(
    context,
    controller: _controller,
    screens: _buildScreens(),
    items: _navBarsItems(),
    confineInSafeArea: true,
    backgroundColor: Colors.white, // Default is Colors.white.
    handleAndroidBackButtonPress: true, // Default is true.
    resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
    stateManagement: true, // Default is true.
    hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
    decoration: NavBarDecoration(
      borderRadius: BorderRadius.circular(10.0),
      colorBehindNavBar: Colors.white,
    ),
    popAllScreensOnTapOfSelectedTab: true,
    popActionScreens: PopActionScreensType.all,
    itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
      duration: Duration(milliseconds: 200),
      curve: Curves.ease,
    ),
    screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
      animateTabTransition: true,
      curve: Curves.ease,
      duration: Duration(milliseconds: 200),
    ),
    navBarStyle: NavBarStyle.style6, // Choose the nav bar style with this property.
  );
}

}