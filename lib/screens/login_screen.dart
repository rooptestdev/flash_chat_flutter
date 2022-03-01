import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/components/rounded_button.dart';
import 'package:flash_chat_flutter/constants.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 'logo',
              child: Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            TextField(
              onChanged: (value) {
                //TODO: Do something with user input.
              },
              style: const TextStyle(color: Colors.black54),
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter your Email'),
            ),
            const SizedBox(
              height: 18.0,
            ),
            TextField(
              onChanged: (value) {
                //TODO: Do something with user input.
              },
              style: const TextStyle(color: Colors.black54),
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password'),
            ),
            const SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              color: Colors.lightBlueAccent,
              title: 'Login',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
    ;
  }
}
