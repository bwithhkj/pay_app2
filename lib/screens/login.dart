import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pay_app/authenticators/EmailPassAuthentication.dart';
import 'package:pay_app/helpers/FirestoreHelper.dart';
import 'package:pay_app/models/User.dart';
import 'package:pay_app/screens/signup.dart';
import 'package:pay_app/widgets/titleText.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'dashboard.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  User user = User.empty();
  ProgressDialog pr;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
     // backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
         decoration: BoxDecoration(
          gradient: new LinearGradient(
              colors: [
                const Color(0xFF5681DF),
                const Color(0xFFDFCFFF),
              ],
              begin: const FractionalOffset(0.6, 0.0),
              end: const FractionalOffset(1.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 50),
          margin: EdgeInsets.all(0.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height:10),
                TitleText(
                  text: 'PAY IT',
                  fontSize: 40,
                ),
            SizedBox(
              height: 20,
            ),
                Image.network(
                  'https://cdn.pixabay.com/photo/2016/03/31/21/41/cash-1296584_1280.png',
                  width: 140,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                ),
                Container(
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    autofocus: false,
                    onChanged: (String value) {
                      this.user.email = value;
                    },
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.black87),
                      hintText: 'Email',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                        borderSide: BorderSide(color: Colors.black87),
                      ),
                      icon: Icon(
                        Icons.account_circle,
                        color: Colors.black87,
                      ),
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  autofocus: false,
                  obscureText: _obscureText,
                  onChanged: (String value) {
                    this.user.password = value;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide: BorderSide(color: Colors.black87),
                    ),
                    icon: Icon(
                      Icons.lock,
                      color: Colors.black87,
                    ),
                    hintStyle: TextStyle(color: Colors.black87),
                    contentPadding:
                        EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(
                        _obscureText
                            ? Icons.visibility
                            : Icons.visibility_off,
                        semanticLabel:
                            _obscureText ? 'show password' : 'hide password',
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  height: 50,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    onPressed: () {
                      // handle signin
                      //pr.show();
                      handleSignIn();

                    },
                    padding: EdgeInsets.all(12),
                    color: Colors.lightBlueAccent,
                    child: Text(
                      'Log In',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                ),
                SizedBox(height: 20.0),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          height: 1,
                          color: Colors.black38,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text('OR'),
                      ),
                      Expanded(
                        child: Divider(
                          height: 1,
                          color: Colors.black38,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /*Text(
                          'don\'t have an account ?',
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),*/
                      TitleText(
                          text: 'don\'t have an account ?',
                          fontSize:
                              MediaQuery.of(context).size.height * 0.0145, color: Colors.black,),
                      FlatButton(
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => SignupScreen()));
                        },
                        child: TitleText(
                            text: 'Create One',
                            fontSize: MediaQuery.of(context).size.height *
                                0.0145, color: Colors.black,), //Text('Create One'),
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


void _navigate() async {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (ctx) => DashboardScreen(user),
      ),
      (route) => false);
}

void handleSignIn() async {
  if (user.email == null || !user.email.contains("@")) {

    return;
  }
  if (user.password == null || user.password.length < 6) {
    return;
  }
  
  AuthResult authResult = await EmailPassAuthentication.loginWithEmail(
    // invoked on error
    () {

      showSnackBar('Incorrect email or password !', false);
    },
    email: user.email,
    password: user.password,
  );
  //if(pr.isShowing()){pr.hide();}
  if (authResult != null && authResult.user != null) {
    // user logged in success.
    user = await FirestoreHelper.getUserFromData(authResult.user);
//      showSnackBar('Successfuly Logged in', true);
    //if(pr.isShowing()){pr.hide();}

    _navigate();
  }

}

void showSnackBar(String message, bool success) {

    var errorSnackbar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: success ? Colors.green : Colors.redAccent,
    );
    _scaffoldKey.currentState.showSnackBar(errorSnackbar);
}
}
