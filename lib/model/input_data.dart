import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class InputData with ChangeNotifier {
  //매칭등록 provider
  String store_name = '';
  String promise_date = '';
  int minpers = 1;
  int maxpers = 2;
  String starttime = '';
  String endtime = '';
  String title = '';
  String detail = '';

  var _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleAccount;

  login() async{
    this.googleAccount = await _googleSignIn.signIn();
    notifyListeners();
  }
  logOut() async{
    this.googleAccount = await _googleSignIn.signOut();
    notifyListeners();
  }
}