import 'package:flutter/material.dart';
import 'package:BackgroundTest/helper/apiHelper.dart';
import 'package:BackgroundTest/modals/global.dart';

import 'mandate2.dart';

class Mandate1 extends StatefulWidget {
  const Mandate1({Key key}) : super(key: key);

  @override
  _Mandate1State createState() => _Mandate1State();
}

class _Mandate1State extends State<Mandate1> {
  bool loading = true;
  @override
  void initState() {
    getData();
    super.initState();
  }

  int code = 0;

  getData() async {
    while (code != 200) {
      print("ueah");
      Map response = await postApi("api/mandate/generate-password", {}, {
        'Authorization': 'Bearer ${apiToken.toString()}',
      });
      code = response["code"];
      print(response);
      if (code == 200) {
        passwordHash = response["password_hash"];
      }
    }
    setState(() {
      loading = false;
    });
  }

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
                  Flexible(
                    child: Text(
                      "What’s a bank mandate?",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Text(
                    '''It’s you authorizing your bank to auto debit your account whenever you have Round-ups.

The mandate has a limit of ₹500. That’ll be enough to cover you, even if you go on a shopping spree and have lots of Round-ups.''',
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Container(
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.asset("assets/bulb.png"),
                          SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            child: Text(
                                "This is different from any of your monthly SIP mandates."),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Mandate2();
                        }));
                      },
                      child: Container(
                        height: 60,
                        width: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xFFFFDEB0)),
                        child: Center(
                            child: Text(
                          "Continue",
                          style: TextStyle(
                              color: Color(0xFF1A16C6),
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
