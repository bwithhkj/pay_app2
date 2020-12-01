import 'package:flutter/material.dart';
import 'package:pay_app/helpers/FirestoreHelper.dart';
import 'package:pay_app/models/User.dart';
import 'package:pay_app/screens/dashboard.dart';
import 'package:pay_app/widgets/titleText.dart';

class PaymentScreen extends StatefulWidget {
  User user;

  PaymentScreen(this.user);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  User _registeringUser;
  Card card = Card();

 String tempValue = '0';

  @override
  void initState() {
    super.initState();
    _registeringUser = widget.user;
  }

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // datetime => age controller
  TextEditingController _cardNumberFieldController;
  TextEditingController _cardMoneyFieldController;

  TextEditingController _cardCVVFieldController;

  // phone number field focus node

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleText(
          text: 'Pay with card',
          fontSize: 20,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  const Color(0xFF7699E6),
                  const Color(0xFFDFCFFF),
                ],
                begin: const FractionalOffset(0.6, 0.0),
                end: const FractionalOffset(1.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Column(
            children: [
              SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TitleText(
                    text: 'ENTER YOUR PAYMENT DETAILS',
                    fontSize: 22,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.network(
                  'https://cdn.pixabay.com/photo/2016/05/03/12/19/credit-card-1369111_1280.png',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        controller: _cardNumberFieldController,
                        keyboardType: TextInputType.phone,
                        autofocus: false,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.black38),
                          hintText: 'Card Number',
                          icon:
                              Icon(Icons.card_giftcard, color: Colors.black87),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: TextFormField(
                              controller: _cardNumberFieldController,
                              keyboardType: TextInputType.phone,
                              autofocus: false,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.black38),
                                hintText: 'MM',
                                icon: Icon(Icons.calendar_today,
                                    color: Colors.black87),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: TextFormField(
                              controller: _cardNumberFieldController,
                              keyboardType: TextInputType.phone,
                              autofocus: false,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.black38),
                                hintText: 'YY',
                                icon: Icon(Icons.calendar_view_day,
                                    color: Colors.black87),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: TextFormField(
                              controller: _cardNumberFieldController,
                              keyboardType: TextInputType.phone,
                              autofocus: false,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.black38),
                                hintText: 'CVV',
                                icon: Icon(Icons.perm_data_setting,
                                    color: Colors.black87),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: TextFormField(
                              controller: _cardNumberFieldController,
                              keyboardType: TextInputType.phone,
                              autofocus: false,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.black38),
                                hintText: 'ZIP CODE',
                                icon:
                                    Icon(Icons.pin_drop, color: Colors.black87),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        controller: _cardNumberFieldController,
                        keyboardType: TextInputType.phone,
                        autofocus: false,
                        onChanged: (String value) {
                          tempValue = value;
                        },
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.black38),
                          hintText: 'Amount',
                          icon: Icon(Icons.attach_money, color: Colors.black87),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18.0),
              Container(
                height: 60,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  onPressed: () {
                    setState(() {
                      _registeringUser.balance = _registeringUser.balance +
                          int.parse(tempValue);
                    });
                    FirestoreHelper.updateName(_registeringUser, () {
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => DashboardScreen(_registeringUser)));
                    });
                  },
                  padding: EdgeInsets.all(2),
                  color: Colors.blue.withOpacity(0.6),
                  child: TitleText(
                    text: 'PAY NOW',
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                width: MediaQuery.of(context).size.width,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String validatorPhoneField(String value) {
    if (value != null && value.length > 0) {
      if (value.length != 16) {
        return 'Enter 16 digits number';
      } else {
        return null;
      }
    } else {
      return 'CreditCard number couldn\'t be empty';
    }
  }

  // validate the fields
  bool validate() {
    bool a = true;
    if (_cardNumberFieldController.text.length < 16) {
      a = false;
    }

    if (_cardCVVFieldController.text.length < 4) {
      a = false;
    }

    return a;
  }
}
