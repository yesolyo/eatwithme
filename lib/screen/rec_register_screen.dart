import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../model/input_data.dart';
import '../model/recommend_model.dart';
import '../widget/register_listview.dart';


/// This is the stateful widget that the main application instantiates.
class RecommendRegister extends StatefulWidget {
  const RecommendRegister({Key? key}) : super(key: key);

  @override
  State<RecommendRegister> createState() => _RecommendRegisterState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _RecommendRegisterState extends State<RecommendRegister> {
  int randomNumber1 = 0;
  String randomStore1 = '식당을 클릭하세요';
  late List<String> autoCompleteData;
  bool isLoading = false;
  Future fetchAutoCompleteData() async {
    setState(() {
      isLoading = true;
    });
    final String stringData =
    await rootBundle.loadString("lib/json/store_id_name.json");
    final List<dynamic> json = jsonDecode(stringData);
    final List<String> jsonStringData = json.cast<String>();

    setState(() {
      isLoading = false;
      autoCompleteData = jsonStringData;
    });
  }

  @override
  void initState() {//set the initial value of text field
    super.initState();
    fetchAutoCompleteData();
  }



//처음에는 사과가 선택되어 있도록 Apple로 초기화 -> groupValue에 들어갈 값!
  String radioButtonItem1 = '1';
  // Group Value for Radio Button.
  int id1 = 1;
  var random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('취향 분석 등록'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(14.0),
              child: Text('1. $randomStore1',
                  style: TextStyle(fontSize: 21)),

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Radio(
                value: 1,
                groupValue: id1,
                onChanged: (val) {
                  setState(() {
                    radioButtonItem1 = '1';
                    id1 = 1;
                  });
                },
              ),
              Text(
                '1',
                style: new TextStyle(fontSize: 17.0),
              ),

              Radio(
                value: 2,
                groupValue: id1,
                onChanged: (val) {
                  setState(() {
                    radioButtonItem1 = '2';
                    id1 = 2;
                  });
                },
              ),
              Text(
                '2',
                style: new TextStyle(
                  fontSize: 17.0,
                ),
              ),
              Radio(
                value: 3,
                groupValue: id1,
                onChanged: (val) {
                  setState(() {
                    radioButtonItem1 = '3';
                    id1 = 3;
                  });
                },
              ),
              Text(
                '3',
                style: new TextStyle(
                  fontSize: 17.0,
                ),
              ),
              Radio(
                value: 4,
                groupValue: id1,
                onChanged: (val) {
                  setState(() {
                    radioButtonItem1 = '4';
                    id1 = 4;
                  });
                },
              ),
              Text(
                '4',
                style: new TextStyle(
                  fontSize: 17.0,
                ),
              ),

              Radio(
                value: 5,
                groupValue: id1,
                onChanged: (val) {
                  setState(() {
                    radioButtonItem1 = '5';
                    id1 = 5;
                  });
                },
              ),
              Text(
                '5',
                style: new TextStyle(fontSize: 17.0),
              ),

            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(onPressed: (){setState(() {
                  randomNumber1 = random.nextInt(233);
                  randomStore1 = autoCompleteData[randomNumber1];
                });
                }, child: Text('식당 검색')),
                Padding(
                  padding: EdgeInsets.all(14.0),
                ),
                ElevatedButton(onPressed: (){
                  final inputData = Provider.of<InputData>(context,
                    listen: false,);
                  final recommend = Rec(
                    rating:id1,
                    store_id:randomNumber1,
                    user_id:inputData.googleAccount!.email,
                  );

                  createRec(recommend);
                }, child: Text('확인')
                ),
              ]

          )

        ],

      ),
    );
  }
  Future createRec(Rec rec) async {
    final docRegister = FirebaseFirestore.instance.collection('recommendregister').doc();
    rec.id = docRegister.id;
    final json = rec.toJson();
    await docRegister.set(json);

  }
}