import 'package:flutter/material.dart';

class OneTime2 extends StatefulWidget {
  const OneTime2({Key key}) : super(key: key);

  @override
  _OneTime2State createState() => _OneTime2State();
}

class _OneTime2State extends State<OneTime2> {
  List<bool> b = [false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                "Payment method",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  b[0] = !b[0];
                });
              },
              child: Container(
                constraints: BoxConstraints(minHeight: 70),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFFFBE3E1)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 50,
                            width: 80,
                            child: Image.network(
                                "https://i0.wp.com/financebuddha.com/blog/wp-content/uploads/2016/12/23155635/UPI1.jpg?fit=945%2C709&ssl=1"),
                          ),
                          Text(
                            "UPI",
                            style: TextStyle(fontSize: 18),
                          ),
                          Spacer(),
                          Text(
                            "₹5000",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      b[0] == false
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Divider(
                                    thickness: 3,
                                  ),
                                  Text(
                                      "You’ll receive a notification ou’ll receive a notification ou’ll receive a notification on your UPI app to make the payment"),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: Color(0xFF77E6B6),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Select upi id"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 15,
                                        height: 15,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFF77E6B6),
                                        ),
                                      ),
                                      Text("  asishkdas94@ybl")
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextField(
                                    decoration: InputDecoration(
                                        hintText: "Enter new upi id"),
                                  )
                                ],
                              ),
                            )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  b[1] = !b[1];
                });
              },
              child: Container(
                constraints: BoxConstraints(minHeight: 70),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFFFBE3E1)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 50,
                            width: 80,
                            child: Image.network(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMLwZnVlFK-0njFJuJ95wrbxanZBcKIKl0kQ&usqp=CAU"),
                          ),
                          Text(
                            "Netbanking",
                            style: TextStyle(fontSize: 18),
                          ),
                          Spacer(),
                          Text(
                            "₹5000",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      b[1] == false
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Divider(
                                    thickness: 3,
                                  ),
                                  Container(
                                    height: 40,
                                    child: Text(
                                      "Use your netbanking credentials to make the payment",
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    // height: 30,
                                    decoration: BoxDecoration(
                                        color: Color(0xFF77E6B6),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "pay only from your xxxx6711 account",
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  // Row(
                                  //   children: [
                                  //     Container(
                                  //       width: 15,
                                  //       height: 15,
                                  //       decoration: BoxDecoration(
                                  //         shape: BoxShape.circle,
                                  //         color: Color(0xFF77E6B6),
                                  //       ),
                                  //     ),
                                  //     Text("  asishkdas94@ybl")
                                  //   ],
                                  // ),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  // TextField(
                                  //   decoration: InputDecoration(
                                  //       hintText: "Enter new upi id"),
                                  // )
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return OneTime2();
                  }));
                },
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xFFFFDEB0)),
                  child: Center(
                      child: Text(
                    "Confirm",
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
