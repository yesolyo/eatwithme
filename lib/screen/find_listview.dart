
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_graduation_project/model/matching_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/input_data.dart';
import '../model/register_user.dart';
import '../widget/register_listview.dart';
import 'package:http/http.dart' as http;


class FindListView extends StatefulWidget {
  const FindListView({Key? key}) : super(key: key);

  @override
  State<FindListView> createState() => _FindListViewState();
}

class _FindListViewState extends State<FindListView> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('식당별 매칭 목록'),
      ),

      body: StreamBuilder<List<Register>>(
          stream: readRegister(context),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong! ${snapshot.error}');
            } else if (snapshot.hasData) {
              final registers = snapshot.data!;
              return ListView(
                children: registers.map(buildRegister).toList(),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }
      ),
    );
  }

  Widget buildRegister(Register register) =>
      Card(
          elevation: 10,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.article_outlined,
                              color: Colors.grey, size: 16),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(register.title),
                          ),
                        ]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.calendar_today,
                              color: Colors.grey, size: 16),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text("${register.date}"),
                          ),
                        ]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.access_time_outlined,
                              color: Colors.grey, size: 16),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(register.start),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text("~ ${register.end}"),
                          ),
                        ]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.add_location_outlined,
                              color: Colors.grey, size: 16),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(register.storeName),
                          ),
                        ]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.account_circle_sharp,
                              color: Colors.grey, size: 16),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text("${register.min}"),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text("/ ${register.max}",style: TextStyle(
                                fontWeight: FontWeight. bold),),
                          ),
                        ]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child: Text('상세 정보 확인'),
                            style: TextButton.styleFrom(
                              primary: Colors.blueAccent, // Text Color
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('상세정보'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Container(
                                          color: Colors.grey[100],
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10.0,
                                            vertical: 20.0,
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text("제목: ${register.title}"),
                                              Text("세부사항: ${register.detail}"),
                                              Text("식당이름: ${register
                                                  .storeName}"),
                                              Text("날짜: ${register.date}"),
                                              Text("시간: ${register
                                                  .start}~${register.end}"),
                                              Text("신청인원/최대인원: ${register
                                                  .min}/${register.max}"),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blueAccent, // Background color
                                onPrimary: Colors
                                    .white, // Text Color (Foreground color)
                              ),
                              onPressed: () {
                                if (register.min != register.max) {
                                  showDialog(
                                    context: context,
                                    barrierDismissible:
                                    false, // 다이얼로그 이외의 바탕 눌러도 안꺼지도록 설정
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('확인창'),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            //List Body를 기준으로 Text 설정
                                            children: <Widget>[
                                              Text('신청하시겠습니까?'),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            child: Text('확인'),
                                            onPressed: () {
                                              final inputData = Provider.of<
                                                  InputData>(context,
                                                listen: false,);
                                              final matching = Matching(
                                                max: register.max,
                                                date: register.date,
                                                detail: register.detail,
                                                end: register.end,
                                                start: register.start,
                                                storeName: register.storeName,
                                                title: register.title,
                                                register_id: register.id,
                                                user_id: inputData
                                                    .googleAccount!.email,
                                              );
                                              createMatching(matching);
                                              //min을 +1하는 부분
                                              final sfDocRef = FirebaseFirestore
                                                  .instance.collection(
                                                  "register").doc(register.id);
                                              FirebaseFirestore.instance
                                                  .runTransaction((
                                                  transaction) {
                                                return transaction.get(sfDocRef)
                                                    .then((sfDoc) {
                                                  final newPopulation = sfDoc
                                                      .get("min") + 1;
                                                  transaction.update(sfDocRef,
                                                      {"min": newPopulation});
                                                  return newPopulation;
                                                });
                                              }).then(
                                                    (newPopulation) => print(
                                                    "Population increased to $newPopulation"),
                                                onError: (e) =>
                                                    print(
                                                        "Error updating document $e"),
                                              );

                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: Text('취소'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );}
                                else {
                                  showDialog(
                                    context: context,
                                    barrierDismissible:
                                    false, // 다이얼로그 이외의 바탕 눌러도 안꺼지도록 설정
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('확인창'),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            //List Body를 기준으로 Text 설정
                                            children: <Widget>[
                                              Text('마감하였습니다.'),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            child: Text('확인'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              child: Text("신청")),

                        ]),

                  ),

                ]),
          ));

  Stream<List<Register>> readRegister(BuildContext context)async *{
    final inputData = Provider.of<InputData>(context,
      listen: false,);
    yield* FirebaseFirestore.instance
        .collection('register')
        .where('storeName', isEqualTo: inputData.store_name)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => Register.fromJson(doc.data())).toList());
  }


  Future createMatching(Matching matching) async {
    final docRegister = FirebaseFirestore.instance.collection('matching').doc();
    matching.id = docRegister.id;

    final json = matching.toJson();
    await docRegister.set(json);
  }
}