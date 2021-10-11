import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:BackgroundTest/helper/apiHelper.dart';
import 'package:BackgroundTest/modals/global.dart';
import 'package:BackgroundTest/screens/home.dart';
import 'package:BackgroundTest/screens/signUp.dart';

class WebV extends StatefulWidget {
  @override
  _WebV createState() => _WebV();
}

class _WebV extends State<WebV> {
  ScrollController termsandConditionScrollController =
      new ScrollController(); //controller maintain the status of dialog scrolling,
  bool termsAndConditionReadtoEnd = false; //flag to see user read all content
  int lastHighValue = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          InAppWebView(
              initialUrl: webViewUrl,
              onLoadStart: (controller, urlS) async {
                var url = Uri.parse(urlS);
                if (url.queryParameters['status'] == 'success' &&
                    url.queryParameters['message'] ==
                        'Authentication Success') {
                  Map response = await postApi("api/mandate-status-check", {}, {
                    'Authorization': 'Bearer ${apiToken.toString()}',
                  });
                  print(response);

                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return Home();
                  }));
                }
                setState(() {
                  _isLoading = true;
                });
              },
              onLoadStop: (controller, url) {
                setState(() {
                  _isLoading = false;
                });
              },
              onScrollChanged: (controller, x, y) {
                if (lastHighValue < y) {
                  setState(() {
                    lastHighValue = y;
                  });
                }
                if (lastHighValue > 0 && lastHighValue <= y) {
                  //condition if for user reached to end of content
                  this.setState(() {
                    termsAndConditionReadtoEnd = true;
                  });
                }
              }),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(Color(0xff256958)),
                  ),
                )
              : SizedBox(),
        ],
      ),
    ));
  }
}
