import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_app/model/user.dart';
import 'package:flutter/material.dart';

class DiaryService {
  final CollectionReference userCollectionReference =
      FirebaseFirestore.instance.collection('users');

  Future<void> createUser(
      String displayName, BuildContext context, String uid) async {
    MUser user = MUser(
        //id:
        uid: uid,
        displayName: displayName,
        //profession:
        avatarUrl: 'https://picsum.photos/200/300');
    userCollectionReference.add(user.toMap());
    return;
  }
}
