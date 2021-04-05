import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login_logic.dart';
import 'package:cctracker/constants.dart';

class LoginPage extends StatelessWidget {
  bool _showPassword = false;

  final myLoginController = TextEditingController();
  final myPasswordController = TextEditingController();
  final LoginLogic l = LoginLogic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 40, 40, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                child: Image.asset(
                  "assets/d.png",
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(hintText: "Email"),
                      controller: myLoginController,
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: "Password"),
                      controller: myPasswordController,
                    ),
                    MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      child: Text("Log in"),
                      color: kPrimaryColor,
                      onPressed: () {
                        l.login(
                            myLoginController.text, myPasswordController.text);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
