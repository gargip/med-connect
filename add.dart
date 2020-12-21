import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp1/mainfeed.dart';
import 'package:myapp1/profile.dart';
import 'package:myapp1/pickstream.dart';
import 'package:json_util/json_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp1/stream.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp1/services/database_posts.dart';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String postData = "";
  String stream = "";
  String title = "";
  int count = 0;
  Widget _streamBtn() {
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
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Roboto',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(15.0),
              hintText: 'Enter Stream to Post in',
              hintStyle: TextStyle(
                color: Colors.black26,
                fontFamily: 'Roboto',
              ),
            ),
            onChanged: (val) {
              setState(() {
                stream = val;
              });
            },
          ),
        ),
      ],
    );
    /*
    return Container(
      padding: EdgeInsets.only(top: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Stream()),
          );
          /*
          StreamPick val = new StreamPick();
          print(val.getPick());
          stream = val.getPick();*/
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Color(0xFF01579B),
        child: Text(
          'Choose Stream',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontFamily: 'Roboto',
          ),
        ),
      ),
    );*/
  }

  Widget _makeTitle() {
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
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Roboto',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(15.0),
              hintText: 'Enter Post Title',
              hintStyle: TextStyle(
                color: Colors.black26,
                fontFamily: 'Roboto',
              ),
            ),
            onChanged: (val) {
              setState(() {
                title = val;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _makePost() {
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
          height: 200.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Roboto',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(15.0),
              hintText: 'Enter Post Information',
              hintStyle: TextStyle(
                color: Colors.black26,
                fontFamily: 'Roboto',
              ),
            ),
            onChanged: (val) {
              setState(() {
                postData = val;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _imageBtn() {
    return Container(
      padding: EdgeInsets.only(top: 25.0),
      width: double.infinity,
      child: RaisedButton.icon(
        elevation: 5.0,
        onPressed: () => print('add image'),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Color(0xFF01579B),
        label: Text(
          'Add Image',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontFamily: 'Roboto',
          ),
        ),
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _continueBtn() {
    return Container(
      padding: EdgeInsets.only(top: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          final User user = auth.currentUser;
          if (user == null) {
            setState(() {
              print('no such user exists');
            });
          } else {
            var docRef = await FirebaseFirestore.instance
                .collection('postCounter')
                .doc('post_counter')
                .get()
                .then((value) => {
                      count = value['counter'],
                      count = count + 1,
                    });
            await FirebaseFirestore.instance
                .collection('postCounter')
                .doc('post_counter')
                .update({'counter': count});
            String postID = stream + "_" + count.toString();
            await DatabaseServicePosts(uid: postID)
                .updateUserData(user.email, stream, postData, title);
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.email)
                .update({
              "postIDS": FieldValue.arrayUnion([postID])
            });
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainFeed()),
            );
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Color(0xFF01579B),
        child: Text(
          'Continue',
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
        title: Text('New Post'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.home_filled,
              color: Colors.white,
            ),
            label: Text(
              'Home',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              );
            },
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
                      _streamBtn(),
                      _makeTitle(),
                      _makePost(),
                      _imageBtn(),
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
