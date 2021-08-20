import 'dart:ui';

import 'package:diary_app/widgets/input_decorator.dart';
import 'package:diary_app/widgets/login_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final GlobalKey<FormState>? _globalKey = GlobalKey<FormState>();

  // const LoginPage(
  //     {Key? key,
  //     GlobalKey<FormState>? formKey,
  //     required TextEditingController passwordTextController,
  //     required TextEditingController emailTextController})
  //     : _emailTextController = emailTextController,
  //       _passwordTextController = emailTextController,
  //       _globalKey = formKey,
  //       super(key: key);

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
                  child: LoginForm(
                      formKey: _globalKey,
                      emailTextController: _emailTextController,
                      passwordTextController: _passwordTextController),
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
