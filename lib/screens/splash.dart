import 'dart:async';

import 'package:flutter/material.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final controller = StoryController();

  List<Color> wallPaper = [
    Color(0xFFFFDEB0),
    Color(0xFFB1FAE5),
    Color(0xFFF4B3C8),
    Color(0xFFB1FAE5),
  ];

  StreamController stream = StreamController();
  @override
  void initState() {
    stream.add(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.width * 1.5,
            child: StoryView(
              controller: controller, // pass controller here too
              repeat: true, // should the stories be slid forever

              storyItems: [
                StoryItem.pageImage(
                    url:
                        "https://img.youtube.com/vi/yHAVCsWEKQE/maxresdefault.jpg",
                    controller: controller),
                StoryItem.pageImage(
                    url: "https://i.ibb.co/bz0R9bd/Screenshot-1584263008.png",
                    controller: controller),
              ], // To disable vertical swipe gestures, ignore this parameter.
              // Preferrably for inline story view.
            ),

            // child: Stack(
            //   children: [
            //     PageView.builder(
            //         itemCount: 4,
            //         itemBuilder: (context, index) {
            //           stream.add(index);

            //           return Stack(
            //             children: [
            //               Container(
            //                 height: MediaQuery.of(context).size.width * 1.5,
            //                 decoration: BoxDecoration(color: wallPaper[index]),
            //               ),
            //               Column(
            //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //                 crossAxisAlignment: CrossAxisAlignment.center,
            //                 children: [
            //                   Row(
            //                     children: [
            //                       Spacer(),
            //                       Container(
            //                           height: 200,
            //                           width: 150,
            //                           child: ClipRRect(
            //                               borderRadius:
            //                                   BorderRadius.circular(10),
            //                               child: Image.asset(
            //                                 "assets/Capture1.PNG",
            //                                 fit: BoxFit.cover,
            //                               ))),
            //                       SizedBox(
            //                         width: 50,
            //                       ),
            //                       Container(
            //                           height: 200,
            //                           width: 150,
            //                           child: ClipRRect(
            //                               borderRadius:
            //                                   BorderRadius.circular(10),
            //                               child: Image.asset(
            //                                 "assets/Capture2.PNG",
            //                                 fit: BoxFit.cover,
            //                               ))),
            //                       Spacer(),
            //                     ],
            //                   )
            //                 ],
            //               ),
            //             ],
            //           );
            //         }),
            //     Align(
            //       alignment: Alignment.bottomCenter,
            //       child: StreamBuilder(
            //           stream: stream.stream,
            //           builder: (context, snapshot) {
            //             return Padding(
            //               padding: const EdgeInsets.all(8.0),
            //               child: Row(
            //                   children: List.generate(4, (index) {
            //                 return Container(
            //                   height: 12,
            //                   width: 12,
            //                   padding: EdgeInsets.all(12),
            //                   margin: EdgeInsets.all(2),
            //                   decoration: BoxDecoration(
            //                       shape: BoxShape.circle,
            //                       color: snapshot.data == index
            //                           ? Colors.green
            //                           : Colors.white),
            //                 );
            //               })),
            //             );
            //           }),
            //     ),
            //   ],
            // ),
          ),
          SizedBox(height: 20),
          Center(
              child: Container(
            height: 60,
            width: MediaQuery.of(context).size.width * 0.75,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                "Create an account",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
          )),
          SizedBox(height: 10),
          Row(
            children: [
              Spacer(),
              Text(
                "Already have an account? ",
                style: TextStyle(fontSize: 19),
              ),
              Text(
                "Login",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              Spacer(),
            ],
          ),
          Spacer(),
          Text(
            "Regulated by SEBI and authorized by AMFIARN - 178038",
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
