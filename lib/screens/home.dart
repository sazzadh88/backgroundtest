import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:BackgroundTest/helper/apiHelper.dart';
import 'package:BackgroundTest/modals/global.dart';
import 'package:BackgroundTest/screens/mandate1.dart';

import 'webView.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  getData() async {
    Map response = await getApi("api/profile", {
      'Authorization': 'Bearer ${apiToken.toString()}',
    });

    print(response["user"]["mandate"]);
    mandate = response["user"]["mandate"];
    mandateId = mandate["mandate_id"];
    loading = false;
    setState(() {});
  }

  Map mandate = Map();
  bool loading = true;
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width * 0.75,
                        decoration: BoxDecoration(color: Color(0XFF1F2A4B)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 60,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 50,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Welcome Back,",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      "Asish!",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                                Spacer(),
                                Icon(
                                  Icons.notifications_none,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.25,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.width * 0.65,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFF77E6B6),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: Container(
                                      child: Row(
                                        children: [
                                          // SizedBox(
                                          //   width: 30,
                                          // ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Spacer(),
                                                Text(
                                                  "Total Portfolio",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  "₹0",
                                                  style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  "NAV as on",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Spacer(),
                                              ],
                                            ),
                                          ),
                                          // Spacer(),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Icon(Icons.arrow_upward),
                                                Text(
                                                  " 78.9%",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  " (₹96.18K)",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Expanded(child: Container())
                                          // Spacer(),
                                        ],
                                      ),
                                    )),
                                    Container(
                                        width: double.infinity,
                                        child: Image.asset(
                                          "assets/png.png",
                                          fit: BoxFit.fill,
                                        )),
                                    Expanded(
                                        child: Container(
                                      child: Row(
                                        children: [
                                          // SizedBox(
                                          //   width: 30,
                                          // ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Spacer(),
                                                Text(
                                                  "Invested\nAmount\n",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  "₹850",
                                                  style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Spacer(),
                                              ],
                                            ),
                                          ),
                                          // Spacer(),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Spacer(),
                                                Text(
                                                  "Invested\nsince\n",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  "August 2021",
                                                  style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Spacer(),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Spacer(),
                                                Text(
                                                  "XIPR\n",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  "85.50%",
                                                  style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Spacer(),
                                              ],
                                            ),
                                          ),
                                          // Spacer(),
                                        ],
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              height: 120,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Color(0XFF1F2A4B),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Start investing in 2 minutes",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 150,
                                        decoration: BoxDecoration(
                                            color: Color(0XFFFFDEB0),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                          child: Text(
                                            "Setup Account Now",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0XFF1F2A4B),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.width * 0.35,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                color: Color(0xFF222327),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "No more manual payment",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text("Enable AutoPay\nto invest Round-ups",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold)),
                                    Spacer(),

                                    // Spacer(),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.width * 0.2,
                              decoration: BoxDecoration(
                                color: Color(0XFF0F0F0F),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Spacer(),
                                        Text(
                                          "Powered By",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Image.asset("assets/npci 2.png"),
                                        Spacer(),
                                      ],
                                    ),
                                    Spacer(),
                                    mandate == null || mandate["status"] == 0
                                        ? InkWell(
                                            onTap: () async {
                                              if (mandate == null) {
                                                Get.to(Mandate1());
                                              } else {
                                                setState(() {
                                                  loading = true;
                                                });
                                                Map response = await postApi(
                                                    "api/mandate/complete", {
                                                  "mandate_id":
                                                      mandateId.toString()
                                                }, {
                                                  'Authorization':
                                                      'Bearer ${apiToken.toString()}',
                                                });
                                                int code = response["code"];

                                                print(response);
                                                if (code == 200) {
                                                  webViewUrl =
                                                      response["webview_url"];

                                                  Get.to(WebV())
                                                      .whenComplete(() {
                                                    setState(() {
                                                      loading = true;
                                                    });
                                                    getData();
                                                  });
                                                }
                                                print(response);
                                              }
                                            },
                                            child: Container(
                                              height: 50,
                                              width: 150,
                                              decoration: BoxDecoration(
                                                  color: Color(0XFF2482FE),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Center(
                                                child: Text(
                                                  "Enable AutoPay",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
