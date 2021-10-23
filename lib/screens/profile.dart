import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
              child: Column(children: [
            Column(children: [
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios)),
                  SizedBox(
                    width: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ashish Kumar Dash",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      Text(
                        "ashish@fnakl.com",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      height: 65,
                      width: double.infinity,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                              height: 40,
                              width: 40,
                              child: Image.asset("assets/transactions.png")),
                          SizedBox(
                            width: 40,
                          ),
                          Text(
                            "Transactions",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      height: 65,
                      width: double.infinity,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.account_circle,
                            size: 40,
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Text(
                            "Personal Details",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      height: 65,
                      width: double.infinity,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.account_balance,
                            size: 40,
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Text(
                            "Bank Accounts",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      height: 65,
                      width: double.infinity,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.logout,
                            size: 40,
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Text(
                            "Logout",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ])
          ]))),
    );
  }
}
