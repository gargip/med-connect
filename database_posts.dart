import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp1/postdata.dart';

class DatabaseServicePosts {
  final String uid;
  DatabaseServicePosts({this.uid});
  //collection reference to users
  final CollectionReference postCollection =
      FirebaseFirestore.instance.collection('posts');
  Future updateUserData(
      String user, String stream, String post, String title) async {
    return await postCollection.doc(uid).set(
        {'usermemail': user, 'stream': stream, 'post': post, 'title': title});
  }

  List<PostData> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return PostData(
          useremail: doc.data()['useremail'] ?? '',
          stream: doc.data()['stream'] ?? '',
          post: doc.data()['post'] ?? '');
    }).toList();
  }

  PostData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return PostData(
        useremail: snapshot.data()['useremail'],
        stream: snapshot.data()['stream'],
        post: snapshot.data()['post']);
  }

  Stream<List<PostData>> get users {
    return postCollection.snapshots().map(_userListFromSnapshot);
  }

  Stream<PostData> get userData {
    return postCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
