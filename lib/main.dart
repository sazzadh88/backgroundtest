import 'dart:convert';

import 'package:BackgroundTest/helper/apiHelper.dart';
import 'package:BackgroundTest/modals/global.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms/sms.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final int helloAlarmID = 0;
  await AndroidAlarmManager.initialize();
  runApp(GetMaterialApp(
    title: "Number App",
    home: MyApp(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      textTheme: GoogleFonts.muliTextTheme(),
    ),
  ));
  await AndroidAlarmManager.periodic(
      const Duration(seconds: 1), helloAlarmID, callApi,
      rescheduleOnReboot: true);
}

void callApi() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int d = prefs.get("counter");

  if (d == null) {
    d = 0;
  }

  print("yeah++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
  var request =
      http.Request('POST', Uri.parse('http://15.206.108.249/test-background'));
  Map body = {"counter": (d + 1).toString()};

  request.body = jsonEncode(body);
  var headers = {'Content-Type': 'application/json'};
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200 || response.statusCode == 202) {
    var da = await response.stream.bytesToString();
    await prefs.setInt("counter", (d + 1));
    print(
        "yeah++++++++++++++++++++++++++++++++++++++++++++++asdfasdfasfdasf++++++++++");
    print(await prefs.get("counter"));

    print(da);
  } else {
    print("yeah---------------------------------------------");

    print(response.reasonPhrase);
  }
}

