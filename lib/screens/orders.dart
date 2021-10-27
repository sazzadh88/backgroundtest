import 'package:BackgroundTest/helper/apiHelper.dart';
import 'package:BackgroundTest/modals/global.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({Key key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  void initState() {
    super.initState();
    getOrders();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        getOrdersPage();
      }
    });
  }

  getOrders() async {
    Map orders = await getApi("/api/orders",
        {'accept': 'application/json', 'authorization': 'Bearer $apiToken'});
    orders['orders'].forEach((element) {
      element["show"] = false;
      data.add(element);
    });
    loading = false;
    setState(() {});
    ++page;
  }

  int page = 1;

  getOrdersPage() async {
    setState(() {
      pageLoading = true;
    });
    Map orders = await getApi("/api/orders?page=$page",
        {'accept': 'application/json', 'authorization': 'Bearer $apiToken'});
    orders['orders'].forEach((element) {
      element["show"] = false;
      data.add(element);
    });
    ++page;
    pageLoading = false;
    setState(() {});
  }

  bool pageLoading = false;

  bool loading = true;
  ScrollController controller = ScrollController();
  List data = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(18.0),
              child: SingleChildScrollView(
                controller: controller,
                child: Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        // Row(
                        //   children: [
                        //     IconButton(
                        //         onPressed: () {
                        //           Navigator.pop(context);
                        //         },
                        //         icon: Icon(Icons.arrow_back_ios,
                        //             size: 30, color: Color(0xFF1A1C6C))),
                        //     SizedBox(
                        //       width: 30,
                        //     ),
                        //     Text(
                        //       "Orders",
                        //       style: TextStyle(
                        //           fontWeight: FontWeight.bold, fontSize: 27),
                        //     )
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 30,
                        // ),
                        // Container(
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(5.0),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Text(
                        //           "27 AUG",
                        //           style: TextStyle(
                        //               fontWeight: FontWeight.bold,
                        //               fontSize: 18),
                        //         ),
                        //         Text(
                        //           "TOTAL 11",
                        //           style: TextStyle(
                        //               fontWeight: FontWeight.bold,
                        //               fontSize: 18),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
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
                                            "₹ ${e["order_amount"].toString()}",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Divider(),
                                              Column(children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              3,
                                                          height: 30,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                              color: Color(
                                                                      0XFF77E6B6)
                                                                  .withOpacity(
                                                                      0.65)),
                                                          child: Center(
                                                            child: Text(
                                                              e["order_date"],
                                                              style: TextStyle(
                                                                  fontSize: 12),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Center(
                                                          child: Text(
                                                            "Payment made via UPI",
                                                            style: TextStyle(
                                                                fontSize: 14),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              3,
                                                          height: 30,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                              color: Color(
                                                                      0XFF77E6B6)
                                                                  .withOpacity(
                                                                      0.65)),
                                                          child: Center(
                                                            child: Text(
                                                              e["is_processed"],
                                                              style: TextStyle(
                                                                  fontSize: 12),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Center(
                                                          child: Text(
                                                            "Is Processed",
                                                            style: TextStyle(
                                                                fontSize: 14),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              3,
                                                          height: 30,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                              color: Color(
                                                                      0XFF77E6B6)
                                                                  .withOpacity(
                                                                      0.65)),
                                                          child: Center(
                                                            child: Text(
                                                              e["order_id"]
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 12),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Center(
                                                          child: Text(
                                                            "Order ID",
                                                            style: TextStyle(
                                                                fontSize: 14),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ])
                                            ],
                                          )
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        pageLoading == true
                            ? Container(
                                height: 200,
                                child:
                                    Center(child: CircularProgressIndicator()))
                            : Container()
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
