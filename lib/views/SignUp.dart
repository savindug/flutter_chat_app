import 'package:flutter/material.dart';
import 'package:flutter_chat_app/models/Users.model.dart';
import 'package:flutter_chat_app/services/Auth.service.dart';
import 'package:flutter_chat_app/widgets/Widget.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  AuthMethods _authMethods = new AuthMethods();

  TextEditingController usernameTEC = new TextEditingController();
  TextEditingController emailTEC = new TextEditingController();
  TextEditingController pwdTEC = new TextEditingController();
  TextEditingController c_pwdTEC = new TextEditingController();

  void signUp() {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
    }
    _authMethods.signUpwithEmail(emailTEC.text, pwdTEC.text).then((value) => {
          if (value != null)
            {
              print('User ID :${value.userID}'),
              setState(() {
                isLoading = false;
              })
            }
        });
  }

  bool _isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: appBarMain(context),
        body: isLoading
            ? Center(
                child: Container(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(
                alignment: Alignment.bottomCenter,
                child: SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                    validator: (val) {
                                      return val.isEmpty
                                          ? "*Invalid Username"
                                          : null;
                                    },
                                    controller: usernameTEC,
                                    style: simpleTextFieldStyle(),
                                    decoration:
                                        textFiledInputDecoration("Username")),
                                TextFormField(
                                    validator: (val) {
                                      return val.isEmpty && _isValidEmail(val)
                                          ? "*Invalid Email"
                                          : null;
                                    },
                                    controller: emailTEC,
                                    style: simpleTextFieldStyle(),
                                    decoration:
                                        textFiledInputDecoration("Email")),
                                TextFormField(
                                  obscureText: true,
                                  validator: (val) {
                                    return val.isEmpty
                                        ? "*Password must contain morethan 6 characters"
                                        : null;
                                  },
                                  controller: pwdTEC,
                                  style: simpleTextFieldStyle(),
                                  decoration:
                                      textFiledInputDecoration("Password"),
                                ),
                                TextFormField(
                                  obscureText: true,
                                  validator: (val) {
                                    return val.compareTo(pwdTEC.text) != 0
                                        ? "*Password Confirmation Failed"
                                        : null;
                                  },
                                  controller: c_pwdTEC,
                                  style: simpleTextFieldStyle(),
                                  decoration: textFiledInputDecoration(
                                      "Confirm Password"),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          GestureDetector(
                            onTap: () {
                              signUp();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(vertical: 20),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    const Color(0xff007EF4),
                                    const Color(0xff2A75BC)
                                  ]),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () => {
                              _authMethods
                                  .signInWithGoogle()
                                  .then((value) => print(value))
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(vertical: 20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Text(
                                "Sign Up with Google",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already an User? ",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                "Sign In",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    decoration: TextDecoration.underline),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 100,
                          ),
                        ],
                      )),
                ),
              ));
  }
}

TextStyle simpleTextFieldStyle() {
  return TextStyle(color: Colors.white, fontSize: 16);
}