saveData() async {}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool loading = true;
  SmsQuery query = new SmsQuery();
  List<SmsMessage> messages = [];

  int index = 1;

  @override
  void initState() {
    fetchSMS();
    super.initState();
  }

  List data = [];
  List numbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  Map list = {};
  List date = [];

  fetchSMS() async {
    RegExp exp = RegExp(r"(([Ii][Nn][Rr])|([Rr][sS]))\.?\s*((\d+,?)*\.?\d*)");
    // var twodaysbefordate = DateTime.now().subtract(new Duration(days: 2));
    List<SmsMessage> tempmessages = await query.getAllSms;
    messages = tempmessages
        .where((element) =>
            element.kind == SmsMessageKind.Received &&
            (element.body.toString().toLowerCase().contains("debited") ||
                element.body.toString().toLowerCase().contains("debit") ||
                element.body.toString().toLowerCase().contains("spent")))
        .toList();

    messages.forEach((element) {
      String str = element.body.toString();
      Iterable<RegExpMatch> matches = exp.allMatches(str);

      if (matches.length > 0) {
        String s = matches.elementAt(0).group(0).toString();
        int index = -1;
        while (++index < s.length) {
          if (numbers.contains(s[index])) break;
        }

        if (index != s.length) {
          double debit = double.parse(s.substring(index).toString());
          data.add({
            'body': str,
            'show': false,
            'debit': debit,
            'roundUp': ((debit / 10 + 1).toInt() * 10),
            'invested': (((debit / 10 + 1).toInt() * 10) - debit).toPrecision(2)
          });
          if (list[element.date.day.toString() +
                  '-' +
                  element.date.month.toString() +
                  '-' +
                  element.date.year.toString()] ==
              null) {
            list[element.date.day.toString() +
                '-' +
                element.date.month.toString() +
                '-' +
                element.date.year.toString()] = [];
          }
          list[element.date.day.toString() +
                  '-' +
                  element.date.month.toString() +
                  '-' +
                  element.date.year.toString()]
              .add({
            'body': str,
            'show': false,
            'debit': debit,
            'roundUp': ((debit / 10 + 1).toInt() * 10),
            'invested': (((debit / 10 + 1).toInt() * 10) - debit).toPrecision(2)
          });
        }
      }
    });
    list.forEach((key, value) {
      double count = 0;
      value.forEach((element) {
        count += element['invested'];
      });
      date.add({'date': key, 'total': count});
    });

    loading = false;
    setState(() {});
  }

  backgroundApi() async {
    double totalRoundUps = 0;
    List transactions = [];
    List previousDateString = ("21-09-2021").split("-");
    DateTime previousDate = DateTime(int.parse(previousDateString[2]),
        int.parse(previousDateString[1]), int.parse(previousDateString[0]));

    date.forEach((element) {
      List date = element["date"].toString().split('-');
      DateTime d =
          DateTime(int.parse(date[2]), int.parse(date[1]), int.parse(date[0]));

      if (previousDate.isAfter(d) == true || previousDate == d) {
      } else {
        totalRoundUps =
            totalRoundUps + double.parse(element["total"].toString());
        list[element["date"]].forEach((e) {
          transactions.add({
            "device_transaction_date": date[2] + '-' + date[1] + '-' + date[0],
            "transaction_value": e["debit"],
            "round_up": e["invested"]
          });
        });
      }
    });

    Map<String, dynamic> body = {
      "round_up_sum": totalRoundUps.toString(),
      "transactions": (transactions)
    };

    var headers = {
      'Authorization': 'Bearer ${apiToken.toString()}',
      'Content-Type': 'application/json'
    };
    var request =
        http.Request('POST', Uri.parse(baseUrl + 'api/background-transaction'));
    request.body = jsonEncode(body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          print(await prefs.get("counter"));
          // print(jsonDecode(await prefs.get("key")).length);
        },
        child: Text("DAsf"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(21.0),
        child: loading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //!  Segment
                    SizedBox(
                      height: 60,
                    ),
                    Text(
                      "NetWorth",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "₹1,35,000",
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    //!  Segment
                    Divider(),
                    Container(
                      height: 60,
                      child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "₹3500",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text("Round-ups"),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "₹3500",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text("One-Time"),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "₹3500",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text("SIP"),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                    //!  Segment
                    SizedBox(
                      height: 30,
                    ),

                    Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                index = 1;
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              height: 40,
                              child: Center(
                                  child: Text(
                                "Roundups",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              )),
                              decoration: BoxDecoration(
                                  color: index != 1
                                      ? Colors.transparent
                                      : Color(0xFF77E6B6).withOpacity(0.65),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                index = 2;
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              height: 40,
                              child: Center(
                                  child: Text(
                                "One-Time",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              )),
                              decoration: BoxDecoration(
                                  color: index != 2
                                      ? Colors.transparent
                                      : Color(0xFF77E6B6).withOpacity(0.65),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          )
                        ],
                      ),
                    ),

                    //!  Segment

                    index == 1 ? roundUps(context) : oneTime(context)
                  ],
                ),
              ),
      ),
    );
  }

  Widget roundUps(context) {
    return Column(
      children: [
        ...List.generate(date.length, (index) {
          List tempList = list[date[index]['date'].toString()];
          return Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        date[index]['date'].toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        "TOTAL " +
                            double.parse(date[index]['total'].toString())
                                .toPrecision(2)
                                .toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              Column(children: [
                ...List.generate(
                    tempList.length,
                    (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Container(
                            constraints: BoxConstraints(minHeight: 60),
                            // height:showList[list.indexOf(e)] ==false? 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Color(0XFFFBE3E1),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
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
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "UPI",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            '₹ ' +
                                                tempList[index]['debit']
                                                    .toString(),
                                            style: TextStyle(fontSize: 18),
                                          )
                                        ],
                                      ),
                                      Spacer(),
                                      Text(
                                        "₹ " +
                                            tempList[index]['invested']
                                                .toString(),
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                tempList[index]['show'] =
                                                    !tempList[index]['show'];
                                              });
                                            },
                                            child: Icon(
                                                tempList[index]['show'] == false
                                                    ? Icons.arrow_drop_down
                                                    : Icons.arrow_drop_up)),
                                      )
                                    ],
                                  ),
                                ),
                                tempList[index]['show'] == false
                                    ? Container()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Divider(),
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Text(
                                              tempList[index]['body']
                                                  .toString(),
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          )
                                        ],
                                      )
                              ],
                            ),
                          ),
                        ))
              ]),
            ],
          );
        }),

        // SizedBox(
        //   height: 20,
        // ),
        // Container(
        //   child: Padding(
        //     padding: const EdgeInsets.all(5.0),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Text(
        //           "27 AUG",
        //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        //         ),
        //         Text(
        //           "TOTAL 11",
        //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        // Column(
        //   children: data.map((e) {
        //     return Padding(
        //       padding: const EdgeInsets.only(bottom: 8),
        //       child: Container(
        //         constraints: BoxConstraints(minHeight: 60),
        //         // height:showList[list.indexOf(e)] ==false? 60,
        //         width: double.infinity,
        //         decoration: BoxDecoration(
        //             color: Color(0XFFFBE3E1),
        //             borderRadius: BorderRadius.circular(10)),
        //         child: Column(
        //           // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //           children: [
        //             Padding(
        //               padding: const EdgeInsets.all(8.0),
        //               child: Row(
        //                 children: [
        //                   Container(
        //                     width: 50,
        //                     child: Icon(
        //                       Icons.graphic_eq,
        //                       color: Colors.red,
        //                       size: 25,
        //                     ),
        //                   ),
        //                   Column(
        //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: [
        //                       Text(
        //                         "UPI",
        //                         style: TextStyle(fontSize: 18),
        //                       ),
        //                       Text(
        //                         '₹ ' + e['debit'].toString(),
        //                         style: TextStyle(fontSize: 18),
        //                       )
        //                     ],
        //                   ),
        //                   Spacer(),
        //                   Text(
        //                     "₹ " + e['invested'].toString(),
        //                     style: TextStyle(
        //                         fontSize: 18, fontWeight: FontWeight.bold),
        //                   ),
        //                   Padding(
        //                     padding: const EdgeInsets.all(4.0),
        //                     child: InkWell(
        //                         onTap: () {
        //                           setState(() {
        //                             e['show'] = !e['show'];
        //                           });
        //                         },
        //                         child: Icon(e['show'] == false
        //                             ? Icons.arrow_drop_down
        //                             : Icons.arrow_drop_up)),
        //                   )
        //                 ],
        //               ),
        //             ),
        //             e['show'] == false
        //                 ? Container()
        //                 : Column(
        //                     crossAxisAlignment: CrossAxisAlignment.center,
        //                     children: [
        //                       Divider(),
        //                       Padding(
        //                         padding: const EdgeInsets.all(12.0),
        //                         child: Text(
        //                           e['body'].toString(),
        //                           style: TextStyle(fontSize: 12),
        //                         ),
        //                       )
        //                     ],
        //                   )
        //           ],
        //         ),
        //       ),
        //     );
        //   }).toList(),
        // )
      ],
    );
  }

  Widget oneTime(context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "27 AUG",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  "TOTAL 11",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
          ),
        ),
        Column(
          children: data.map((e) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Container(
                constraints: BoxConstraints(minHeight: 60),
                // height:showList[list.indexOf(e)] ==false? 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0XFFFBE3E1),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "UPI",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Spacer(),
                          Text(
                            "₹ 10",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: InkWell(
                                onTap: () {
                                  setState(() {
                                    e['show'] = !e['show'];
                                  });
                                },
                                child: Icon(e['show'] == false
                                    ? Icons.arrow_drop_down
                                    : Icons.arrow_drop_up)),
                          )
                        ],
                      ),
                    ),
                    e['show'] == false
                        ? Container()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Divider(),
                              Column(
                                children: data.map((e) {
                                  return Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Color(0XFF77E6B6)
                                                  .withOpacity(0.65)),
                                          child: Center(
                                            child: Text(
                                              "25 Aug 12:30 PM",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "Payment made via UPI",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              )
                            ],
                          )
                  ],
                ),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
