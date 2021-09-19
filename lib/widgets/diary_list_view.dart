import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_app/model/diary.dart';
import 'package:diary_app/util/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DiaryListView extends StatelessWidget {
  const DiaryListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('diaries').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          var filteredList = snapshot.data!.docs.map((diary) {
            return Diary.fromDocument(diary);
          }).where((item) {
            return (item.userId == FirebaseAuth.instance.currentUser!.uid);
          }).toList();

          return Column(
            children: [
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      Diary diary = filteredList[index];
                      return Card(
                        elevation: 4,
                        child: Column(
                          children: [
                            ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${formatDate(diary.entryTime!.toDate())}',
                                    style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextButton.icon(
                                      onPressed: () {},
                                      icon: Icon(Icons.highlight_remove),
                                      label: Text('')),
                                  //Text(diary.title!),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          );
        });
  }
}
