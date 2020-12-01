import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pay_app/helpers/FirestoreHelper.dart';

import 'package:pay_app/models/User.dart';
import 'package:pay_app/widgets/titleText.dart';

import 'dashboard.dart';

class EditProfileScreen extends StatefulWidget {
  User user;

  EditProfileScreen(this.user);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  User user;

  // input fields controller
  TextEditingController _nameController = TextEditingController();
  TextEditingController _locationAddressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    this.user = widget.user;
    _nameController.text = user.name;
    _locationAddressController.text = user.address;
  }

  // App bar
  Widget _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.blue,
        ),
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (cxt) => DashboardScreen(user)));
        },
      ),
      title: TitleText(
        text:'Edit Profile',
        fontSize: 24,
        color: Colors.blue,
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.check,
            color: Colors.blue,
          ),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (cxt) => DashboardScreen(user)));
          },
        ),
      ],
    );
  }

  // Display Picture

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
              _appBar(),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            margin:
                                EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            child: ListTile(
                              dense: true,
                              onTap: _showNameDialog,
                              leading: Icon(Icons.person_outline, color: Colors.white,),
                              title: TitleText(
                                text:'Name',
                              ),
                              subtitle: TitleText(
                                text:user.name,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Divider(color: Colors.white,),
                          Container(
                            margin:
                                EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            child: ListTile(
                              leading: Icon(Icons.alternate_email, color: Colors.white,),
                              title: TitleText(text:'Email'),
                              dense: true,
                              subtitle: TitleText(
                                text:user.email,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Divider(color: Colors.white,),
                          Container(
                            margin:
                                EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            child: ListTile(
                              dense: true,
                              leading: Icon(Icons.phone, color: Colors.white,),
                              onTap: _showPhoneDialog,
                              title: TitleText(text:'Phone'),
                              subtitle: TitleText(text:user.phone,
                              fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                          Divider(color: Colors.white,),
                          Container(
                            margin:
                                EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            child: ListTile(
                              dense: true,
                              onTap: _showAddressDialog,
                              leading: Icon(Icons.location_on, color: Colors.white,),
                              title: TitleText(text:'Address'),
                              subtitle: TitleText(
                                text:user.address,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Divider(color: Colors.white,),
                          Container(
                            margin:
                                EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            child: ListTile(
                              dense: true,
                              onTap: _showSurburbDialog,
                              leading: Icon(Icons.location_on, color: Colors.white,),
                              title: TitleText(text:'Surburb'),
                              subtitle: TitleText(
                                text:user.suburb ?? 'dd',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Divider(color: Colors.white,),
                          // Divider(
                          //     thickness: 4,
                          //     color: Colors.black12.withOpacity(0.1)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _showAddressDialog() {
    TextEditingController c = TextEditingController();
    c.text = user.address;
    var dialog = AlertDialog(
      title: Text('Update your address'),
      content: TextField(
        decoration: new InputDecoration(hintText: "Update Info"),
        controller: c,
      ),
      actions: [
        new FlatButton(
          child: new Text("Close"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        new FlatButton(
          child: new Text("Update"),
          onPressed: () {
            setState(() {
              user.address = c.text;
            });
            FirestoreHelper.updateName(user, () {
              Navigator.pop(context);
            });
          },
        ),
      ],
    );
    showDialog(context: context, child: dialog);
  }

    void _showSurburbDialog() {
    TextEditingController c = TextEditingController();
    c.text = user.suburb;
    var dialog = AlertDialog(
      title: Text('Update your address'),
      content: TextField(
        decoration: new InputDecoration(hintText: "Update Info"),
        controller: c,
      ),
      actions: [
        new FlatButton(
          child: new Text("Close"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        new FlatButton(
          child: new Text("Update"),
          onPressed: () {
            setState(() {
              user.suburb = c.text;
            });
            FirestoreHelper.updateName(user, () {
              Navigator.pop(context);
            });
          },
        ),
      ],
    );
    showDialog(context: context, child: dialog);
  }

  void _showNameDialog() {
    TextEditingController c = TextEditingController();
    c.text = user.name;
    var dialog = AlertDialog(
      title: Text('Update your name'),
      content: TextField(
        decoration: new InputDecoration(hintText: "Update Info"),
        controller: c,
      ),
      actions: [
        new FlatButton(
          child: new Text("Close"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        new FlatButton(
          child: new Text("Update"),
          onPressed: () {
            setState(() {
              user.name = c.text;
            });
            FirestoreHelper.updateName(user, () {
              Navigator.pop(context);
            });
          },
        ),
      ],
    );
    showDialog(context: context, child: dialog);
  }

 void _showPhoneDialog() {
    TextEditingController c = TextEditingController();
    c.text = user.phone;
    var dialog = AlertDialog(
      title: Text('Update your phone number'),
      content: TextField(
        decoration: new InputDecoration(hintText: "Update Info"),
        controller: c,
      ),
      actions: [
        new FlatButton(
          child: new Text("Close"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        new FlatButton(
          child: new Text("Update"),
          onPressed: () {
            setState(() {
              user.phone = c.text;
            });
            FirestoreHelper.updateName(user, () {
              Navigator.pop(context);
            });
          },
        ),
      ],
    );
    showDialog(context: context, child: dialog);
  }

  
}
