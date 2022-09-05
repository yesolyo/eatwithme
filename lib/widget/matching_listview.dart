
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_graduation_project/screen/rec_register_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../model/input_data.dart';
import '../model/matching_model.dart';
import '../model/register_user.dart';


class MatchingListview extends StatefulWidget {
  const MatchingListview({Key? key}) : super(key: key);

  @override
  State<MatchingListview> createState() => _MatchingListviewState();
}

class _MatchingListviewState extends State<MatchingListview> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      body: StreamBuilder<List<Matching>>(
          stream: readMatching(context),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong! ${snapshot.error}');
            } else if (snapshot.hasData) {
              final matchings = snapshot.data!;
              return ListView(
                children: matchings.map(buildMatching).toList(),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }
      ),
    );
  }

  Widget buildMatching(Matching matching) =>
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
                            child: Text(matching.title),
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
                            child: Text("${matching.date}"),
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
                            child: Text(matching.start),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text("~ ${matching.end}"),
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
                            child: Text(matching.storeName),
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
                            child: Text(" ${matching.max}"),
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
                                              Text("제목: ${matching.title}"),
                                              Text("세부사항: ${matching.detail}"),
                                              Text("식당이름: ${matching
                                                  .storeName}"),
                                              Text("날짜: ${matching.date}"),
                                              Text("시간: ${matching
                                                  .start}~${matching.end}"),
                                              Text("최대인원:${matching.max}"),
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
                                            Text('취소하시겠습니까?'),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          child: Text('확인'),
                                          onPressed: () {
                                            final sfDocRef = FirebaseFirestore
                                                .instance.collection(
                                                "register").doc(matching.register_id);
                                            FirebaseFirestore.instance
                                                .runTransaction((
                                                transaction) {
                                              return transaction.get(sfDocRef)
                                                  .then((sfDoc) {
                                                final newPopulation = sfDoc
                                                    .get("min") - 1;
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
                                            final docuser=FirebaseFirestore.instance
                                                .collection('matching')
                                                .doc(matching.id);

                                            docuser.delete();
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
                                );
                              },
                              child: Text("취소")),

                        ]),

                  ),

                ]),
          ));

  Stream<List<Matching>> readMatching(BuildContext context)async *{
    final inputData = Provider.of<InputData>(context,
      listen: false,);
    yield* FirebaseFirestore.instance
        .collection('matching')
        .where("user_id", isEqualTo: inputData.googleAccount!.email)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => Matching.fromJson(doc.data())).toList());
  }


}