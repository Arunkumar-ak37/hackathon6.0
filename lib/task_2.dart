import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

Nodification nodificationfromjson(String str) =>
    Nodification.fromJson(json.decode(str));

class Nodification {
  bool success;
  Data data;
  String lastRefreshed;
  String lastOriginUpdate;

  Nodification(
      {this.success, this.data, this.lastRefreshed, this.lastOriginUpdate});

  Nodification.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    lastRefreshed = json['lastRefreshed'];
    lastOriginUpdate = json['lastOriginUpdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['lastRefreshed'] = this.lastRefreshed;
    data['lastOriginUpdate'] = this.lastOriginUpdate;
    return data;
  }
}

class Data {
  List<Notifications> notifications;

  Data({this.notifications});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      notifications = new List<Notifications>();
      json['notifications'].forEach((v) {
        notifications.add(new Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  String title;
  String link;

  Notifications({this.title, this.link});

  Notifications.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['link'] = this.link;
    return data;
  }
}

class Nodi extends StatefulWidget {
  @override
  _NodiState createState() => _NodiState();
}

class _NodiState extends State<Nodi> {
  Future<Nodification> notifi() async {
    http.Client client = http.Client();
    final jsonString =
        await client.get('https://api.rootnet.in/covid19-in/notifications');

    if (200 == jsonString.statusCode) {
      Nodification data = nodificationfromjson(jsonString.body);
      return data;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[200],
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context)),
        backgroundColor: Colors.teal,
        title: Row(
          children: [
            Icon(Icons.notifications),
            Text(" Nodification & Advisory")
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Top2(),
            SizedBox(
              height: 15,
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Icon(Icons.calendar_today),
                          Text(
                            "Date",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18.0),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Icon(Icons.notifications_active),
                          Text(
                            "Notification Title",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Icon(
                            Icons.insert_link,
                          ),
                          Text(
                            "Link",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18.0),
                          )
                        ],
                      ),
                    ),
                  ],
                )),
            Container(
                height: 400,
                width: 380,
                child: FutureBuilder(
                    future: notifi(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      } else
                        return Statedata2(
                            notifications: snapshot.data.data.notifications);
                    })),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}

class Top2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/nodi.jpg"), fit: BoxFit.cover)),
    );
  }
}

class Statedata2 extends StatelessWidget {
  final List<Notifications> notifications;
  final String date;

  const Statedata2({Key key, this.notifications, this.date}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(2.5),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        notifications[index].title.length > 9
                            ? notifications[index].title.substring(0, 10)
                            : notifications[index].title,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      width: 120,
                      child: notifications[index].title.length > 9
                          ? Text(
                              notifications[index].title.substring(10),
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            )
                          : Text(
                              notifications[index].title,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                    ),
                    Container(
                      width: 65.0,
                      child: InkWell(
                          onTap: () {
                            launch(notifications[index].link);
                          },
                          child: Text(
                            "Click here",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.blueAccent,
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.underline),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
