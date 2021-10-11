import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:BackgroundTest/helper/apiHelper.dart';
import 'package:BackgroundTest/main.dart';
import 'package:BackgroundTest/modals/global.dart';
import 'package:BackgroundTest/screens/login.dart';

class NewPassword extends StatefulWidget {
  final bool reset;
  const NewPassword({Key key, this.reset}) : super(key: key);

  @override
  _NewPasswordState createState() => _NewPasswordState(reset);
}

class _NewPasswordState extends State<NewPassword> {
  final bool reset;
  TextEditingController password = TextEditingController();
  bool loading = false;
  _NewPasswordState(this.reset);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: loading == true
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 30,
                      )),
                  SizedBox(
                    height: 100,
                  ),
                  Text(
                    reset == true ? "Reset Password" : "Set a Password",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                      decoration:
                          InputDecoration(hintText: "Enter a new password"),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Password should be atleast 8 characters",
                    style: TextStyle(color: Color(0XFF1A1C6C)),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () async {
                        print(apiToken);

                        if (password.text.length < 8) {
                          Get.snackbar(
                              "Password should be at least 8 digit long", "",
                              snackPosition: SnackPosition.BOTTOM);
                        } else {
                          if (reset == false) {
                            loading = true;
                            setState(() {});
                            Map response = await postApi("api/password", {
                              "password": password.text,
                            }, {
                              // 'Content-Type': 'application/json',
                              // 'Accept': 'application/json',
                              'Authorization': 'Bearer ${apiToken.toString()}',
                            });
                            print(response);
                            if (response["code"] == 200) {
                              Get.snackbar(response["message"].toString(), "",
                                  snackPosition: SnackPosition.BOTTOM);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Login();
                              }));
                            }
                            loading = false;
                            setState(() {});
                          }
                        }
                      },
                      icon: Icon(Icons.arrow_forward_ios),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
