import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Hospitalbed hospitalbedfromjson(String str) =>
    Hospitalbed.fromJson(json.decode(str));

class Hospitalbed {
  bool success;
  Data data;
  String lastRefreshed;
  String lastOriginUpdate;

  Hospitalbed(
      {this.success, this.data, this.lastRefreshed, this.lastOriginUpdate});

  Hospitalbed.fromJson(Map<String, dynamic> json) {
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
  Summary summary;
  List<Sources> sources;
  List<Regional> regional;

  Data({this.summary, this.sources, this.regional});

  Data.fromJson(Map<String, dynamic> json) {
    summary =
        json['summary'] != null ? new Summary.fromJson(json['summary']) : null;
    if (json['sources'] != null) {
      sources = new List<Sources>();
      json['sources'].forEach((v) {
        sources.add(new Sources.fromJson(v));
      });
    }
    if (json['regional'] != null) {
      regional = new List<Regional>();
      json['regional'].forEach((v) {
        regional.add(new Regional.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.summary != null) {
      data['summary'] = this.summary.toJson();
    }
    if (this.sources != null) {
      data['sources'] = this.sources.map((v) => v.toJson()).toList();
    }
    if (this.regional != null) {
      data['regional'] = this.regional.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Summary {
  int ruralHospitals;
  int ruralBeds;
  int urbanHospitals;
  int urbanBeds;
  int totalHospitals;
  int totalBeds;

  Summary(
      {this.ruralHospitals,
      this.ruralBeds,
      this.urbanHospitals,
      this.urbanBeds,
      this.totalHospitals,
      this.totalBeds});

  Summary.fromJson(Map<String, dynamic> json) {
    ruralHospitals = json['ruralHospitals'];
    ruralBeds = json['ruralBeds'];
    urbanHospitals = json['urbanHospitals'];
    urbanBeds = json['urbanBeds'];
    totalHospitals = json['totalHospitals'];
    totalBeds = json['totalBeds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ruralHospitals'] = this.ruralHospitals;
    data['ruralBeds'] = this.ruralBeds;
    data['urbanHospitals'] = this.urbanHospitals;
    data['urbanBeds'] = this.urbanBeds;
    data['totalHospitals'] = this.totalHospitals;
    data['totalBeds'] = this.totalBeds;
    return data;
  }
}

class Sources {
  String url;
  String lastUpdated;

  Sources({this.url, this.lastUpdated});

  Sources.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    lastUpdated = json['lastUpdated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['lastUpdated'] = this.lastUpdated;
    return data;
  }
}

class Regional {
  String state;
  int ruralHospitals;
  int ruralBeds;
  int urbanHospitals;
  int urbanBeds;
  int totalHospitals;
  int totalBeds;
  String asOn;

  Regional(
      {this.state,
      this.ruralHospitals,
      this.ruralBeds,
      this.urbanHospitals,
      this.urbanBeds,
      this.totalHospitals,
      this.totalBeds,
      this.asOn});

  Regional.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    ruralHospitals = json['ruralHospitals'];
    ruralBeds = json['ruralBeds'];
    urbanHospitals = json['urbanHospitals'];
    urbanBeds = json['urbanBeds'];
    totalHospitals = json['totalHospitals'];
    totalBeds = json['totalBeds'];
    asOn = json['asOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    data['ruralHospitals'] = this.ruralHospitals;
    data['ruralBeds'] = this.ruralBeds;
    data['urbanHospitals'] = this.urbanHospitals;
    data['urbanBeds'] = this.urbanBeds;
    data['totalHospitals'] = this.totalHospitals;
    data['totalBeds'] = this.totalBeds;
    data['asOn'] = this.asOn;
    return data;
  }
}

class Hospital extends StatefulWidget {
  @override
  _HospitalState createState() => _HospitalState();
}

class _HospitalState extends State<Hospital> {
  Future<Hospitalbed> regional() async {
    http.Client client = http.Client();
    final jsonString =
        await client.get('https://api.rootnet.in/covid19-in/hospitals/beds');

    if (200 == jsonString.statusCode) {
      Hospitalbed data = hospitalbedfromjson(jsonString.body);
      return data;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[200],
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Top3(),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      "State",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    width: 40,
                    child: Text(
                      "Rural Hospitals",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    width: 40,
                    child: Text(
                      "Rural Beds",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    width: 40,
                    child: Text(
                      "Urban Hospitals",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    width: 40,
                    child: Text(
                      "Urban Beds",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    width: 40,
                    child: Text(
                      "Total Hospitals",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    width: 40,
                    child: Text(
                      "Total Beds",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 400,
              width: 380,
              child: FutureBuilder(
                  future: regional(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else
                      return Statedata3(regional: snapshot.data.data.regional);
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                    future: regional(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      } else
                        return Total(
                          rh: snapshot.data.data.summary.ruralHospitals
                              .toString(),
                          rb: snapshot.data.data.summary.ruralBeds.toString(),
                          uh: snapshot.data.data.summary.urbanHospitals
                              .toString(),
                          ub: snapshot.data.data.summary.urbanBeds.toString(),
                          th: snapshot.data.data.summary.totalHospitals
                              .toString(),
                          tb: snapshot.data.data.summary.totalBeds.toString(),
                        );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Top3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/hoptitalbed.jpg"), fit: BoxFit.cover)),
    );
  }
}

class Statedata3 extends StatelessWidget {
  final List<Regional> regional;
  const Statedata3({
    Key key,
    this.regional,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: regional.length,
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
                        width: 60,
                        child: Text(
                          regional[index].state,
                        ),
                      ),
                      Container(
                          width: 40,
                          child:
                              Text(regional[index].ruralHospitals.toString())),
                      Container(
                        width: 50,
                        child: Text(regional[index].ruralBeds.toString()),
                      ),
                      Container(
                        width: 50,
                        child: Text(regional[index].urbanHospitals.toString()),
                      ),
                      Container(
                        width: 50,
                        child: Text(regional[index].urbanBeds.toString()),
                      ),
                      Container(
                        width: 50,
                        child: Text(regional[index].totalHospitals.toString()),
                      ),
                      Container(
                        width: 50,
                        child: Text(regional[index].totalBeds.toString()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class Total extends StatelessWidget {
  final String rh;
  final String rb;
  final String uh;
  final String ub;
  final String th;
  final String tb;

  const Total({Key key, this.rh, this.rb, this.uh, this.ub, this.th, this.tb})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                height: 80,
                width: 180,
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.local_hospital,
                        color: Colors.white60,
                        size: 30,
                      ),
                      Text(
                        "Rural Hospitals",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.white70,
                            fontStyle: FontStyle.italic),
                      ),
                      Text(
                        rh,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Colors.white70,
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.red[400],
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                height: 80,
                width: 180,
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.local_hotel,
                        color: Colors.white60,
                        size: 30,
                      ),
                      Text(
                        "Rural Beds",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.white70,
                            fontStyle: FontStyle.italic),
                      ),
                      Text(
                        rb,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Colors.white70,
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.red[400],
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                height: 80,
                width: 180,
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.local_hospital,
                        color: Colors.white60,
                        size: 30,
                      ),
                      Text(
                        "Urban Hospitals",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.white70,
                            fontStyle: FontStyle.italic),
                      ),
                      Text(
                        uh,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Colors.white70,
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.red[400],
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                height: 80,
                width: 180,
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.local_hotel,
                        color: Colors.white60,
                        size: 30,
                      ),
                      Text(
                        "Urban Beds",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.white70,
                            fontStyle: FontStyle.italic),
                      ),
                      Text(
                        ub,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Colors.white70,
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.red[400],
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                height: 80,
                width: 180,
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.local_hospital,
                        color: Colors.white60,
                        size: 30,
                      ),
                      Text(
                        "Total Hospitals",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.white70,
                            fontStyle: FontStyle.italic),
                      ),
                      Text(
                        th,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Colors.white70,
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.red[400],
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                height: 80,
                width: 180,
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.local_hotel,
                        color: Colors.white60,
                        size: 30,
                      ),
                      Text(
                        "Total Beds",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.white70,
                            fontStyle: FontStyle.italic),
                      ),
                      Text(
                        tb,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Colors.white70,
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ]));
  }
}
