import 'package:diary_app/model/user.dart';
import 'package:diary_app/services/service.dart';
import 'package:flutter/material.dart';

class UpdateUserProfileDialog extends StatelessWidget {
  const UpdateUserProfileDialog({
    Key? key,
    required this.curUser,
    required TextEditingController displayNameTextController,
    required TextEditingController avatarUrlTextController,
  })  : _displayNameTextController = displayNameTextController,
        _avatarUrlTextController = avatarUrlTextController,
        super(key: key);

  final MUser curUser;
  final TextEditingController _displayNameTextController;
  final TextEditingController _avatarUrlTextController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Container(
      width: MediaQuery.of(context).size.width * 0.40,
      height: MediaQuery.of(context).size.height * 0.40,
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              text: 'Edit User: ',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              children: [
                TextSpan(
                    text: '${curUser.displayName!.toUpperCase()}',
                    style: TextStyle(
                        fontWeight: FontWeight.normal, color: Colors.black))
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
                    child: Text('Update'),
                    onPressed: () {
                      DiaryService().update(
                          curUser,
                          _displayNameTextController.text,
                          _avatarUrlTextController.text,
                          context);
                      Future.delayed(
                        Duration(milliseconds: 200),
                      ).then((value) {
                        return Navigator.of(context).pop();
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
