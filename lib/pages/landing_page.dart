import 'package:daily_news_app1/pages/home.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Column(
              children: [
                Material(
                  borderRadius: BorderRadius.circular(30.0),
                  elevation: 3.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image.asset(
                      "images/building.jpeg",
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.5,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  "News from around the\n        world for you",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                Text(
                  "Best time to read take your time to read\n            a little more or this world",
                  style: TextStyle(
                      color: Colors.black45,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 50.0),
                ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                          return Home();
                        },
                      )
                    );
                  },
                  child: Text(
                  "Get Started",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                  // child: Container(
                  //   width: MediaQuery.of(context).size.width / 1.5,
                  //   child: Material(
                  //     borderRadius: BorderRadius.circular(30.0),
                  //     elevation: 5.0,
                  //     child: Container(
                  //         padding: EdgeInsets.symmetric(vertical: 15.0),
                  //         decoration: BoxDecoration(
                  //             color: Colors.blue,
                  //             borderRadius: BorderRadius.circular(30.0)),
                  //         child: Center(
                  //             child: Text(
                  //           "Get Started",
                  //           style: TextStyle(
                  //               color: Colors.white,
                  //               fontSize: 16.0,
                  //               fontWeight: FontWeight.w500),
                  //         ))),
                  //   ),
                  // ),
                )
              ],
            )),
      ),
    );
  }
}
