import 'package:BackgroundTest/screens/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:BackgroundTest/helper/apiHelper.dart';
import 'package:BackgroundTest/modals/global.dart';
import 'package:BackgroundTest/screens/mandate1.dart';

import 'webView.dart';

class HomeFinal extends StatefulWidget {
  const HomeFinal({Key key}) : super(key: key);

  @override
  _HomeFinalState createState() => _HomeFinalState();
}

class _HomeFinalState extends State<HomeFinal> {
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
  bool loading = false;
  @override
  void initState() {
    // getData();
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
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
                                  width: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(UserProfile());
                                  },
                                  child: Container(
                                      decoration:
                                          BoxDecoration(shape: BoxShape.circle),
                                      height: 50,
                                      width: 50,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          child: user["avatar"] == null
                                              ? Icon(
                                                  Icons.supervised_user_circle,
                                                  size: 30,
                                                  color: Color(0XFFFFDEB0))
                                              : Image.network(
                                                  user["avatar"],
                                                ))),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
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
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Column(
                                            children: [
                                              Spacer(),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Total Portfolio",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                    ),
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
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Spacer(),
                                            ],
                                          ),

                                          Expanded(
                                            child: Row(
                                              children: [
                                                Spacer(),
                                                Image.asset("assets/up.png"),
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
                                                Spacer(),
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
                                                  ),
                                                ),
                                                Text(
                                                  "₹850",
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
                                            child: Column(
                                              children: [
                                                Spacer(),
                                                Text(
                                                  "Invested\nsince\n",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Text(
                                                  "August 2021",
                                                  style: TextStyle(
                                                      fontSize: 18,
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
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Spacer(),
                                                    Text(
                                                      "XIPR\n",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    Image.asset(
                                                        "assets/info.png"),
                                                    Spacer(),
                                                  ],
                                                ),
                                                Text(
                                                  "85.50%",
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
                                        ],
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFFFDEB0),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                        child: Text(
                                      "Dashboard",
                                      style: TextStyle(
                                          color: Color(0xFF1A1C6C),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  )),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Expanded(
                                      child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFFFDEB0),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                        child: Text(
                                      "Invest More",
                                      style: TextStyle(
                                          color: Color(0xFF1A1C6C),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "Recent roundups",
                                style: TextStyle(
                                    // color: Color(0xFF1A1C6C),
                                    // fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Container(
                                      constraints:
                                          BoxConstraints(minHeight: 80),
                                      // height:showList[list.indexOf(e)] ==false? 60,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Color(0XFFFBE3E1),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 50,
                                                  child: Icon(
                                                    Icons.graphic_eq,
                                                    color: Colors.red,
                                                    size: 25,
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "UPI",
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                    Text(
                                                      '₹ ' + "100".toString(),
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    )
                                                  ],
                                                ),
                                                Spacer(),
                                                Text(
                                                  "₹ " + "110".toString(),
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: InkWell(
                                                      onTap: () {
                                                        // setState(() {
                                                        //   "tempList[index]['show']" =
                                                        //       !tempList[index]['show'];
                                                        // });
                                                      },
                                                      child: Icon(false == false
                                                          ? Icons
                                                              .arrow_drop_down
                                                          : Icons
                                                              .arrow_drop_up)),
                                                )
                                              ],
                                            ),
                                          ),
                                          false == false
                                              ? Container()
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Divider(),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12.0),
                                                      child: Text(
                                                        "130".toString(),
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                    )
                                                  ],
                                                )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
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
