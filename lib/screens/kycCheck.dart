import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:BackgroundTest/helper/apiHelper.dart';
import 'package:BackgroundTest/main.dart';
import 'package:BackgroundTest/modals/global.dart';
import 'package:BackgroundTest/screens/bankAccounts.dart';

class Kyc extends StatefulWidget {
  const Kyc({Key key}) : super(key: key);

  @override
  _KycState createState() => _KycState();
}

class _KycState extends State<Kyc> {
  TextEditingController pan = TextEditingController();
  TextEditingController dob = TextEditingController();
  bool kyc = false;
  bool loading = false;
  DateTime date;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: kyc == true
          ? Center(child: Image.asset("assets/kyc.gif"))
          : loading == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
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
                        "Let’s check if you’re investment ready",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 50,
                        // color: Colors.green,
                        child: TextField(
                          controller: pan,
                          decoration: InputDecoration(hintText: "PAN"),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      InkWell(
                        onTap: () async {
                          date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1800),
                              lastDate: DateTime.now());
                          if (date != null) {
                            dob.text = date.year.toString() +
                                "-" +
                                date.month.toString() +
                                "-" +
                                date.day.toString();
                            setState(() {});
                          }
                        },
                        child: Container(
                          height: 30,
                          width: double.infinity,
                          decoration: BoxDecoration(),
                          // color: Colors.green,
                          child: Text(
                            dob.text == "" ? "Enter DOB" : dob.text,
                          ),
                        ),
                      ),
                      Divider(
                        // thickness: 1,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () async {
                            if (pan.text.length != 0 || date != null) {
                              setState(() {
                                loading = true;
                              });
                              Map response = await postApi("api/check-kyc", {
                                "pan": pan.text,
                                "dob": date.year.toString() +
                                    "-" +
                                    date.month.toString() +
                                    "-" +
                                    date.day.toString()
                              }, {
                                'Authorization':
                                    'Bearer ${apiToken.toString()}',
                              });
                              print(response);
                              setState(() {
                                loading = false;
                              });
                              if (response["code"] == null) {
                                Get.snackbar(response["message"], "",
                                    snackPosition: SnackPosition.BOTTOM);
                              } else if (response["code"] == 401) {
                                Get.snackbar("Kyc is not Verified", "",
                                    snackPosition: SnackPosition.BOTTOM);
                              } else if (response["code"] == 200) {
                                Get.snackbar(response["message"], "",
                                    snackPosition: SnackPosition.BOTTOM);
                                setState(() {
                                  kyc = true;
                                });
                                Future.delayed(Duration(seconds: 3), () {
                                  // setState(() {
                                  kyc = false;
                                  // });
                                  Get.to(BankAccounts());
                                });
                              }
                              // else {
                              //   user = response["user"];
                              //   if (user["otp_verified"] == 0) {
                              //   } else {
                              //     if (user["active"] != 1) {
                              //       Get.snackbar(
                              //           "Your's account has been deactivated.Please contact Admin",
                              //           "",
                              //           snackPosition: SnackPosition.BOTTOM);
                              //     } else {
                              //       if (user["kyc_verified"] != 1) {
                              //         Get.to(Kyc());
                              //       } else {}
                              //     }
                              //   }
                              // }
                            } else {
                              Get.snackbar("Please Enter Credentials", "",
                                  snackPosition: SnackPosition.BOTTOM);
                            }
                          },
                          child: Container(
                            height: 60,
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0XFFFFDEB0)),
                            child: Center(
                                child: Text(
                              "Check Now",
                              style: TextStyle(
                                  color: Color(0XFF1A1C6C), fontSize: 18),
                            )),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
    );
  }
}
