import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../model/input_data.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loginUI(),
    );
  }
  loginUI(){
    return Consumer<InputData>(
        builder: (context,model, child){
          if(model.googleAccount != null && model.googleAccount!.email.contains('@sookmyung.ac.kr') != false){
            return Center(child: loggedInUI(model),);
          } else if(model.googleAccount != null && model.googleAccount!.email.contains('@sookmyung.ac.kr') != true){
            return Center(child: logInfailUI(model),);
          }
          else {
            return loginControls(context);
          }
        },
    );
  }

  loggedInUI(InputData model) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Text("Succeed",
            style: GoogleFonts.pacifico(
              fontWeight: FontWeight.bold,
              fontSize: 40,
              color: Color(0xff0D47A1),
            )),
        Text(model.googleAccount!.displayName ?? '',
          style: TextStyle(
              color: Color(0xff0D47A1)
          ),),
        Text(model.googleAccount!.email,
          style: TextStyle(
              color: Color(0xff0D47A1)
          ),),
          OutlinedButton.icon(
            style: TextButton.styleFrom(
              primary: Color(0xff0D47A1),
            ),
            icon: Icon(Icons.ads_click),
            label: Text("Start"),
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePages()));
            },),
          OutlinedButton.icon(
            style: TextButton.styleFrom(
              primary: Color(0xff0D47A1),
            ),
            icon: Icon(Icons.logout),
            label: Text("Logout"),
            onPressed: (){
              Provider.of<InputData>(context, listen: false).logOut();
            },),
        ],
    );
  }

  logInfailUI(InputData model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Fail",
            style: GoogleFonts.pacifico(
              fontWeight: FontWeight.bold,
              fontSize: 40,
              color: Colors.red,
            )),
        Text(model.googleAccount!.displayName ?? '',
          style: TextStyle(
              color: Colors.redAccent
          ),),
        Text(model.googleAccount!.email,
          style: TextStyle(
              color: Colors.redAccent
          ),),
        Text('*학교 계정(sookmyung.ac.kr)으로 가입해야합니다.',
          style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold
        ),),

        OutlinedButton.icon(
          style: TextButton.styleFrom(
            primary: Colors.red,
          ),
          icon: Icon(Icons.app_registration),
          label: Text("Register"),
          onPressed: (){
            Provider.of<InputData>(context, listen: false).logOut();
          },),
      ],
    );
  }

  loginControls(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
        Container(
        height: 650,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(0xff0D47A1),
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                color: Colors.black,
                offset: Offset(1, 5))
          ],
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(80),
              bottomRight: Radius.circular(20)),
        ),
    child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
    children: [
    SizedBox(
    height: 200,
    ),
    Text("Login",
    style: GoogleFonts.pacifico(
    fontWeight: FontWeight.bold,
    fontSize: 50,
    color: Colors.white,
    )),
    SizedBox(
    height: 40,
    ),

    ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.black,
              minimumSize: Size(double.infinity,50),
            ),
            icon: FaIcon(FontAwesomeIcons.google,color: Colors.red),
            label: Text('Sign up with Google'),
            onPressed: (){
              final provider =
              Provider.of<InputData>(context, listen: false).login();
            },
          ),
        ],
      ),
    ),
      ),
    ],
      ),
    );
  }

}

