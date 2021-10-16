import 'package:BackgroundTest/modals/global.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User Profile",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Color(0XFF1F2A4B),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            showData(
                context,
                "Name(as on PAN Card)",
                user["first_name"] +
                    " " +
                    user["middle_name"] +
                    user["last_name"]),
            SizedBox(
              height: 30,
            ),
            showData(context, "Date Of Birth", user["dob"]),
            SizedBox(
              height: 30,
            ),
            showData(context, "Mobile Number", user["mobile"]),
            SizedBox(
              height: 30,
            ),
            showData(context, "Email", user["email"]),
            SizedBox(
              height: 30,
            ),
            showData(context, "Gender", user["gender"]),
            SizedBox(
              height: 30,
            ),
            showData(context, "Unique Client Code", user["client_code"]),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget showData(context, String name, String ans) {
    return Container(
      // height: 60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Text(ans),
          SizedBox(
            height: 5,
          ),
          Divider(),
        ],
      ),
    );
  }
}
