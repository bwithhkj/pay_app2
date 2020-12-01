import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pay_app/authenticators/AccountLinking.dart';
import 'package:pay_app/authenticators/EmailPassAuthentication.dart';
import 'package:pay_app/helpers/FirestoreHelper.dart';
import 'package:pay_app/models/User.dart';
import 'package:pay_app/widgets/titleText.dart';

import 'dashboard.dart';

class SignupScreen extends StatefulWidget {
  User signedInUser;
  SignupScreen({this.signedInUser});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // form key
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // User Model
  User _registeringUser;

  // scaffold key
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // datetime => age controller
  TextEditingController _nameFieldController;
  TextEditingController _emailFieldController;
  TextEditingController _passwordFieldController;
  TextEditingController _phoneFieldController, _pinFieldController, _addressFieldController, _suburbFieldController;


  // phone number field focus node
  FocusNode phoneFieldFocusNode = FocusNode();
  String prefixCode = '+64';

  bool isBusy = false;

  bool passVisible = true;

  @override
  void initState() {
    super.initState();
    _registeringUser =
        widget.signedInUser != null ? widget.signedInUser : User.empty();

    _nameFieldController = TextEditingController();
    _emailFieldController = TextEditingController();
    _passwordFieldController = TextEditingController();
    _phoneFieldController = TextEditingController();

    _pinFieldController = TextEditingController();
    _addressFieldController = TextEditingController();
    _suburbFieldController = TextEditingController();



    if (widget.signedInUser != null) {
      if (_registeringUser.provider == 'Phone') {
        _phoneFieldController.text = _registeringUser.phone;
        prefixCode = '';
      } else {
        _emailFieldController.text = _registeringUser.email;
        phoneFieldFocusNode.addListener(() {
          setState(() {
            if (phoneFieldFocusNode.hasFocus) {
              prefixCode = '+64';
            } else {
              if (_phoneFieldController.text.length == 0) {
                prefixCode = '';
              }
            }
          });
        });
      }
    } else {
      _registeringUser.provider = 'Email/Pass';
    }
  }

