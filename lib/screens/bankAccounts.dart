import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:BackgroundTest/helper/apiHelper.dart';
import 'package:BackgroundTest/modals/global.dart';
import 'package:BackgroundTest/screens/address.dart';

class BankAccounts extends StatefulWidget {
  const BankAccounts({Key key}) : super(key: key);

  @override
  _BankAccountsState createState() => _BankAccountsState();
}

class _BankAccountsState extends State<BankAccounts> {
  TextEditingController accountNo = TextEditingController();
  TextEditingController ifsc = TextEditingController();

  bool loading = false;

  TextEditingController aNames = TextEditingController();
  List<String> accountNames = ["Savings Bank", "Current Bank"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading == true
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
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
                      "Let’s connect your bank account",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 50,
                      // color: Colors.green,
                      child: TextField(
                        controller: accountNo,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(hintText: "Account No."),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 50,
                      // color: Colors.green,
                      child: TextField(
                        controller: ifsc,
                        decoration: InputDecoration(hintText: "IFSC Code"),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    // Text("Account type"),
                    Container(
                      // height: 60,
                      width: double.infinity,
                      child: DropDownField(
                        value: aNames.text,
                        labelText: 'Account type',
                        icon: Icon(Icons.account_balance),
                        items: accountNames,
                        onValueChanged: (v) {
                          aNames.text = v;
                        },
                        enabled: true,
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () async {
                          if (aNames.text.length == 0 ||
                              accountNo.text.length == 0 ||
                              ifsc.text.length == 0) {
                            Get.snackbar("All Fields Are Mandatory", "",
                                snackPosition: SnackPosition.BOTTOM);
                          } else {
                            setState(() {
                              loading = true;
                            });
                            Map response = await postApi(
                                "api/ucc-registration/bank-details", {
                              "account_type":
                                  aNames.text == "Savings Bank" ? "SB" : "CB",
                              "account_number": accountNo.text,
                              "ifsc_code": ifsc.text
                            }, {
                              'Authorization': 'Bearer ${apiToken.toString()}',
                            });
                            print(response);
                            if (response["code"] == 200) {
                              Get.snackbar(response["message"], "",
                                  snackPosition: SnackPosition.BOTTOM);
                              Get.to(Address());
                            } else {
                              Get.snackbar(response["message"], "",
                                  snackPosition: SnackPosition.BOTTOM);
                            }
                            setState(() {
                              loading = false;
                            });
                          }
                        },
                        child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0XFFFFDEB0)),
                            child: Icon(Icons.arrow_forward_ios)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
