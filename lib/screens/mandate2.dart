import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:BackgroundTest/helper/apiHelper.dart';
import 'package:BackgroundTest/modals/global.dart';
import 'package:BackgroundTest/screens/mandate1.dart';
import 'package:BackgroundTest/screens/webView.dart';

class Mandate2 extends StatefulWidget {
  const Mandate2({Key key}) : super(key: key);

  @override
  _Mandate2State createState() => _Mandate2State();
}

class _Mandate2State extends State<Mandate2> {
  bool loading = true;
  @override
  void initState() {
    getData();
    // fetchData();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      --time;
      print(time);
      if (time == 0 && show == false) {
        time = 30;
        show = true;
        Get.snackbar("Wait for a second,Please don't leave...", "",
            snackPosition: SnackPosition.BOTTOM);
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  bool show = false;
  int time = 60;
  int code = 0;
  Timer timer;
  getData() async {
    print("ueah");
    print("passwordHash" + passwordHash);
    Map response = await postApi("api/mandate/initiate", {
      "pass_hash": passwordHash
    }, {
      'Authorization': 'Bearer ${apiToken.toString()}',
    });
    code = response["code"];
    print(response);
    if (code == 200) {
      mandateId = response["mandate_id"];
      print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
      print(mandateId);
      setState(() {
        loading = false;
      });
    } else {
      timer.cancel();
      Get.snackbar("Wait for a second", "",
          snackPosition: SnackPosition.BOTTOM);
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Get.to(Mandate1());
      });
    }
    // }
    setState(() {
      loading = false;
    });
  }

  fetchData() async {
    print("yeah+++++++++++++++++++++++++");
    Map response = await postApi("api/mandate/complete", {
      "mandate_id": mandateId.toString()
    }, {
      'Authorization': 'Bearer ${apiToken.toString()}',
    });
    code = response["code"];

    print(response);
    if (code == 200) {
      webViewUrl = response["webview_url"];
      timer.cancel();
      Navigator.pop(context);

      Get.to(WebV());
    }
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
                      "In the next screen",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
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
                          Image.asset("assets/bs2.png"),
                          SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            child: Text(
                                "You’ll see a Bombay Stock Exchange (BSE Star) screen"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
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
                          Image.asset("assets/digio.png"),
                          SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            child: Text(
                                "Tap the blue botton and look for an email from Digio for OTP"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
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
                          Image.network(
                              "https://upload.wikimedia.org/wikipedia/commons/a/a7/NPCI-Logo.png"),
                          SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            child: Text(
                                "Finally, log in to your bank to authorize the mandate"),
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
                      onTap: () async {
                        if (mandateId.length != 0) {
                          setState(() {
                            loading = true;
                          });
                          if (show == true) fetchData();
                          setState(() {
                            loading = false;
                          });
                          // }

                        }
                      },
                      child: Container(
                        height: 60,
                        width: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xFFFFDEB0)),
                        child: Center(
                            child: Text(
                          show == false ? "Redirecting in $time s..." : "Next",
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
