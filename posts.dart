import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp1/add.dart';
import 'package:myapp1/chat.dart';
import 'package:myapp1/mainfeed.dart';
import 'package:myapp1/profile.dart';
import 'package:myapp1/pickstream.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp1/services/database_posts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Posts extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Posts> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  var postsList = new List<String>();
  var ids = new List<String>();
  Future getData() async {
    print("inside IN POSTS>DART");
    final User user = auth.currentUser;
    var docRef = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.email)
        .get()
        .then((value) => {
              print("IN THEN FIELD: " + user.email),
              ids.clear(),
              for (int i = 0; i < value['postIDS'].length; i++)
                {ids.add(value['postIDS'][i])}
            });
    for (int i = 0; i < ids.length; i++) {
      print("id value hereL " + ids[i]);
    }
    postData();
    return docRef;
  }

  Future postData() async {
    //get all post documents
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("posts").get();
    var posts = querySnapshot.docs;
    //create a list of list of Strings where each index represents the
    //list of posts for a stream (index of stream in postLists and lists match)
    for (int i = 0; i < ids.length; i++) {
      //get postId for each post
      for (int j = 0; j < posts.length; j++) {
        //print("stream is: " + posts[j]);
        //check which stream does this post belong to
        if (ids[i].compareTo(posts[j].id) == 0) {
          print("in here");
          String postData = "";
          String streamplace = "";
          //set post data equal to document's post text field
          await FirebaseFirestore.instance
              .collection('posts')
              .doc(posts[j].id)
              .get()
              .then((value) =>
                  {postData = value['post'], streamplace = value['stream']});
          String listentry = "Stream: " + streamplace + "\n\n" + postData;
          postsList.add(listentry);
        }
      }
    }
  }

  Widget _buildListTile(String state) {
    return ListTile(
      title: Text(
        state,
        style: TextStyle(fontFamily: 'OpenSans'),
      ),
      onTap: () {},
    );
  }

  Widget _buildList(List<String> posts) => ListView.separated(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return _buildListTile(postsList[index]);
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.black,
          );
        },
      );

  Widget build(BuildContext context) => FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFF01579B),
              title: Text('My Posts'),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(
                    Icons.chat_bubble_outline,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Burnout Help',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Chat()),
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
            body: _buildList(postsList),
          );
        } else {
          return Container(
            color: Color(0xFFE1F5FE),
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
                  Padding(padding: EdgeInsets.only(bottom: 175.0)),
                  Center(
                      child: SpinKitRotatingCircle(
                    color: Color(0xFF01579B),
                    size: 50.0,
                  )),
                ],
              ),
            ),
          );
        }
      });

/*
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF01579B),
        title: Text('My Posts'),
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
      body: _buildList(postsList),
    );
  }*/
}
