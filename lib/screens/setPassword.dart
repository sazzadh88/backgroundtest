import 'package:flutter/material.dart';
// import 'screens/resetPassword.dart';
import 'resetPassword.dart';

class SetPassword extends StatefulWidget {
  const SetPassword({Key key}) : super(key: key);

  @override
  _SetPasswordState createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
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
              "Set Password",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Text(
                '''To set your new password we first need to send you a verification code. Please select how you would like to receive this code.'''),
            SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ResetPassword();
                }));
              },
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                    color: Color(0XFFB1FAE5),
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: Text(
                    "Sms on **********62",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
            ),
            Container(
              child: Center(
                child: Text(
                  "OR",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              height: 60,
            ),
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                  color: Color(0XFFB1FAE5),
                  borderRadius: BorderRadius.circular(15)),
              child: Center(
                child: Text(
                  "Email on getbever@gmail.com",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
