import 'package:json_util/json_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp1/mainfeed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp1/services/database_users.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  var choices = new List();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Widget _specialityButtons() {
    return Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new RaisedButton(
            elevation: 5.0,
            child: Text(
              'Pediatrics',
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  letterSpacing: 1.5,
                  fontSize: 12.0,
                  fontFamily: 'OpenSans'),
            ),
            color: choices.contains('Pediatrics')
                ? Color(0xFF0288D1)
                : Color(0xFF01579B),
            onPressed: () {
              setState(() {
                if (choices.contains('Pediiatrics')) {
                  choices.remove('Pediatrics');
                } else {
                  choices.add('Pediatrics');
                }
              });
            },
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          Padding(padding: EdgeInsets.all(10.0)),
          new RaisedButton(
            elevation: 5.0,
            child: Text(
              'Family Med',
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  letterSpacing: 1.5,
                  fontSize: 12.0,
                  fontFamily: 'OpenSans'),
            ),
            color: choices.contains('Family Med')
                ? Color(0xFF0288D1)
                : Color(0xFF01579B),
            onPressed: () {
              setState(() {
                if (choices.contains('Family Med')) {
                  choices.remove('Family Med');
                } else {
                  choices.add('Family Med');
                }
              });
            },
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          Padding(padding: EdgeInsets.all(10.0)),
          new RaisedButton(
            elevation: 5.0,
            child: Text(
              'OBGYN',
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  letterSpacing: 1.5,
                  fontSize: 12.0,
                  fontFamily: 'OpenSans'),
            ),
            color: choices.contains('OBGYN')
                ? Color(0xFF0288D1)
                : Color(0xFF01579B),
            onPressed: () {
              setState(() {
                if (choices.contains('OBGYN')) {
                  choices.remove('OBGYN');
                } else {
                  choices.add('OBGYN');
                }
              });
            },
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _specialityButtonsSecond() {
    return Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new RaisedButton(
            elevation: 5.0,
            child: Text(
              'Emergency',
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  letterSpacing: 1.5,
                  fontSize: 12.0,
                  fontFamily: 'OpenSans'),
            ),
            color: choices.contains('Emergency')
                ? Color(0xFF0288D1)
                : Color(0xFF01579B),
            onPressed: () {
              setState(() {
                if (choices.contains('Emergency')) {
                  choices.remove('Emergency');
                } else {
                  choices.add('Emergency');
                }
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          Padding(padding: EdgeInsets.all(10.0)),
          new RaisedButton(
            elevation: 5.0,
            child: Text(
              'Surgery',
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  letterSpacing: 1.5,
                  fontSize: 12.0,
                  fontFamily: 'OpenSans'),
            ),
            color: choices.contains('Surgery')
                ? Color(0xFF0288D1)
                : Color(0xFF01579B),
            onPressed: () {
              setState(() {
                if (choices.contains('Surgery')) {
                  choices.remove('Surgery');
                } else {
                  choices.add('Surgery');
                }
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          Padding(padding: EdgeInsets.all(10.0)),
          new RaisedButton(
            elevation: 5.0,
            child: Text(
              'Dentistry',
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  letterSpacing: 1.5,
                  fontSize: 12.0,
                  fontFamily: 'OpenSans'),
            ),
            color: choices.contains('Dentistry')
                ? Color(0xFF0288D1)
                : Color(0xFF01579B),
            onPressed: () {
              setState(() {
                if (choices.contains('Dentistry')) {
                  choices.remove('Dentistry');
                } else {
                  choices.add('Dentistry');
                }
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _specialityButtonsThird() {
    return Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new RaisedButton(
            elevation: 5.0,
            child: Text(
              'Cardiology',
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  letterSpacing: 1.5,
                  fontSize: 12.0,
                  fontFamily: 'OpenSans'),
            ),
            color: choices.contains('Cardiology')
                ? Color(0xFF0288D1)
                : Color(0xFF01579B),
            onPressed: () {
              setState(() {
                if (choices.contains('Cardiology')) {
                  choices.remove('Cardiology');
                } else {
                  choices.add('Cardiology');
                }
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          Padding(padding: EdgeInsets.all(10.0)),
          new RaisedButton(
            elevation: 5.0,
            child: Text(
              'Psychiatry',
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  letterSpacing: 1.5,
                  fontSize: 12.0,
                  fontFamily: 'OpenSans'),
            ),
            color: choices.contains('Psychiatry')
                ? Color(0xFF0288D1)
                : Color(0xFF01579B),
            onPressed: () {
              setState(() {
                if (choices.contains('Psychiatry')) {
                  choices.remove('Psychiatry');
                } else {
                  choices.add('Psychiatry');
                }
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          Padding(padding: EdgeInsets.all(10.0)),
          new RaisedButton(
            elevation: 5.0,
            child: Text(
              'Neurology',
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  letterSpacing: 1.5,
                  fontSize: 12.0,
                  fontFamily: 'OpenSans'),
            ),
            color: choices.contains('Neurology')
                ? Color(0xFF0288D1)
                : Color(0xFF01579B),
            onPressed: () {
              setState(() {
                if (choices.contains('Neurology')) {
                  choices.remove('Neurology');
                } else {
                  choices.add('Neurology');
                }
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _occupationFirstRow() {
    return Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new RaisedButton(
            elevation: 5.0,
            child: Text(
              'Physicians',
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  letterSpacing: 1.5,
                  fontSize: 12.0,
                  fontFamily: 'OpenSans'),
            ),
            color: choices.contains('Physicians')
                ? Color(0xFF0288D1)
                : Color(0xFF01579B),
            onPressed: () {
              setState(() {
                if (choices.contains('Physicians')) {
                  choices.remove('Physicians');
                } else {
                  choices.add('Physicians');
                }
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          Padding(padding: EdgeInsets.all(10.0)),
          new RaisedButton(
            elevation: 5.0,
            child: Text(
              'Surgeons',
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  letterSpacing: 1.5,
                  fontSize: 12.0,
                  fontFamily: 'OpenSans'),
            ),
            color: choices.contains('Surgeons')
                ? Color(0xFF0288D1)
                : Color(0xFF01579B),
            onPressed: () {
              setState(() {
                if (choices.contains('Surgeons')) {
                  choices.remove('Surgeons');
                } else {
                  choices.add('Surgeons');
                }
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          Padding(padding: EdgeInsets.all(10.0)),
          new RaisedButton(
            elevation: 5.0,
            child: Text(
              'Nurses',
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  letterSpacing: 1.5,
                  fontSize: 12.0,
                  fontFamily: 'OpenSans'),
            ),
            color: choices.contains('Nurses')
                ? Color(0xFF0288D1)
                : Color(0xFF01579B),
            onPressed: () {
              setState(() {
                if (choices.contains('Nurses')) {
                  choices.remove('Nurses');
                } else {
                  choices.add('Nurses');
                }
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _occupationSecondRow() {
    return Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new RaisedButton(
            elevation: 5.0,
            child: Text(
              'Therapists',
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  letterSpacing: 1.5,
                  fontSize: 12.0,
                  fontFamily: 'OpenSans'),
            ),
            color: choices.contains('Therapists')
                ? Color(0xFF0288D1)
                : Color(0xFF01579B),
            onPressed: () {
              setState(() {
                if (choices.contains('Therapists')) {
                  choices.remove('Therapists');
                } else {
                  choices.add('Therapists');
                }
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          Padding(padding: EdgeInsets.all(10.0)),
          new RaisedButton(
            elevation: 5.0,
            child: Text(
              'Dieticians',
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  letterSpacing: 1.5,
                  fontSize: 12.0,
                  fontFamily: 'OpenSans'),
            ),
            color: choices.contains('Dieticians')
                ? Color(0xFF0288D1)
                : Color(0xFF01579B),
            onPressed: () {
              setState(() {
                if (choices.contains('Dieticians')) {
                  choices.remove('Dieticians');
                } else {
                  choices.add('Dieticians');
                }
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _interestButtonsFirst() {
    return Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new RaisedButton(
            elevation: 5.0,
            child: Text(
              'COVID-19',
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  letterSpacing: 1.5,
                  fontSize: 12.0,
                  fontFamily: 'OpenSans'),
            ),
            color: choices.contains('COVID-19')
                ? Color(0xFF0288D1)
                : Color(0xFF01579B),
            onPressed: () {
              setState(() {
                if (choices.contains('COVID-19')) {
                  choices.remove('COVID-19');
                } else {
                  choices.add('COVID-19');
                }
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          Padding(padding: EdgeInsets.all(10.0)),
          new RaisedButton(
            elevation: 5.0,
            child: Text(
              'Research',
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  letterSpacing: 1.5,
                  fontSize: 12.0,
                  fontFamily: 'OpenSans'),
            ),
            color: choices.contains('Research')
                ? Color(0xFF0288D1)
                : Color(0xFF01579B),
            onPressed: () {
              setState(() {
                if (choices.contains('Research')) {
                  choices.remove('Research');
                } else {
                  choices.add('Research');
                }
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          Padding(padding: EdgeInsets.all(10.0)),
          new RaisedButton(
            elevation: 5.0,
            child: Text(
              'Diet',
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  letterSpacing: 1.5,
                  fontSize: 12.0,
                  fontFamily: 'OpenSans'),
            ),
            color: choices.contains('Diet')
                ? Color(0xFF0288D1)
                : Color(0xFF01579B),
            onPressed: () {
              setState(() {
                if (choices.contains('Diet')) {
                  choices.remove('Diet');
                } else {
                  choices.add('Diet');
                }
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _interestButtonsSecond() {
    return Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new RaisedButton(
            elevation: 5.0,
            child: Text(
              'Health Tech',
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  letterSpacing: 1.5,
                  fontSize: 12.0,
                  fontFamily: 'OpenSans'),
            ),
            color: choices.contains('Health Tech')
                ? Color(0xFF0288D1)
                : Color(0xFF01579B),
            onPressed: () {
              setState(() {
                if (choices.contains('Health Tech')) {
                  choices.remove('Health Tech');
                } else {
                  choices.add('Health Tech');
                }
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          Padding(padding: EdgeInsets.all(10.0)),
          new RaisedButton(
            elevation: 5.0,
            child: Text(
              'Fitness',
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  letterSpacing: 1.5,
                  fontSize: 12.0,
                  fontFamily: 'OpenSans'),
            ),
            color: choices.contains('Fitness')
                ? Color(0xFF0288D1)
                : Color(0xFF01579B),
            onPressed: () {
              setState(() {
                if (choices.contains('Fitness')) {
                  choices.remove('Fitness');
                } else {
                  choices.add('Fitness');
                }
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          Padding(padding: EdgeInsets.all(10.0)),
          new RaisedButton(
            elevation: 5.0,
            child: Text(
              'Rx Info',
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  letterSpacing: 1.5,
                  fontSize: 12.0,
                  fontFamily: 'OpenSans'),
            ),
            color: choices.contains('Rx Info')
                ? Color(0xFF0288D1)
                : Color(0xFF01579B),
            onPressed: () {
              setState(() {
                if (choices.contains('Rx Info')) {
                  choices.remove('Rx Info');
                } else {
                  choices.add('Rx Info');
                }
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _interestButtonsThird() {
    return Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new RaisedButton(
            elevation: 5.0,
            child: Text(
              'Medical News',
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  letterSpacing: 1.5,
                  fontSize: 12.0,
                  fontFamily: 'OpenSans'),
            ),
            color: choices.contains('Medical News')
                ? Color(0xFF0288D1)
                : Color(0xFF01579B),
            onPressed: () {
              setState(() {
                if (choices.contains('Medical News')) {
                  choices.remove('Medical News');
                } else {
                  choices.add('Medical News');
                }
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          Padding(padding: EdgeInsets.all(10.0)),
          new RaisedButton(
            elevation: 5.0,
            child: Text(
              'Mental Health',
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  letterSpacing: 1.5,
                  fontSize: 12.0,
                  fontFamily: 'OpenSans'),
            ),
            color: choices.contains('Mental Health')
                ? Color(0xFF0288D1)
                : Color(0xFF01579B),
            onPressed: () {
              setState(() {
                if (choices.contains('Mental Health')) {
                  choices.remove('Mental Health');
                } else {
                  choices.add('Mental Health');
                }
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _continueBtn() {
    return Container(
      padding: EdgeInsets.only(top: 5.0),
      width: 200,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          final User user = auth.currentUser;
          if (user == null) {
            print('error in getting current user');
          } else {
            firestore
                .collection('users')
                .doc(user.email)
                .set({'interests': choices}, SetOptions(merge: true));
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainFeed()),
            );
          }
        },
        shape: RoundedRectangleBorder(),
        color: Color(0xFF01579B),
        child: Text(
          'CONTINUE',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            letterSpacing: 1.5,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF01579B),
        title: Text('Personalize Your Feed'),
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
                    horizontal: 30.0,
                    vertical: 30.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Speciality',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF01579B),
                          )),
                      _specialityButtons(),
                      _specialityButtonsSecond(),
                      _specialityButtonsThird(),
                      Padding(padding: EdgeInsets.only(top: 25.0)),
                      Text('Occupation',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF01579B),
                          )),
                      _occupationFirstRow(),
                      _occupationSecondRow(),
                      Padding(padding: EdgeInsets.only(top: 25.0)),
                      Text('Interests',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF01579B),
                          )),
                      _interestButtonsFirst(),
                      _interestButtonsSecond(),
                      _interestButtonsThird(),
                      _continueBtn(),
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
