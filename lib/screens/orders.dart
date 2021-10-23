import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({Key key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List data = [1, 2, 3, 3];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios,
                              size: 30, color: Color(0xFF1A1C6C))),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "Orders",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 27),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "27 AUG",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            "TOTAL 11",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: InkWell(
                                          onTap: () {
                                            // setState(() {
                                            //   e['show'] = !e['show'];
                                            // });
                                          },
                                          child: Icon(true == false
                                              ? Icons.arrow_drop_down
                                              : Icons.arrow_drop_up)),
                                    )
                                  ],
                                ),
                              ),
                              true == false
                                  ? Container()
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Divider(),
                                        Column(
                                          children: data.map((e) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            3,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        color: Color(0XFF77E6B6)
                                                            .withOpacity(0.65)),
                                                    child: Center(
                                                      child: Text(
                                                        "25 Aug 12:30 PM",
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "Payment made via UPI",
                                                    style:
                                                        TextStyle(fontSize: 14),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
