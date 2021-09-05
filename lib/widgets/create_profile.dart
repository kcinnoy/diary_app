import 'dart:ui';

import 'package:diary_app/model/user.dart';
import 'package:flutter/material.dart';

class CreateProfile extends StatelessWidget {
  const CreateProfile({
    Key? key,
    required this.curUser,
  }) : super(key: key);

  final MUser curUser;

  @override
  Widget build(BuildContext context) {
    final _avatarUrlTextController =
        TextEditingController(text: curUser.avatarUrl);
    final _displayNameTextController =
        TextEditingController(text: curUser.displayName);

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            InkWell(
              child: CircleAvatar(
                child: Text(
                  curUser.displayName!.toUpperCase(),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                ),
                radius: 30,
                backgroundColor: Colors.red,
                backgroundImage: NetworkImage(curUser.avatarUrl!),
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          content: Container(
                        width: MediaQuery.of(context).size.width * 0.40,
                        height: MediaQuery.of(context).size.height * 0.40,
                        child: Column(
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Edit User: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                children: [
                                  TextSpan(
                                      text:
                                          '${curUser.displayName!.toUpperCase()}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.50,
                              child: Form(
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: _displayNameTextController,
                                    ),
                                    TextFormField(
                                      controller: _avatarUrlTextController,
                                    ),
                                    SizedBox(height: 30),
                                    TextButton(
                                      onPressed: () {},
                                      child: Text('Update'),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ));
                    });
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.view_agenda_outlined,
                    size: 19,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
