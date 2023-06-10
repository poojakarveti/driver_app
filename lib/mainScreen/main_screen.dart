import 'dart:collection';

import 'package:driver_app/tab_Pages/earn_tabs.dart';
import 'package:driver_app/tab_Pages/home_tab.dart';
import 'package:driver_app/tab_Pages/profile_tab.dart';
import 'package:driver_app/tab_Pages/ratings-tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  int selectedIndex = 0;

  onItemClicked(int index) {
    setState(() {
      selectedIndex = index;
      tabController!.index = selectedIndex;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: tabController,
          children: const [
            HomeTabPage(),
            EarningsTabsPage(),
            ProfileTabPage(),
            RatingsTabPage(),
          ]),
          bottomNavigationBar: BottomNavigationBar(items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home,color: Colors.grey,),label: 'Home'),
           BottomNavigationBarItem(icon: Icon(Icons.credit_card,color: Colors.grey,),label: 'Earnings'),
            BottomNavigationBarItem(icon: Icon(Icons.star,color: Colors.grey,),label: 'Ratings'),
            BottomNavigationBarItem(icon: Icon(Icons.person,color: Colors.grey,),label:'Account' ),
          ],
          unselectedItemColor: Colors.white54,
          selectedItemColor:Colors.white ,
          backgroundColor:Colors.black ,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(fontSize: 14),
          showUnselectedLabels: true,
          currentIndex: selectedIndex,
          onTap: onItemClicked,
          ),
          
    );
  }
}

