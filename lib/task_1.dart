import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

Helpline helplinefromjson(String str) => Helpline.fromJson(json.decode(str));

class Helpline {
  bool success;
  Data data;
  String lastRefreshed;
  String lastOriginUpdate;

  Helpline(
      {this.success, this.data, this.lastRefreshed, this.lastOriginUpdate});

  Helpline.fromJson(Map<String, dynamic> json) {
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
  Contacts contacts;

  Data({this.contacts});

  Data.fromJson(Map<String, dynamic> json) {
    contacts = json['contacts'] != null
        ? new Contacts.fromJson(json['contacts'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.contacts != null) {
      data['contacts'] = this.contacts.toJson();
    }
    return data;
  }
}

class Contacts {
  Primary primary;
  List<Regional> regional;

  Contacts({this.primary, this.regional});

  Contacts.fromJson(Map<String, dynamic> json) {
    primary =
        json['primary'] != null ? new Primary.fromJson(json['primary']) : null;
    if (json['regional'] != null) {
      regional = new List<Regional>();
      json['regional'].forEach((v) {
        regional.add(new Regional.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.primary != null) {
      data['primary'] = this.primary.toJson();
    }
    if (this.regional != null) {
      data['regional'] = this.regional.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Primary {
  String number;
  String numberTollfree;
  String email;
  String twitter;
  String facebook;
  List<String> media;

  Primary(
      {this.number,
      this.numberTollfree,
      this.email,
      this.twitter,
      this.facebook,
      this.media});

  Primary.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    numberTollfree = json['number-tollfree'];
    email = json['email'];
    twitter = json['twitter'];
    facebook = json['facebook'];
    media = json['media'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['number-tollfree'] = this.numberTollfree;
    data['email'] = this.email;
    data['twitter'] = this.twitter;
    data['facebook'] = this.facebook;
    data['media'] = this.media;
    return data;
  }
}

class Regional {
  String loc;
  String number;

  Regional({this.loc, this.number});

  Regional.fromJson(Map<String, dynamic> json) {
    loc = json['loc'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loc'] = this.loc;
    data['number'] = this.number;
    return data;
  }
}

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  String loc;
  String number;
  TextEditingController state = new TextEditingController();
  Future<Helpline> fetchUpdate() async {
    http.Client client = http.Client();
    final jsonString =
        await client.get('https://api.rootnet.in/covid19-in/contacts');

    final http.Response response = http.Response(jsonString.body, 200);
    Helpline data = helplinefromjson(response.body);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context)),
          title: Center(
            child: Row(
              children: [Icon(Icons.call), Text(" - Contact/Helpline")],
            ),
          ),
        ),
        backgroundColor: Colors.blue[200],
        body: SingleChildScrollView(
          child: Column(
            children: [
              Top(),
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
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_city,
                            size: 25,
                          ),
                          Text(
                            " State Name",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.dialpad,
                            size: 25,
                          ),
                          Text(" Number",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 20))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 400,
                width: 380,
                child: FutureBuilder(
                  future: fetchUpdate(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Center(child: CircularProgressIndicator());

                    return Statedata(
                      regionalcontacts: snapshot.data.data.contacts.regional,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: FutureBuilder(
                      future: fetchUpdate(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData)
                          return Center(child: CircularProgressIndicator());
                        return Otherdata(
                          email: snapshot.data.data.contacts.primary.email,
                          number: snapshot.data.data.contacts.primary.number,
                          twitter: snapshot.data.data.contacts.primary.twitter,
                          facebook:
                              snapshot.data.data.contacts.primary.facebook,
                        );
                      }),
                ),
              )
            ],
          ),
        ));
  }
}

class Top extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/contactss.jpg"), fit: BoxFit.cover)),
    );
  }
}

class Otherdata extends StatelessWidget {
  final String email;
  final String number;
  final String twitter;
  final String facebook;

  const Otherdata({
    Key key,
    this.email,
    this.number,
    this.twitter,
    this.facebook,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
            onTap: () {
              launch(facebook);
            },
            child: Container(
              height: 150,
              width: 100,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/fbpng.png"),
                      fit: BoxFit.contain)),
            )),
        InkWell(
            onTap: () {
              launch(twitter);
            },
            child: Container(
              height: 150,
              width: 100,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/twitter.png"),
                      fit: BoxFit.contain)),
            )),
        InkWell(
            onTap: () {
              String mail = "mailto:" + email;
              launch(mail);
            },
            child: Container(
              height: 120,
              width: 80,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/maill.png"),
                      fit: BoxFit.contain)),
            )),
      ],
    );
  }
}

class Statedata extends StatelessWidget {
  final List<Regional> regionalcontacts;

  const Statedata({
    Key key,
    this.regionalcontacts,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: regionalcontacts.length,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.all(2.0),
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
                        regionalcontacts[index].loc,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      )),
                      Column(
                        children: [
                          InkWell(
                              onTap: () {
                                String phno =
                                    "tel:" + regionalcontacts[index].number;
                                launch(phno);
                              },
                              child: Container(
                                  width: 115.5,
                                  child: Text(
                                    regionalcontacts[index].number,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ))),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
