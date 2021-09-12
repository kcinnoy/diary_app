import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_app/model/user.dart';
import 'package:diary_app/widgets/create_profile.dart';
import 'package:diary_app/widgets/dropdown_one.dart';
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

  @override
  Widget build(BuildContext context) {
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
                      onSelectionChanged:
                          (dateRangePickerSelectionChangedArgs) {},
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
                                return AlertDialog(
                                  content: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                              child: Text('Discard'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            TextButton(
                                              child: Text('Done'),
                                              style: TextButton.styleFrom(
                                                primary: Colors.white,
                                                backgroundColor: Colors.green,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(15),
                                                  ),
                                                ),
                                              ),
                                              onPressed: () {
                                                //ToDo: add function
                                              },
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 30),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            color: Colors.green,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                      color: Colors.blue,
                                                      child: Text('Date')),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    color: Colors.red,
                                                    child: Text('June 7, 2021'),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            color: Colors.green,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                      color: Colors.blue,
                                                      child:
                                                          Text('Add image:')),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    color: Colors.red,
                                                    child: IconButton(
                                                      icon: Icon(
                                                          Icons.image_outlined),
                                                      onPressed: () {},
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: Form(
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.8 /
                                                      2,
                                                  child: Container(
                                                    color: Colors.amber,
                                                    child: Text(
                                                        'Image place holder'),
                                                  ),
                                                ),
                                                TextFormField(
                                                  controller:
                                                      _titleTextController,
                                                  decoration: InputDecoration(
                                                      hintText: 'Title'),
                                                ),
                                                TextFormField(
                                                  controller:
                                                      _descriptionTextController,
                                                  decoration: InputDecoration(
                                                      hintText: 'Title'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
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
          Expanded(
            flex: 3,
            child: Container(
              child: Column(
                children: [
                  Expanded(
                      child: Container(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Card(
                                  elevation: 4,
                                  child: ListTile(
                                    title: Text('Hi'),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ))
                ],
              ),
            ),
          )
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