  @override
  void dispose() {
    phoneFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: Form(
        child: SingleChildScrollView(
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
              TitleText(
                  text: 'PAY IT',
                  fontSize: 40,
                ),
            SizedBox(
              height: 10,
            ),
                Image.network(
                  'https://cdn.pixabay.com/photo/2016/03/31/21/41/cash-1296584_1280.png',
                  width: 140,
                ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height / 14,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    controller: _nameFieldController,
                    onChanged: (String value) {
                      setState(() {
                        _registeringUser.name = value;
                      });
                    },
                    validator: validatorNameField,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.black38),
                      hintText: 'Your Name',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      icon: Icon(
                        Icons.person_outline,
                        color: Colors.black87,
                      ),
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    autofocus: false,
                    controller: _emailFieldController,
                    validator: validatorEmailField,
                    onChanged: (String value) {
                      _registeringUser.email = value;
                    },
                    readOnly: (_registeringUser.provider == 'Email/Google' ||
                        _registeringUser.provider == 'Email/Facebook'),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.black38),
                      hintText: 'Email Address',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      icon: Icon(
                        Icons.alternate_email,
                        color: Colors.black87,
                      ),
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    validator: validatorPasswordField,
                    keyboardType: TextInputType.visiblePassword,
                    autofocus: false,
                    controller: _passwordFieldController,
                    onChanged: (String value) {
                      setState(() {
                        _registeringUser.password = value;
                      });
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.black38),
                      hintText: 'Password',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      icon: Icon(
                        Icons.lock_outline,
                        color: Colors.black87,
                      ),
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    controller: _addressFieldController,
                    onChanged: (String value) {
                      _registeringUser.address = value;
                    },
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.black38),
                      hintText: 'Address',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      icon: Icon(
                        Icons.home,
                        color: Colors.black87,
                      ),
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Flexible(
                                          child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          autofocus: false,
                          controller: _suburbFieldController,
                          onChanged: (String value) {
                            _registeringUser.suburb = value;
                          },
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.black38),
                            hintText: 'Suburb',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            icon: Icon(
                              Icons.local_convenience_store,
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
                      SizedBox(width: 10,),
                      Flexible(
                          child: TextFormField(
                          keyboardType: TextInputType.number,
                          autofocus: false,
                          controller: _pinFieldController,
                          onChanged: (String value) {
                            _registeringUser.pinCode = value;
                          },
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.black38),
                            hintText: 'Zip/pin',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            icon: Icon(
                              Icons.pin_drop,
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
                    ],
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    validator: validatorPhoneField,
                    controller: _phoneFieldController,
                    keyboardType: TextInputType.phone,
                    autofocus: false,
                    readOnly: _registeringUser.provider == 'Phone',
                    focusNode: phoneFieldFocusNode,
                    onChanged: (String value) {
                      _registeringUser.phone = value;
                    },
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.black38),
                      hintText: 'Phone',
                      // InputDecoration(hintText: '1234567890', prefix: Text(prefix)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      prefix: Text(prefixCode),
                      icon: Icon(Icons.local_phone, color: Colors.black87),
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
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
                      onPressed: isBusy ? null : handleRegistration,
                      padding: EdgeInsets.all(12),
                      color: Colors.lightBlueAccent,
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  isBusy ? CircularProgressIndicator() : SizedBox(),
                ],
              ),
            ),
          ),
        ),
        key: formKey,
      ),
    );
  }

  String validatorNameField(String value) {
    if (value != null && value.length > 0) {
      if (value.length >= 3) {
        if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)) {
          return 'Not a valid name';
        } else {
          return null;
        }
      } else {
        return 'Not a valid name';
      }
    } else {
      return 'Name couldn\'t be empty';
    }
  }

  String validatorEmailField(String value) {
    if (value != null && value.length > 0) {
      if (value.contains('@')) {
        return null;
      } else {
        return 'Not a valid email address';
      }
    } else {
      return 'Please enter your email address';
    }
  }

  String validatorPasswordField(String value) {
    if (value != null && value.length > 0) {
      if (value.length < 6) {
        return 'Password should be minimum of six characters';
      } else {
        return null;
      }
    } else {
      return 'Password couldn\'t be empty';
    }
  }

  String validatorPhoneField(String value) {
    if (_registeringUser.provider == 'Phone') {
      return null;
    } else {
      if (value != null && value.length > 0) {
        if (value.length != 10) {
          return 'Enter 10 digits phone number';
        } else {
          return null;
        }
      } else {
        return 'Phone number couldn\'t be empty';
      }
    }
  }

  // validate the fields
  bool validate() {
    bool a = true;
    if (_nameFieldController.text.length < 3) {
      a = false;
    }

    if (!_emailFieldController.text.contains("@") ||
        !_emailFieldController.text.contains(".com")) {
      a = false;
    }

  if(_pinFieldController.text == null) {
    a =false;
  }
  if(_addressFieldController.text == null) {
    a =false;
  }
  if(_suburbFieldController.text == null) {
    a =false;
  }

    if (_passwordFieldController.text.length < 6) {
      a = false;
    }

    if (_registeringUser.provider != 'Phone') {
      if (_registeringUser.phone.length != 10) {
        a = false;
      }
    }

    return a;
  }

  void handleRegistration() async {
    if (formKey.currentState.validate()) {
      if (validate()) {
        setBusy(true);

        _registeringUser.provider = 'Email';

        _registeringUser.balance = 0;
        _registeringUser.phone = prefixCode + _phoneFieldController.text;
              AuthResult result =
              await EmailPassAuthentication.signUpWithEmail(
                  user: _registeringUser);
              if (result != null && result.user != null) {
                FirestoreHelper.createUserInDatabase(
                    _registeringUser, onCompleteCallbacks,
                    merge: false);
              }
              setBusy(false);
      }
    }
  }

  void setBusy(bool busy) {
    setState(() {
      isBusy = busy;
    });
  }

  void showSnackBar(String message, bool success) {
    var errorSnackbar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: success ? Colors.green : Colors.red,
    );
    _scaffoldKey.currentState.showSnackBar(errorSnackbar);
  }

  void onCompleteCallbacks() {
    continueRegistration();
  }

  void continueRegistration() {
    Navigator.push(context,
        MaterialPageRoute(builder: (ctx) => DashboardScreen(_registeringUser)));
  }
}
