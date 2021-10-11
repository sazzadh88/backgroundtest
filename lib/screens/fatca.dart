import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:BackgroundTest/helper/apiHelper.dart';
import 'package:BackgroundTest/modals/global.dart';
import 'package:BackgroundTest/screens/mandate1.dart';

class Fatca extends StatefulWidget {
  const Fatca({Key key}) : super(key: key);

  @override
  _FatcaState createState() => _FatcaState();
}

class _FatcaState extends State<Fatca> {
  List<String> profession = [
    "Business",
    "Services",
    "Professional",
    "Agriculture",
    "Retired",
    "Housewife",
    "Student",
    "Others"
  ];
  List<String> annual = [
    "Below 1 Lakh",
    "1-5 Lacs",
    "5-10 Lacs",
    "10-25 Lacs",
    "25 Lacs - 1 Cr.",
    "Above 1 Cr.",
  ];

  bool loading = false;

  TextEditingController address1 = TextEditingController();
  TextEditingController annualName = TextEditingController();
  TextEditingController professionName = TextEditingController();

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
                      "Last few details,Promise!",
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
                        controller: address1,
                        decoration: InputDecoration(hintText: "Birth Place"),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.infinity,
                      child: DropDownField(
                          value: professionName.text,
                          labelText: 'Profession',
                          onValueChanged: (v) {
                            professionName.text = v;
                          },
                          icon: Icon(Icons.account_balance),
                          items: profession,
                          setter: (dynamic newValue) {
                            professionName.text = newValue;
                            print(newValue);
                          }),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.infinity,
                      child: DropDownField(
                        value: annualName.text,
                        onValueChanged: (value) {
                          annualName.text = value;
                        },
                        labelText: 'Annual Income Range',
                        icon: Icon(Icons.account_balance),
                        items: annual,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () async {
                          if (address1.text.length == 0 ||
                              annualName.text.length == 0 ||
                              professionName.text.length == 0) {
                            Get.snackbar("All Fields Are Mandatory", "",
                                snackPosition: SnackPosition.BOTTOM);
                          } else {
                            int id2 = 31;
                            int id1 = 1;
                            int id3;
                            id1 = id1 + profession.indexOf(professionName.text);
                            id2 = id2 + annual.indexOf(annualName.text);
                            id3 = id1 == 3
                                ? 1
                                : id1 == 1
                                    ? 2
                                    : 8;
                            setState(() {
                              loading = true;
                            });

                            Map response =
                                await postApi("api/ucc-registration/fatca", {
                              "birth_place": address1.text.toString(),
                              "income_slab": id2.toString(),
                              "wealth_source": '0' + id3.toString(),
                              "occupation_code": '0' + id1.toString()
                            }, {
                              'Authorization': 'Bearer ${apiToken.toString()}',
                            });

                            print(response);
                            if (response["code"] == 200) {
                              Get.snackbar(response["message"], "",
                                  snackPosition: SnackPosition.BOTTOM);
                              Map user = response['user'];

                              var dateTime =
                                  DateTime.parse(user['dob'].toString());
                              print(dateTime.day.toString() +
                                  "/" +
                                  dateTime.month.toString() +
                                  "/" +
                                  dateTime.year.toString());
                              Map body = {
                                "client_code": user['client_code'].toString(),
                                "first_name": user['first_name'].toString(),
                                "middle_name": user['middle_name'].toString(),
                                "last_name": user['last_name'].toString(),
                                "gender": user['gender'].toString(),
                                "dob": dateTime.day.toString() +
                                    "/" +
                                    dateTime.month.toString() +
                                    "/" +
                                    dateTime.year.toString(),
                                "pan":
                                    user['kyc_detail']['pan_number'].toString(),
                                "occupation_code": user['kyc_detail']
                                        ['occupation_code']
                                    .toString(),
                                "account_type": user['kyc_detail']
                                        ['account_type_1']
                                    .toString(),
                                "account_number": user['kyc_detail']
                                        ['account_number_1']
                                    .toString(),
                                "ifsc_code":
                                    user['kyc_detail']['ifsc_1'].toString(),
                                "address_1":
                                    user['kyc_detail']['address_1'].toString(),
                                "city": user['kyc_detail']['city'].toString(),
                                "state": user['kyc_detail']['state'].toString(),
                                "pincode":
                                    user['kyc_detail']['pincode'].toString(),
                                "mobile": user['mobile'].toString(),
                                "email": user['email'].toString(),
                                "address_2": user['kyc_detail']
                                        ['occupation_code']
                                    .toString(),
                                "address_3": user['kyc_detail']
                                        ['occupation_code']
                                    .toString(),
                                "birth_place": user['fatca_data']['birth_place']
                                    .toString(),
                                "residence_country": user['fatca_data']
                                        ['residence_country']
                                    .toString(),
                                "relative_of_politically_exposed":
                                    user['fatca_data']
                                            ['relative_of_politically_exposed']
                                        .toString(),
                                "politically_exposed": user['fatca_data']
                                        ['politically_exposed']
                                    .toString(),
                                "income_slab": user['fatca_data']['income_slab']
                                    .toString(),
                                "wealth_source": user['fatca_data']
                                        ['wealth_source']
                                    .toString(),
                              };
                              print(body);

                              Map response2 =
                                  await postApi("api/ucc-registration", body, {
                                'Authorization':
                                    'Bearer ${apiToken.toString()}',
                              });
                              print(
                                  "+++++++++++++++++++++++++++++++++++++++++++++++++++++");
                              print(body);
                              if (response2["code"] == 200)
                                Get.to(Mandate1());
                              else {
                                Get.snackbar(response2["message"], "",
                                    snackPosition: SnackPosition.BOTTOM);
                              }
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
