import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_app/model/user.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DiaryService {
  final CollectionReference userCollectionReference =
      FirebaseFirestore.instance.collection('users');

  Future<void> loginUser(String email, String password) async {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return;
  }

  Future<void> createUser(
      String displayName, BuildContext context, String uid) async {
    MUser user = MUser(
        //id:
        uid: uid,
        displayName: displayName,
        //profession:
        avatarUrl: 'https://i.pravatar.cc/300');
    userCollectionReference.add(user.toMap());
    return;
  }
}
