import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'input_decorator.dart';

class CreateAccountForm extends StatelessWidget {
  const CreateAccountForm({
    Key? key,
    required TextEditingController emailTextController,
    required TextEditingController passwordTextController,
    GlobalKey<FormState>? formKey,
  })  : _emailTextController = emailTextController,
        _passwordTextController = passwordTextController,
        _globalKey = formKey,
        super(key: key);

  final TextEditingController _emailTextController;
  final TextEditingController _passwordTextController;
  final GlobalKey<FormState>? _globalKey;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.vpn_key_outlined),
            title: const Text('Create an Account'),
            subtitle: Text(
              'Please enter a valid email and password (Minimum 6 characters)',
              //style:
              //TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _globalKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    validator: (value) {
                      return value!.isEmpty ? 'Please enter email' : null;
                    },
                    controller: _emailTextController,
                    decoration:
                        buildInputDecoration('email', 'enter email address'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      return value!.isEmpty ? 'Please enter password' : null;
                    },
                    obscureText: true,
                    controller: _passwordTextController,
                    decoration:
                        buildInputDecoration('password', 'enter password'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            padding: EdgeInsetsDirectional.all(15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            backgroundColor: Colors.tealAccent),
                        onPressed: () {
                          if (_globalKey!.currentState!.validate()) {
                            FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: _emailTextController.text,
                                    password: _passwordTextController.text)
                                .then((value) => print(value.user!.email));
                          }
                        },
                        child: Text('Create Account')),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
