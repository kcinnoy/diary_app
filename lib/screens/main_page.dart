import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_app/model/diary.dart';
import 'package:diary_app/model/user.dart';
import 'package:diary_app/widgets/create_profile.dart';
import 'package:diary_app/widgets/diary_list_view.dart';
import 'package:diary_app/widgets/dropdown_one.dart';
import 'package:diary_app/widgets/new_post_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String? _dropDownText;
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final _titleTextController = TextEditingController();
    final _descriptionTextController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        //primary: false,
        title: Row(
          children: [
            Text(
              'Diary',
              style: TextStyle(
                fontSize: 39,
                color: Colors.blueGrey[100],
              ),
            ),
            Text(
              'Book',
              style: TextStyle(
                fontSize: 39,
                color: Colors.green,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    hint: (_dropDownText == null)
                        ? Text(
                            'Select',
                            style: TextStyle(color: Colors.grey),
                          )
                        : Text(
                            _dropDownText!,
                            style: TextStyle(color: Colors.grey),
                          ),
                    items: <String>['Latest', 'Earliest']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value == 'Latest') {
                        setState(() {
                          _dropDownText = value.toString();
                        });
                      } else if (value == 'Earliest') {
                        setState(() {
                          _dropDownText = value.toString();
                        });
                      }
                    }, //onChanged
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    dropdownColor: Colors.deepOrange,
                  ),
                ),
              ),
              DropdownOne(
                text: "CTA",
              ),
              StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  final usersListStream = snapshot.data!.docs.map((docs) {
                    return MUser.fromDocument(docs);
                  }).where((muser) {
                    return (muser.uid ==
                        FirebaseAuth.instance.currentUser!.uid);
                  }).toList();

                  MUser curUser = usersListStream[0];

                  return CreateProfile(curUser: curUser);
                },
              ),
            ],
          ),
        ],
        backgroundColor: Colors.grey[200],
        toolbarHeight: 70,
        elevation: 0,
      ),
      //Body Start
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border(
                  right: BorderSide(
                    width: 0.4,
                    color: Colors.grey,
                  ),
                ),
              ),
              //color: Colors.green,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(38.0),
                    child: SfDateRangePicker(
                      onSelectionChanged: (dateRangePickerSelection) {
                        setState(() {});
                        selectedDate = dateRangePickerSelection.value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40),
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: TextButton.icon(
                          icon: Icon(
                            Icons.add_circle_outline_outlined,
                            size: 20,
                            color: Colors.grey,
                          ),
                          label: Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                'New Post',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return NewPostDialog(
                                    selectedDate: selectedDate,
                                    titleTextController: _titleTextController,
                                    descriptionTextController:
                                        _descriptionTextController);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          DiaryListView()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        mini: true,
        tooltip: 'Add',
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
