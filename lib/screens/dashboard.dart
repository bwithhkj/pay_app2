import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pay_app/models/User.dart';
import 'package:pay_app/screens/editaccount.dart';
import 'package:pay_app/screens/faqs.dart';
import 'package:pay_app/screens/payment.dart';
import 'package:pay_app/widgets/titleText.dart';

import 'login.dart';

class DashboardScreen extends StatefulWidget {
  User user;

  DashboardScreen(this.user);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: TitleText(
          text: 'PAY IT      ',
          fontSize: 30,
          color: Colors.blue,
        )),
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  const Color(0xFFDDE1EC),
                  const Color(0xFFE0EBEE),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
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
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              TitleText(
                text: ' Welcome Back,',
                fontSize: 36,
                color: Colors.white,
              ),
              SizedBox(
                height: 8,
              ),
              TitleText(
                text: widget.user.name,
                fontSize: 30,
                color: Colors.white,
              ),
              SizedBox(height: 28.0),
              Container(
                height: 60,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  onPressed: () {},
                  padding: EdgeInsets.all(2),
                  color: Colors.white.withOpacity(0.6),
                  child: TitleText(
                    text: '\$ ${widget.user.balance.toString()}',
                    fontSize: 36,
                    color: Colors.white,
                  ),
                ),
                width: MediaQuery.of(context).size.width / 2.2,
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FeatureWidget(' Top Up ', Icons.touch_app, () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (cxt) => PaymentScreen(widget.user)));
                      }),
                      FeatureWidget(
                          'View/Update \n      Details', Icons.account_circle,
                          () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (cxt) =>
                                    EditProfileScreen(widget.user)));
                      }),
                      FeatureWidget('Requests ', Icons.receipt, () {}),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FeatureWidget('FAQs', Icons.remove_from_queue, () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (cxt) => FaqsScreen(widget.user)));
                      }),
                      FeatureWidget(
                          'Delete User', Icons.supervisor_account, () {
                          _deleteAccount();
                          }),
                      FeatureWidget('Delete', Icons.all_out, _logout),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget FeatureWidget(
    String title,
    IconData iconData,
    Function onSelected,
  ) {
    return RaisedButton(
      child: Container(
        margin: EdgeInsets.all(0),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white.withOpacity(0.001),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 1),
              child: Icon(
                iconData,
                color: Colors.amber[600],
                size: MediaQuery.of(context).size.height * 0.08,
              ),
            ),
            TitleText(
              text: title,
              fontSize: MediaQuery.of(context).size.height * 0.02,
              color: Colors.white,
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(12),
      color: Colors.white.withOpacity(0.2),
      onPressed: onSelected,
    );
  }
  _logout() {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text('Logout'),
        content: Padding(
          padding: EdgeInsets.all(12),
          child: Text('Are you sure you want to signout from Pay it ?'),
        ),
        actions: [
          FlatButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().whenComplete(() {
                  widget.user = null;
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (ctx) => LoginScreen()),
                      (route) => false);
                });
              },
              child: Text('Logout')),
          FlatButton(
              onPressed: () => Navigator.pop(context), child: Text('Cancel')),
        ],
      ),
    );
  }
    _deleteAccount() {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text('Delete Account'),
        content: Padding(
          padding: EdgeInsets.all(12),
          child: Text('Are you sure you want to delete your account from Pay it ?'),
        ),
        actions: [
          FlatButton(
              onPressed: () async {
              //  _widget.logi
              FirebaseUser user = await FirebaseAuth.instance.currentUser();

                user.delete().whenComplete(() {
                  widget.user = null;
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (ctx) => LoginScreen()),
                      (route) => false);
                });
              },
              child: Text('Logout')),
          FlatButton(
              onPressed: () => Navigator.pop(context), child: Text('Cancel')),
        ],
      ),
    );
  }
}
