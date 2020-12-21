import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp1/feed.dart';
import 'package:myapp1/location.dart';
import 'package:myapp1/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:myapp1/services/database_users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp1/userdata.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _authService = AuthService();

  //text field state
  String email = '';
  String password = '';
  String name = '';
  String profession = '';
  String location = '';
  String phoneNumber = '';
  String error = '';
  var choicesNow = new List();

  Widget _buildName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(10.0),
          ),
          height: 50.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Roboto',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(15.0),
              hintText: 'Enter your Name',
              hintStyle: TextStyle(
                color: Colors.black26,
                fontFamily: 'Roboto',
              ),
            ),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(10.0),
          ),
          height: 50.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Roboto',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(15.0),
              hintText: 'Enter your Email',
              hintStyle: TextStyle(
                color: Colors.black26,
                fontFamily: 'Roboto',
              ),
            ),
            onChanged: (val) {
              setState(() {
                email = val;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildJob() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(10.0),
          ),
          height: 50.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Roboto',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(15.0),
              hintText: 'Enter your Job Title',
              hintStyle: TextStyle(
                color: Colors.black26,
                fontFamily: 'Roboto',
              ),
            ),
            onChanged: (val) {
              setState(() {
                profession = val;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(10.0),
          ),
          height: 50.0,
          child: TextField(
            obscureText: true,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Roboto',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(15.0),
              hintText: 'Enter your Password',
              hintStyle: TextStyle(
                color: Colors.black26,
                fontFamily: 'Roboto',
              ),
            ),
            onChanged: (val) {
              setState(() {
                password = val;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _locationBtn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(10.0),
          ),
          height: 50.0,
          child: TextField(
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Roboto',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(15.0),
              hintText: 'Enter Location - (city,state)',
              hintStyle: TextStyle(
                color: Colors.black26,
                fontFamily: 'Roboto',
              ),
            ),
            onChanged: (val) {
              setState(() {
                location = val;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _phoneTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(10.0),
          ),
          height: 50.0,
          child: TextField(
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Roboto',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(15.0),
              hintText: 'Enter Phone Number',
              hintStyle: TextStyle(
                color: Colors.black26,
                fontFamily: 'Roboto',
              ),
            ),
            onChanged: (val) {
              setState(() {
                phoneNumber = val;
              });
            },
          ),
        ),
      ],
    );
  }
  /*
   Widget _locationBtn() {
    return Container(
      padding: EdgeInsets.only(top: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Location()),
          );
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Color(0xFF01579B),
        child: Text(
          'PICK YOUR LOCATION',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontFamily: 'Roboto',
          ),
        ),
      ),
    );
  }*/

  Widget _createAccountBtn() {
    return Container(
      padding: EdgeInsets.only(top: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          dynamic result = await _authService.register(email, password);
          if (result == null) {
            setState(() {
              error = 'please provide a valid email and password';
            });
          } else {
            //String uid = result.toString();
            await DatabaseService(uid: email)
                .updateUserData(name, email, profession, location, phoneNumber);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Feed()),
            );
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Color(0xFF01579B),
        child: Text(
          'CREATE ACCOUNT',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF01579B),
        title: Text('Account Setup'),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFE1F5FE),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 40.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                          'Welcome! Fill out the following information to create your account',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Roo',
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          )),
                      _buildName(),
                      _buildEmail(),
                      _buildJob(),
                      _buildPasswordTF(),
                      _locationBtn(),
                      _phoneTF(),
                      _createAccountBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
