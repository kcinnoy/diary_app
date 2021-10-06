import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_app/model/diary.dart';
import 'package:diary_app/util/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

class NewPostDialog extends StatefulWidget {
  const NewPostDialog({
    Key? key,
    this.selectedDate,
    required TextEditingController titleTextController,
    required TextEditingController descriptionTextController,
  })  : _titleTextController = titleTextController,
        _descriptionTextController = descriptionTextController,
        super(key: key);

  final TextEditingController _titleTextController;
  final TextEditingController _descriptionTextController;
  final DateTime? selectedDate;

  @override
  _NewPostDialogState createState() => _NewPostDialogState();
}

class _NewPostDialogState extends State<NewPostDialog> {
  var _buttonText = 'Done';
  CollectionReference diaryCollectionReference =
      FirebaseFirestore.instance.collection('diaries');
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
                  child: Text(_buttonText),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                  onPressed: () {
                    final _fieldsNotEmpty = widget._titleTextController
                            .toString()
                            .isNotEmpty &&
                        widget._descriptionTextController.toString().isNotEmpty;

                    if (_fieldsNotEmpty) {
                      diaryCollectionReference.add(Diary(
                        title: widget._titleTextController.text,
                        description: widget._descriptionTextController.text,
                        userId: FirebaseAuth.instance.currentUser!.uid,
                        entryTime: Timestamp.fromDate(widget.selectedDate!),
                        author: FirebaseAuth.instance.currentUser!.email!
                            .split('@')[0],
                      ).toMap());
                    }

                    setState(() {
                      _buttonText = 'Saving...';
                    });
                    Future.delayed(
                      Duration(milliseconds: 2000),
                    ).then((value) => Navigator.of(context).pop());
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
                      child: Container(color: Colors.blue, child: Text('Date')),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: Colors.red,
                        child: Text(formatDate(widget.selectedDate!)),
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
                          color: Colors.blue, child: Text('Add image:')),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: Colors.red,
                        child: IconButton(
                          icon: Icon(Icons.image_outlined),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 1,
              child: Form(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8 / 2,
                      child: Container(
                        alignment: Alignment.topLeft,
                        color: Colors.amber,
                        child: Text('Image place holder'),
                      ),
                    ),
                    TextFormField(
                      controller: widget._titleTextController,
                      decoration: InputDecoration(hintText: 'Title'),
                    ),
                    TextFormField(
                      maxLines: null,
                      controller: widget._descriptionTextController,
                      decoration:
                          InputDecoration(hintText: "What's on your mind?"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> getMultipleImageInfos() async {
  var mediaData = await ImagePickerWeb.getImageInfo;
  String mimeType = mime(Path.basename(mediaData.fileName));
  html.File mediaFile =
      new html.File(mediaData.data, mediaData.fileName, {'type': mimeType});

  if (mediaFile != null) {
    setState(() {
      _cloudFile = mediaFile;
      _fileBytes = mediaData.data;
      _imageWidget = Image.memory(mediaData.data);
    });
  }
}
