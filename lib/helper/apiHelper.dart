import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String baseUrl = "https://test.getnumbr.com/";

Future postApi(String url, Map body, Map<String, String> header) async {
  var response = await http
      .post(Uri.parse(baseUrl + url), headers: header, body: body)
      .catchError((e) {
    return "{'message':'Error comming from API'}";
  });
  print(response.body);
  return jsonDecode(response.body);
}

Future getApi(String url, Map<String, String> header) async {
  var response =
      await http.get(Uri.parse(baseUrl + url), headers: header).catchError((e) {
    return "{'message':'Error comming from API'}";
  });
  return jsonDecode(response.body);
}
