import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestorePost {
  User? user = FirebaseAuth.instance.currentUser;

  final CollectionReference posts =
      FirebaseFirestore.instance.collection("posts");

  Future<void> addPost(String message) {
    return posts.add({
      'userEmail': user!.email,
      'PostMessage': message,
      'TimeStamp': Timestamp.now()
    });
  }

  Stream<QuerySnapshot> getPosts() {
    final postStream = FirebaseFirestore.instance
        .collection("posts")
        .orderBy('TimeStamp', descending: true)
        .snapshots();
    return postStream;
  }
}
