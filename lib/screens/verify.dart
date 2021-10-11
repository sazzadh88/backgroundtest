import 'package:BackgroundTest/modals/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:BackgroundTest/helper/apiHelper.dart';
import 'package:BackgroundTest/modals/global.dart';
import 'mainSignUp.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';

class Verify extends StatefulWidget {
  const Verify({Key key}) : super(key: key);

  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  TextEditingController pinCode = TextEditingController();
  bool loading = false;
  bool otp = false;
  @override
  Widget build(BuildContext context) {
    pinCode = TextEditingController();
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
                    height: 50,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close)),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Verify Mobile",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Container(
                          height: 50,

                          // color: Colors.green,
                          child: TextField(
                            controller: mobile,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: "Enter your mobile number"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {
                            if (mobile.text.length != 0) {
                              setState(() {
                                loading = true;
                              });
                              Map response = await postApi(
                                  "api/register/initiate",
                                  {"email": email.text, "mobile": mobile.text},
                                  {});
                              if (response["code"] == null) {
                                Get.snackbar(
                                    "Email Address or Mobile Number is already used",
                                    "",
                                    snackPosition: SnackPosition.BOTTOM);
                              } else {
                                Get.snackbar(response["message"], "",
                                    snackPosition: SnackPosition.BOTTOM);
                              }
                              setState(() {
                                otp = true;

                                loading = false;
                              });
                            } else {
                              Get.snackbar("Please Enter Mobile No.", "",
                                  snackPosition: SnackPosition.BOTTOM);
                            }
                          },
                          child: Container(
                              height: 50,
                              // width: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                              child: Center(child: Text("  Get OTP  "))),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  otp == false
                      ? Container()
                      : Column(
                          children: [
                            Text(
                              "Enter the verification OTP received",
                              style: TextStyle(color: Color(0XFF1A1C6C)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            PinCodeFields(
                              length: 6,
                              controller: pinCode,
                              keyboardType: TextInputType.number,
                              onComplete: (result) {},
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                "Didn’t receive?",
                                style: TextStyle(color: Color(0XFF1A1C6C)),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: InkWell(
                                onTap: () async {
                                  setState(() {
                                    loading = true;
                                  });
                                  Map response = await postApi(
                                      "api/verify-otp", {
                                    "otp": pinCode.text,
                                    "mobile": mobile.text
                                  }, {});

                                  if (response["code"] == 200) {
                                    Get.snackbar(
                                        response["message"].toString(), "",
                                        snackPosition: SnackPosition.BOTTOM);
                                    user = response["user"];
                                    apiToken = response["api_token"];
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return MainSignUp();
                                    }));
                                  } else {
                                    Get.snackbar(
                                        response["message"].toString(), "",
                                        snackPosition: SnackPosition.BOTTOM);
                                  }
                                  setState(() {
                                    loading = false;
                                  });
                                },
                                child: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0XFFFFDEB0)),
                                    child: Icon(Icons.arrow_forward_ios)),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
      ),
    );
  }
}
