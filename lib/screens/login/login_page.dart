import 'package:flutter/material.dart';
import 'login_logic.dart';
import 'package:cctracker/constants.dart';
import 'package:cctracker/Screens/Data/cc_list.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() {
    return new LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  final myLoginController = TextEditingController();
  final myPasswordController = TextEditingController();
  final LoginLogic l = LoginLogic();
  bool _validate = false;
  bool _validatePassword = false;

  @override
  void dispose() {
    myLoginController.dispose();
    myPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 40, 40, 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  child: Image.asset(
                    "assets/d.png",
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                TextField(
                  decoration: InputDecoration(
                      hintText: "Email",
                      errorText: _validate ? 'Value Can\'t Be Empty' : null),
                  controller: myLoginController,
                ),
                TextField(
                  decoration: InputDecoration(
                      hintText: "Password",
                      errorText:
                          _validatePassword ? 'Value Can\'t Be Empty' : null),
                  controller: myPasswordController,
                ),
                MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  child: Text("Log in"),
                  color: kPrimaryColor,
                  onPressed: () {
                    setState(() {
                      myPasswordController.text.isEmpty
                          ? _validatePassword = true
                          : _validatePassword = false;
                    });
                    setState(() {
                      myLoginController.text.isEmpty
                          ? _validate = true
                          : _validate = false;
                    });
                    if (l.login(
                        myLoginController.text, myPasswordController.text)) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CCList()),
                      );
                    } else {
                      showDialog(
                          context: context,
                          child: AlertDialog(
                              content: Text(myLoginController.text +
                                  " - wrong login or wrong password")));
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
