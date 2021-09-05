import 'package:diary_app/model/user.dart';
import 'package:diary_app/screens/login_page.dart';
import 'package:diary_app/services/service.dart';
import 'package:diary_app/widgets/update_user_profile_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
                      return UpdateUserProfileDialog(
                          curUser: curUser,
                          displayNameTextController: _displayNameTextController,
                          avatarUrlTextController: _avatarUrlTextController);
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
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      return Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    });
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
