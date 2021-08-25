import 'dart:ui';

import 'package:diary_app/widgets/create_account_form.dart';
import 'package:diary_app/widgets/input_decorator.dart';
import 'package:diary_app/widgets/login_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final GlobalKey<FormState>? _globalKey = GlobalKey<FormState>();

  bool isCreatedAccountClicked = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.indigo.shade200,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                SizedBox(
                  width: 400,
                  //height: 300,
                  child: isCreatedAccountClicked
                      ? CreateAccountForm(
                          formKey: _globalKey,
                          emailTextController: _emailTextController,
                          passwordTextController: _passwordTextController,
                        )
                      : LoginForm(
                          formKey: _globalKey,
                          emailTextController: _emailTextController,
                          passwordTextController: _passwordTextController,
                        ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(isCreatedAccountClicked ? '' : 'New user?'),
                    SizedBox(
                      width: 5,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          if (!isCreatedAccountClicked) {
                            isCreatedAccountClicked = true;
                          } else {
                            isCreatedAccountClicked = false;
                          }
                        });
                      },
                      child: Text(isCreatedAccountClicked
                          ? 'Already have an account?'
                          : 'Create an account'),
                    ),
                  ],
                )
              ],
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.indigo.shade200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
