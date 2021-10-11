import 'package:flutter/widgets.dart';

TextEditingController email = TextEditingController();
TextEditingController mobile = TextEditingController();
TextEditingController fname = TextEditingController();
TextEditingController mname = TextEditingController();
TextEditingController lname = TextEditingController();
Map user = Map();
String apiToken = "MWNFaUdTazdSbm1jVmdZVEVPS2Y1ZzVOZThYRWZTVFp2d0VVczNDbw==";
// String apiToken = "RXIyREVGTDh1WFZjVkpUZXlzR3ZiS1Z2QkFoVWhoaXc2cmVWNWg5Rw==";
String passwordHash = "";
String mandateId = "";
String webViewUrl = "";
/*

{code: 200, message: Login successful, user: {id: 50, first_name: Raghav, middle_name: , last_name: Garg, email: raghavgarg.18gcebit117@galgotiacollege.edu, gender: M, avatar: null, client_code: N50, dob: null, mobile: 9045396299, otp_verified: 1, active: 1, 
created_at: 2021-09-20T11:22:53.000000Z, updated_at: 2021-09-20T11:25:27.000000Z, kyc_verified: 0}}

*/