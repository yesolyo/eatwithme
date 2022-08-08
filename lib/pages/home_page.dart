
import 'package:firebase_graduation_project/screen/mypage.dart';
import 'package:flutter/material.dart';
import '../screen/time_listview.dart';
import '../screen/total_make_matching.dart';
import '../widget/googlemap_page.dart';
import '../screen/home_screen.dart';

import '../widget/bottom_home.dart';

class HomePages extends StatelessWidget {
  const HomePages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          body: TabBarView(
            children: <Widget>[
              Container(),
              TimeList(),
              TotalMakeMatching(),
            ],
          ),
          bottomNavigationBar: Bottom_home()),
    );
  }
}