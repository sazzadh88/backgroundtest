import 'package:flutter/material.dart';

class Withdrawl extends StatefulWidget {
  const Withdrawl({Key key}) : super(key: key);

  @override
  _WithdrawlState createState() => _WithdrawlState();
}

class _WithdrawlState extends State<Withdrawl> {
  bool withdraw = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
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
            Text(
              "You can withdraw upto ₹5,520",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Withdrawing from ICICI Pru Liquid Growth",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black)),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Enter Amount"),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Checkbox(
                    value: withdraw,
                    onChanged: (value) {
                      setState(() {
                        withdraw = !withdraw;
                      });
                    }),
                Text(
                  "Withdraw all",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Exit load : Any investment made in last 6 days will have exit load upto 0.007% as set by ICICI",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0XFFFFDEB0)),
                child: Center(
                    child: Text(
                  "Confirm",
                  style: TextStyle(color: Color(0XFF1A1C6C), fontSize: 18),
                )),
              ),
            ),
            SizedBox(
              height: 150,
            ),
            Divider(
              thickness: 3,
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF77E6B6).withOpacity(0.65)),
                  child: Image.asset("assets/Vector.png")),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                  "Amount will be credited to your\nSBIxxxx6711 in 3 business days",
                  style: TextStyle(fontSize: 18)),
            )
          ],
        ),
      ),
    );
  }
}
