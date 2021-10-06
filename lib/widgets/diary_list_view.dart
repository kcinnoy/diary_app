import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_app/model/diary.dart';
import 'package:diary_app/util/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${formatDateFromTimestamp(diary.entryTime)}',
                                    style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size(50, 30),
                                      // alignment: Alignment.centerLeft,
                                    ),
                                    onPressed: () {},
                                    child: Icon(Icons.highlight_remove),
                                    //label: Text(''),
                                  ),
                                  //Text(diary.title!),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  20.0, 10.0, 20.0, 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '•${formatDateFromTimestampHour(diary.entryTime)}',
                                    style: TextStyle(
                                      color: Colors.green,
                                    ),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size(50, 30),
                                      alignment: Alignment.centerRight,
                                    ),
                                    onPressed: () {},
                                    child: Icon(Icons.more_horiz),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  20.0, 10.0, 20.0, 10.0),
                              child: Image.network(
                                  'https://picsum.photos/400/200'),
                              //SizedBox(
                              //  width: 200,
                              // height: 100,
                              // child: Container(
                              //  color: Colors.green,
                              //),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 10.0, 20.0, 10.0),
                                  child: Text('Text header goes here...'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 10.0, 20.0, 10.0),
                                  child: Text('Text goes here...'),
                                ),
                              ],
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
