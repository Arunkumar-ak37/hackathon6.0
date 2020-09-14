import 'package:flutter/material.dart';
import 'package:hackathon/task4.dart';
import 'package:hackathon/task_2.dart';
import 'package:hackathon/task_1.dart';
import 'package:hackathon/task_3.dart';

class Second extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "Stay Home Stay Safe",
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: Drawer(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/ppll.jpg"),
                fit: BoxFit.cover,
                colorFilter:
                    ColorFilter.mode(Colors.white54, BlendMode.saturation))),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            SizedBox(
              height: 0.0,
            ),
            SizedBox(
              height: 0.0,
            ),
            Container(
              height: 580,
              width: 110,
              child: ListView(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("images/contactss.jpg"),
                                  fit: BoxFit.cover),
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              )),
                          height: 180,
                          width: 360,
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 10,
                                right: 10,
                                child: Container(
                                  height: 40,
                                  width: 170,
                                  decoration: BoxDecoration(
                                      color: Colors.purple[300],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15.0),
                                      )),
                                  child: FlatButton(
                                    onPressed: () {
                                      return Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Contact(),
                                          ));
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.call,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "Contact/Helpline",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0.0,
                                right: 0.0,
                                left: 0.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("images/nodi.jpg"),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              )),
                          height: 180,
                          width: 360,
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 10,
                                right: 10,
                                child: Container(
                                  height: 40,
                                  width: 205,
                                  decoration: BoxDecoration(
                                      color: Colors.teal,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15.0),
                                      )),
                                  child: FlatButton(
                                    onPressed: () {
                                      return Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Nodi(),
                                          ));
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.notifications,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "Notification & Advisory",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0.0,
                                right: 0.0,
                                left: 0.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("images/hosp.PNG"),
                                  fit: BoxFit.cover),
                              color: Colors.red[100],
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              )),
                          height: 180,
                          width: 360,
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 10,
                                right: 10,
                                child: Container(
                                  height: 40,
                                  width: 190,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15.0),
                                      )),
                                  child: FlatButton(
                                    onPressed: () {
                                      return Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Tabl(),
                                          ));
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.local_hospital,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "Hospital Dashboards",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0.0,
                                right: 0.0,
                                left: 0.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("images/graph.jpg"),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              )),
                          height: 180,
                          width: 360,
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 10,
                                right: 10,
                                child: Container(
                                  height: 40,
                                  width: 110,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15.0),
                                      )),
                                  child: FlatButton(
                                    onPressed: () {
                                      return Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Graphh(),
                                          ));
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.pie_chart,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "Graph",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0.0,
                                right: 0.0,
                                left: 0.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
