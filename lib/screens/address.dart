import 'package:BackgroundTest/helper/apiHelper.dart';
import 'package:BackgroundTest/modals/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'fatca.dart';

class Address extends StatefulWidget {
  const Address({Key key}) : super(key: key);

  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController address3 = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController pinCode = TextEditingController();
  String id = "AN";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                      "Your communication address",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.red,
                      size: 8,
                    ),
                    Container(
                      height: 50,
                      // color: Colors.green,
                      child: TextField(
                        controller: address1,
                        decoration: InputDecoration(
                          hintText: "Address 1",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 50,
                      // color: Colors.green,
                      child: TextField(
                        controller: address2,
                        decoration: InputDecoration(
                          hintText: "Address 2",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 50,
                      // color: Colors.green,
                      child: TextField(
                        controller: address3,
                        decoration: InputDecoration(hintText: "Address 3"),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.red,
                      size: 8,
                    ),
                    Container(
                      height: 50,
                      // color: Colors.green,
                      child: TextField(
                        controller: city,
                        decoration: InputDecoration(
                          hintText: "City",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.red,
                      size: 8,
                    ),
                    DropdownButton(
                      value: id,
                      items: [
                        {"name": "Andaman & Nicobar", "id": "AN"},
                        {"name": "Arunachal Pradesh", "id": "AR"},
                        {"name": "Andhra Pradesh", "id": "AP"},
                        {"name": "Assam", "id": "AS"},
                        {"name": "Bihar", "id": "BH"},
                        {"name": "Chandigarh", "id": "CH"},
                        {"name": "Chhattisgarh", "id": "CG"},
                        {"name": "GOA", "id": "GO"},
                        {"name": "Gujarat", "id": "GU"},
                        {"name": "Haryana", "id": "HA"},
                        {"name": "Himachal Pradesh", "id": "HP"},
                        {"name": "Jammu & Kashmir", "id": "JM"},
                        {"name": "Jharkhand", "id": "JK"},
                        {"name": "Karnataka", "id": "KA"},
                        {"name": "Kerala", "id": "KE"},
                        {"name": "Madhya Pradesh", "id": "MP"},
                        {"name": "Maharashtra", "id": "MA"},
                        {"name": "Manipur", "id": "MN"},
                        {"name": "Meghalaya", "id": "ME"},
                        {"name": "Mizoram", "id": "MI"},
                        {"name": "Nagaland", "id": "NA"},
                        {"name": "New Delhi", "id": "ND"},
                        {"name": "Orissa", "id": "OR"},
                        {"name": "Pondicherry", "id": "PO"},
                        {"name": "Punjab", "id": "PU"},
                        {"name": "Rajasthan", "id": "RA"},
                        {"name": "Sikkim", "id": "SI"},
                        {"name": "Telengana", "id": "TG"},
                        {"name": "Tamil Nadu", "id": "TN"},
                        {"name": "Tripura", "id": "TR"},
                        {"name": "Uttar Pradesh", "id": "UP"},
                        {"name": "Uttaranchal", "id": "UC"},
                        {"name": "West Bengal", "id": "WB"},
                        {"name": "Dadra and Nagar Haveli", "id": "DN"},
                        {"name": "Daman and Diu", "id": "DD"},
                        {"name": "Lakshadweep", "id": "LD"},
                        {"name": "Others", "id": "OH"}
                      ]
                          .map((e) => DropdownMenuItem(
                                child: Text(e["name"].toString()),
                                value: e["id"],
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          id = value.toString();
                        });
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.red,
                      size: 8,
                    ),
                    Container(
                      height: 50,
                      // color: Colors.green,
                      child: TextField(
                        controller: pinCode,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Pin Code",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () async {
                          if (address1.text.length == 0 ||
                              city.text.length == 0 ||
                              id.length == 0 ||
                              pinCode.text.length == 0) {
                            Get.snackbar("All * Fields Are Mandatory", "",
                                snackPosition: SnackPosition.BOTTOM);
                          } else {
                            setState(() {
                              loading = true;
                            });
                            Map response =
                                await postApi("api/ucc-registration/address", {
                              "address_1": address1.text,
                              "city": city.text,
                              "pincode": pinCode.text,
                              "state": id,
                              "address_2":
                                  address2.text == "" ? "" : address2.text,
                              "address_3":
                                  address3.text == "" ? "" : address3.text,
                            }, {
                              'Authorization': 'Bearer ${apiToken.toString()}',
                            });
                            print(response);
                            if (response["code"] == 200) {
                              Get.snackbar(response["message"], "",
                                  snackPosition: SnackPosition.BOTTOM);
                              Get.to(Fatca());
                            } else {
                              Get.snackbar(response["message"], "",
                                  snackPosition: SnackPosition.BOTTOM);
                            }
                            setState(() {
                              loading = false;
                            });
                          }
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) {
                          //   return Fatca();
                          // }));
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
