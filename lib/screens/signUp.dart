import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:heroicons/heroicons.dart';
import 'package:BackgroundTest/modals/global.dart';
import 'package:BackgroundTest/screens/verify.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width / 3,
            ),
            Text(
              "Hello!",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              // color: Colors.green,
              child: TextField(
                controller: email,
                decoration:
                    InputDecoration(hintText: "Please enter your email"),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: () {
                  if (email.text.length != 0)
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Verify();
                    }));
                  else {
                    Get.snackbar("Please Enter E-mail", "",
                        snackPosition: SnackPosition.BOTTOM);
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
