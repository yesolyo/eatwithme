import 'package:firebase_graduation_project/screen/recommend_register.dart';
import 'package:firebase_graduation_project/widget/register_listview.dart';
import 'package:flutter/material.dart';

import '../widget/matching_listview.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text('마이페이지'),
      ),
      body: Column(
        children: [
          Text("매칭 등록", textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,
            fontSize: 20,color: Colors.black45)),
          Expanded(child: ApplicationListview()),
          Text("매칭 신청",textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold,
            fontSize: 20,color: Colors.black45)),
          Expanded(child: MatchingListview()),
        ],
      ),
        floatingActionButton :
        FloatingActionButton.extended(
        onPressed: (){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RecommendRegister()),);
    },
    label: Text('취향 분석 등록'),
    icon: Icon(Icons.add_task),
    backgroundColor: Colors.blue[900],
    elevation: 0,
    ),
    );
  }
}
