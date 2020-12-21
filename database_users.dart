import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp1/userdata.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  //collection reference to users
  final CollectionReference userCollection =
      Firestore.instance.collection('users');
  Future updateUserData(String name, String email, String profession,
      String location, String phoneNumber) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'email': email,
      'profession': profession,
      'location': location,
      'phoneNumber': phoneNumber
    });
  }

  List<UserData> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return UserData(
          name: doc.data()['name'] ?? '',
          email: doc.data()['email'] ?? '',
          profession: doc.data()['profession'] ?? '',
          location: doc.data()['location'] ?? '',
          phone: doc.data()['phoneNumber'] ?? '');
    }).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        name: snapshot.data()['name'],
        email: snapshot.data()['email'],
        profession: snapshot.data()['profession'],
        location: snapshot.data()['location'],
        phone: snapshot.data()['phoneNumber']);
  }

  Stream<List<UserData>> get users {
    return userCollection.snapshots().map(_userListFromSnapshot);
  }

  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
