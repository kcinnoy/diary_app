import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
            Text(
              'Sign In',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [],
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
