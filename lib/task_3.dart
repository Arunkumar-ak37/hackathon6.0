import 'package:flutter/material.dart';
import 'package:hackathon/task_3a.dart';
import 'package:hackathon/task_3b.dart';

class Tabl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Newpage();
  }
}

class Newpage extends StatefulWidget {
  @override
  _NewpageState createState() => _NewpageState();
}

class _NewpageState extends State<Newpage> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context)),
        title: Row(
          children: [
            Icon(
              Icons.local_hotel,
              size: 35,
            ),
            Text(" Hospital Dashboards")
          ],
        ),
        backgroundColor: Colors.red,
        bottom: TabBar(controller: controller, tabs: <Widget>[
          Row(
            children: [
              Icon(Icons.local_hospital),
              Text(
                "  Hospital Beds",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              )
            ],
          ),
          Row(
            children: [
              Icon(Icons.school),
              Text(
                "  College Beds",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              )
            ],
          ),
        ]),
      ),
      body: TabBarView(controller: controller, children: <Widget>[
        Hospital(),
        College(),
      ]),
    );
  }
}
