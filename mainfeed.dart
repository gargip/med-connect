import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp1/add.dart';
import 'package:myapp1/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp1/services/database_posts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MainFeed extends StatefulWidget {
  const MainFeed({Key key}) : super(key: key);
  @override
  _MainFeedState createState() => _MainFeedState();
}

class _MainFeedState extends State<MainFeed>
    with SingleTickerProviderStateMixin {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  var _liked = <String>{};
  var _flagged = <String>{};
  var list = new List<String>();
  String postId;
  List<List<String>> postsLists = new List<List<String>>();
  List<Tab> tabs1 = new List<Tab>();

  Future getData() async {
    final User user = auth.currentUser;
    var docRef = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.email)
        .get()
        .then((value) => {
              if (list.length > 0 && tabs1.length > 0)
                {
                  list.clear(),
                  tabs1.clear(),
                },
              for (int i = 0; i < value['interests'].length; i++)
                {list.add(value['interests'][i])},
              for (int i = 0; i < list.length; i++)
                {tabs1.add(new Tab(text: list[i])), print(list[i])},
            });
    await postData();
    return docRef;
  }

  Future postData() async {
    //get all post documents
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("posts").get();
    var posts = querySnapshot.docs;
    //create a list of list of Strings where each index represents the
    //list of posts for a stream (index of stream in postLists and lists match)
    postsLists = new List<List<String>>(list.length);
    for (int n = 0; n < list.length; n++) {
      List<String> l = new List<String>();
      postsLists[n] = l;
    }
    for (int i = 0; i < posts.length; i++) {
      //get postId for each post
      postId = posts[i].id;
      print("postID is: " + postId);
      for (int j = 0; j < list.length; j++) {
        print("stream is: " + list[j]);
        //check which stream does this post belong to
        if (postId.contains(list[j])) {
          String postData = "";
          String userTo = "";
          String titleP = "";
          //set post data equal to document's post text field
          await FirebaseFirestore.instance
              .collection('posts')
              .doc(postId)
              .get()
              .then((value) => {
                    postData = value['post'],
                    userTo = value['usermemail'],
                    titleP = value['title']
                  });
          //add this post data to the list of strings for corresponding stream
          String justUser = userTo.substring(0, userTo.indexOf('@'));
          String post = titleP + "\n by: " + justUser + "\n\n\n " + postData;
          print(post);
          postsLists[j].add(post);
          break;
        }
      }
    }
  }

  TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(
      length: tabs1.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Widget _buildList(List<String> n) => ListView.separated(
        itemCount: n.length,
        itemBuilder: (context, index) {
          return _buildListTile(n[index]);
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.black,
          );
        },
      );
  Widget _buildListTile(String state) {
    final liked = _liked.contains(state);
    final flagged = _flagged.contains(state);
    return ListTile(
      title: Text(
        state,
        style: TextStyle(fontFamily: 'OpenSans'),
      ),
      onTap: () {
        if (liked) {
          _liked.remove(state);
        } else {
          print('adding state');
          _liked.add(state);
        }
      },
      trailing: Wrap(
        spacing: 10, // space between two icons
        children: <Widget>[
          Icon(
            flagged ? Icons.flag : Icons.flag_outlined,
            color: flagged ? Colors.orange : null,
          ),
          Icon(
            liked ? Icons.favorite : Icons.favorite_border,
            color: liked ? Colors.red : null,
          ), // icon-1
          Icon(Icons.comment_outlined), // icon-2
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        hintText: "Search Posts",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white30),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.0),
    );
  }

  Widget build(BuildContext context) => FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return DefaultTabController(
            length: tabs1.length,
            child: Builder(builder: (BuildContext context) {
              final TabController tabController =
                  DefaultTabController.of(context);
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Color(0xFF01579B),
                  title: _buildSearchField(),
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
                  bottom: TabBar(
                    tabs: tabs1,
                  ),
                ),
                body: TabBarView(
                  children: [
                    for (var streamList in postsLists) _buildList(streamList),
                  ],
                ),
              );
            }),
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
}
