import 'dart:io';
import 'dart:ffi';


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'dart:convert';


import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:http/http.dart' as http;


import '../model/input_data.dart';
import '../model/timelistmodel.dart';



class FirstStep extends StatefulWidget {
  final TextEditingController storenameController;

  FirstStep(this.storenameController);

  @override
  State<FirstStep> createState() => _FirstStepState();
}

class _FirstStepState extends State<FirstStep> {
  late List<String> autoCompleteData;
  bool isLoading = false;
  List _items = [];
  Future fetchAutoCompleteData() async {
    setState(() {
      isLoading = true;
    });

    final String stringData =
    await rootBundle.loadString("lib/model/data.json");

    final List<dynamic> json = jsonDecode(stringData);

    final List<String> jsonStringData = json.cast<String>();

    setState(() {
      isLoading = false;
      autoCompleteData = jsonStringData;
    });
  }
  Future readJson() async {
    final String stringData =
    await rootBundle.loadString("lib/model/list_store.json");

    final data = await jsonDecode(stringData);
    setState(() {
      _items = data["item"];
    });
  }



  @override
  void initState() {//set the initial value of text field
    super.initState();
    fetchAutoCompleteData();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    final inputData = Provider.of<InputData>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Autocomplete(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<String>.empty();
            } else {
              return autoCompleteData.where((word) => word
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase()));
            }
          },
          optionsViewBuilder:
              (context, Function(String) onSelected, options) {
            return Material(
              elevation: 4,
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final option = options.elementAt(index);
                  return ListTile(
                    //title: Text(option.toString()),
                    title: SubstringHighlight(
                      text: option.toString(),
                      term: widget.storenameController.text,
                      textStyleHighlight:
                      TextStyle(fontWeight: FontWeight.w700),
                    ),
                    onTap: () {
                      onSelected(option.toString());
                    },
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: options.length,
              ),
            );
          },
          onSelected: (selectedString) {
            print(selectedString);
          },
          fieldViewBuilder: (context, controller, focusNode,
              onEdittingComplete) {
            return TextFormField(
              controller: controller,
              focusNode: focusNode,
              onEditingComplete: onEdittingComplete,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                  BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                  BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                  BorderSide(color: Colors.grey[300]!),
                ),
                hintText: "Search Something",
                prefixIcon: Icon(Icons.search),
              ),
              validator: (val) {
                if (val == null || val.trim().isEmpty){
                  return '식당이름을 입력해주세요';
                }
                return null;
              },
              onSaved: (val){
                inputData.store_name = val!;
              },
            );
          },
        ),
        ListView.builder(itemBuilder: (context,index){
          return Card(
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
          child: Text("식당 추천 리스트"),
          ),
          ]),
          ),
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
          child: Text(_items[index][0]),
          ),
          ]),
          ),
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
          child: Text(_items[index][1]),
          ),
          ]),
          ),
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
          child: Text(_items[index][2]),
          ),
          ]),
          ),
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
          child: Text(_items[index][3]),
          ),
          ]),
          ),
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
          child: Text(_items[index][4]),
          ),
          ]),
          ),
          ],
          ),
          ),
          );

        })
      ],
    );
  }
}
