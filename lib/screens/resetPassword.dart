import 'package:flutter/material.dart';
import 'package:BackgroundTest/screens/newPassword.dart';
import 'package:BackgroundTest/screens/passwordReset.dart';
import 'package:BackgroundTest/screens/setPassword.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({
    Key key,
  }) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController pinCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
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
                  size: 40,
                )),
            SizedBox(
              height: 100,
            ),
            Text(
              "Reset Password",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Text("Enter the code you received via email"),
            SizedBox(
              height: 25,
            ),
            PinCodeFields(
              length: 4,
              controller: pinCode,
              // focusNode: focusNode,
              onComplete: (result) {
                // Your logic with code
                print(result);
              },
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              "Didn’t receive? Resend",
              style: TextStyle(color: Color(0XFF1A1C6C)),
            ),
            SizedBox(
              height: 25,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return NewPassword(
                      reset: true,
                    );
                  }));
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
