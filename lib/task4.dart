import 'package:flutter/material.dart';

class Graphh extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[200],
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [Icon(Icons.pie_chart), Text(" - Graph")],
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/graph.jpg"), fit: BoxFit.cover)),
          ),
        ],
      )),
    );
  }
}
