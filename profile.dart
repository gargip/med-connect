import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp1/add.dart';
import 'package:myapp1/chat.dart';
import 'package:myapp1/mainfeed.dart';
import 'package:myapp1/posts.dart';
import 'package:provider/provider.dart';
import 'package:myapp1/userdata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp1/services/database_posts.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = "";
  String profession = "";
  String email = "";
  String location = "";
  String phone = "";
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool> getData() async {
    final User user = auth.currentUser;
    email = user.email;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.email)
        .get()
        .then((value) => {
              name = value['name'],
              profession = value['profession'],
              location = value['location'],
              phone = value['phoneNumber'],
              print(name),
              print(profession),
              print(location),
              print(phone),
            });
    return true;
  }

  Widget _mypostsBtn() {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      width: double.infinity,
      child: RaisedButton.icon(
        elevation: 2.0,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Posts()),
          );
        },
        padding: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Color(0xFF01579B),
        label: Text(
          'View Posts',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontFamily: 'Roboto',
          ),
        ),
        icon: Icon(
          Icons.edit_rounded,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _chatBtn() {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      width: double.infinity,
      child: RaisedButton.icon(
        elevation: 2.0,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Chat()),
          );
        },
        padding: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Color(0xFF01579B),
        label: Text(
          'Burnout Help',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontFamily: 'Roboto',
          ),
        ),
        icon: Icon(
          Icons.chat_bubble_outline,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF01579B),
        title: Text('My Profile'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.dynamic_feed,
              color: Colors.white,
            ),
            label: Text(
              'News Feed',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainFeed()),
              );
            },
          ),
          FlatButton.icon(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Add()),
              );
            },
            label: Text(
              'Add',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
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
                    vertical: 20.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Welcome ' + name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF01579B),
                            fontFamily: 'Roboto',
                            fontSize: 30.0,
                            //fontWeight: FontWeight.bold,
                          )),
                      Padding(padding: EdgeInsets.only(top: 15.0)),
                      CircleAvatar(
                        radius: 100.0,
                        backgroundImage: NetworkImage(
                            'https://www.browardhealth.org/-/media/Broward-Health/placeholder/Doctor-placeholder-male.jpg'),
                        backgroundColor: Colors.white,
                      ),
                      Padding(padding: EdgeInsets.only(top: 15.0)),
                      Text(location,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF01579B),
                            fontFamily: 'Roboto',
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          )),
                      Padding(padding: EdgeInsets.only(top: 15.0)),
                      Text(profession,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF01579B),
                            //color: Color(0xFF01579B),
                            fontFamily: 'Roboto',
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          )),
                      Padding(padding: EdgeInsets.only(top: 15.0)),
                      FlatButton.icon(
                        icon: Icon(
                          Icons.call,
                          color: Color(0xFF01579B),
                        ),
                        onPressed: () => print('phone button pressed'),
                        label: Text(
                          phone,
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Color(0xFF01579B),
                          ),
                        ),
                      ),
                      //Padding(padding: EdgeInsets.only(top: 10.0)),
                      FlatButton.icon(
                        icon: Icon(
                          Icons.email,
                          color: Color(0xFF01579B),
                        ),
                        onPressed: () => print('email button pressed'),
                        label: Text(
                          email,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Color(0xFF01579B),
                          ),
                        ),
                      ),
                      _mypostsBtn(),
                      _chatBtn(),
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
