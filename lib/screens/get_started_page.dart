import 'package:flutter/material.dart';

import 'login_page.dart';

class GettingStartedPage extends StatelessWidget {
  const GettingStartedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                color: Colors.grey[200],
              )),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0.1, 0.5, 0.7, 0.9],
                  colors: [
                    Colors.indigo.shade300,
                    Colors.indigo.shade700,
                    Colors.indigo.shade600,
                    Colors.indigo.shade400,
                  ],
                ),
              ),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'DiaryBook',
                      //style: Theme.of(context).textTheme.headline3,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Document your journey',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      //color: Colors.teal,
                      child: OutlinedButton(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Sign In'),
                        ),
                        style: OutlinedButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.teal,
                          side:
                              BorderSide(color: Colors.grey.shade200, width: 1),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(
                                  emailTextController: TextEditingController(),
                                  passwordTextController:
                                      TextEditingController(),
                                ),
                              ));
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
