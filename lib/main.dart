import 'package:flutter/material.dart';
import 'package:hackathon/home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 70,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 240,
                height: 200,
                child: Column(
                  children: [
                    Text(
                      'COVID-19',
                      style: TextStyle(
                          fontFamily: "sans-seri",
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                    Text(
                      '(UPDATES)',
                      style: TextStyle(
                          fontFamily: "sans-seri",
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 140,
            left: 80,
            child: Container(
              width: 450,
              height: 450,
              child: Image.asset(
                "images/covid1.png",
                fit: BoxFit.fill,
                width: 100,
                height: 100,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 20,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () {
                  return Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Second(),
                      ));
                },
                child: Container(
                  height: 60,
                  width: 350,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(55)),
                      color: Colors.redAccent),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Learn more ",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                        Icon(
                          Icons.arrow_right,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
