import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:BackgroundTest/helper/apiHelper.dart';
import 'package:BackgroundTest/modals/global.dart';
import 'package:BackgroundTest/screens/newPassword.dart';
import 'package:BackgroundTest/screens/resetPassword.dart';

class MainSignUp extends StatefulWidget {
  const MainSignUp({Key key}) : super(key: key);

  @override
  _MainSignUpState createState() => _MainSignUpState();
}

class _MainSignUpState extends State<MainSignUp> {
  bool click = true;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
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
                    "Lets get started",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 50,
                    // color: Colors.green,
                    child: TextField(
                      controller: fname,
                      decoration: InputDecoration(hintText: "First Name"),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 50,
                    // color: Colors.green,
                    child: TextField(
                      controller: mname,
                      decoration: InputDecoration(hintText: "Middle Name"),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 50,
                    // color: Colors.green,
                    child: TextField(
                      controller: lname,
                      decoration: InputDecoration(hintText: "Last Name"),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Gender",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              click = true;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: click == false
                                    ? Color(0XFFFFFFFF)
                                    : Color(0XFFFFCEB6),
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.black)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.masks_outlined),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text("Male"),
                                  SizedBox(
                                    width: 15,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              click = false;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: click == true
                                    ? Color(0XFFFFFFFF)
                                    : Color(0XFFFFCEB6),
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.black)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.fiber_smart_record_outlined),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text("Female"),
                                  SizedBox(
                                    width: 15,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: 50,
                  // ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: () async {
                        print(apiToken);
                        if (fname.text.length == 0 || lname.text.length == 0) {
                          Get.snackbar(
                              "All Fields are Mandatory except Middle Name", "",
                              snackPosition: SnackPosition.BOTTOM);
                        } else {
                          loading = true;
                          setState(() {});
                          Map response = await postApi("api/profile", {
                            "first_name": fname.text,
                            "last_name": lname.text,
                            "middle_name": mname.text,
                            "gender": click == true ? "M" : "F"
                          }, {
                            'Authorization': 'Bearer ${apiToken.toString()}',
                          });
                          if (response["code"] == 200) {
                            Get.snackbar(response["message"].toString(), "",
                                snackPosition: SnackPosition.BOTTOM);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return NewPassword(
                                reset: false,
                              );
                            }));
                          }
                          setState(() {
                            loading = false;
                          });
                        }
                      },
                      child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Color(0XFFFFDEB0)),
                          child: Icon(Icons.arrow_forward_ios)),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
