import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:BackgroundTest/helper/apiHelper.dart';
import 'package:BackgroundTest/main.dart';
import 'package:BackgroundTest/modals/global.dart';
import 'package:BackgroundTest/screens/bankAccounts.dart';
import 'package:BackgroundTest/screens/fatca.dart';
import 'package:BackgroundTest/screens/mainSignUp.dart';
import 'package:BackgroundTest/screens/mandate1.dart';
import 'package:BackgroundTest/screens/mandate2.dart';
import 'package:BackgroundTest/screens/passwordReset.dart';
import 'package:BackgroundTest/screens/signUp.dart';
import 'package:BackgroundTest/screens/verify.dart';

import 'home.dart';
import 'kycCheck.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController password = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: loading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 2,
                  ),
                  Text(
                    "Welcome back",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Text("Sign in to continue"),
                  SizedBox(
                    height: 75,
                  ),
                  Container(
                    height: 50,
                    // color: Colors.green,
                    child: TextField(
                      controller: mobile,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(hintText: "Mobile"),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: 50,
                    // color: Colors.green,
                    child: TextField(
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration(hintText: "Password"),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return PasswordReset();
                              }));
                            },
                            child: Text(
                              "I don’t know my password",
                              style: TextStyle(color: Color(0XFF1A1C6C)),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return SignUp();
                                }));
                              },
                              child: Text(
                                "I don’t have an account",
                                style: TextStyle(color: Color(0XFF1A1C6C)),
                              )),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () async {
                          if (email.text.length != 0 ||
                              password.text.length != 0) {
                            setState(() {
                              loading = true;
                            });
                            Map response = await postApi("api/login", {
                              "mobile": mobile.text,
                              "password": password.text
                            }, {});
                            print(response);
                            setState(() {
                              loading = false;
                            });
                            if (response["code"] != 200) {
                              Get.snackbar(response["message"], "",
                                  snackPosition: SnackPosition.BOTTOM);
                            } else {
                              user = response["user"];
                              apiToken = response["api_token"];
                              if (user["otp_verified"] == 0) {
                                Get.to(Verify());
                              } else {
                                if (user["active"] != 1) {
                                  Get.snackbar(
                                      "Your's account has been deactivated.Please contact Admin",
                                      "",
                                      snackPosition: SnackPosition.BOTTOM);
                                } else {
                                  if (user["kyc_verified"] != 1) {
                                    Get.to(Kyc());
                                  } else if (user["ucc_verified"] != 1) {
                                    Get.to(BankAccounts());
                                  } else {
                                    Get.to(Home());
                                  }
                                }
                              }
                            }
                          } else {
                            Get.snackbar("Please Enter Credentials", "",
                                snackPosition: SnackPosition.BOTTOM);
                          }
                        },
                        icon: Icon(Icons.arrow_forward_ios),
                        // icon: Icon(
                        //   Icons.arrow_right,
                        //   size: 40,
                        // )
                      )
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
