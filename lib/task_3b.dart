import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Medicalcollege medicalcollegefromjson(String str) =>
    Medicalcollege.fromJson(json.decode(str));

class Medicalcollege {
  bool success;
  Data data;
  String lastRefreshed;
  String lastOriginUpdate;

  Medicalcollege(
      {this.success, this.data, this.lastRefreshed, this.lastOriginUpdate});

  Medicalcollege.fromJson(Map<String, dynamic> json) {
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
  List<MedicalColleges> medicalColleges;
  List<String> sources;

  Data({this.medicalColleges, this.sources});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['medicalColleges'] != null) {
      medicalColleges = new List<MedicalColleges>();
      json['medicalColleges'].forEach((v) {
        medicalColleges.add(new MedicalColleges.fromJson(v));
      });
    }
    sources = json['sources'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.medicalColleges != null) {
      data['medicalColleges'] =
          this.medicalColleges.map((v) => v.toJson()).toList();
    }
    data['sources'] = this.sources;
    return data;
  }
}

class MedicalColleges {
  String state;
  String name;
  String city;
  String ownership;
  int admissionCapacity;
  int hospitalBeds;

  MedicalColleges(
      {this.state,
      this.name,
      this.city,
      this.ownership,
      this.admissionCapacity,
      this.hospitalBeds});

  MedicalColleges.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    name = json['name'];
    city = json['city'];
    ownership = json['ownership'];
    admissionCapacity = json['admissionCapacity'];
    hospitalBeds = json['hospitalBeds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    data['name'] = this.name;
    data['city'] = this.city;
    data['ownership'] = this.ownership;
    data['admissionCapacity'] = this.admissionCapacity;
    data['hospitalBeds'] = this.hospitalBeds;
    return data;
  }
}

class College extends StatefulWidget {
  @override
  _CollegeState createState() => _CollegeState();
}

class _CollegeState extends State<College> {
  Future<Medicalcollege> medi() async {
    http.Client client = http.Client();
    final jsonString = await client
        .get('https://api.rootnet.in/covid19-in/hospitals/medical-colleges');

    if (200 == jsonString.statusCode) {
      Medicalcollege data = medicalcollegefromjson(jsonString.body);
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
            Top4(),
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
                    width: 40,
                    child: Text(
                      "State Name",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    width: 50,
                    child: Text(
                      "Institute Name",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    width: 45,
                    child: Text(
                      "City",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    width: 45,
                    child: Text(
                      "Type",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    width: 45,
                    child: Text(
                      "Admission Capacity",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    width: 45,
                    child: Text(
                      "Hospital Beds",
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
                  future: medi(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else
                      return Statedata4(
                          medicalcollege: snapshot.data.data.medicalColleges);
                  }),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}

class Top4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/hosp.PNG"), fit: BoxFit.cover)),
      ),
    );
  }
}

class Statedata4 extends StatelessWidget {
  final List<MedicalColleges> medicalcollege;

  const Statedata4({Key key, this.medicalcollege}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: medicalcollege.length,
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
                      child: Text(medicalcollege[index].state),
                    ),
                    Container(
                      width: 60,
                      child: Text(medicalcollege[index].name),
                    ),
                    Container(
                      width: 60,
                      child: Text(medicalcollege[index].city),
                    ),
                    Container(
                      width: 60,
                      child: Text(medicalcollege[index].ownership),
                    ),
                    Container(
                      width: 40,
                      child: Text(
                          medicalcollege[index].admissionCapacity.toString()),
                    ),
                    Container(
                      width: 40,
                      child:
                          Text(medicalcollege[index].hospitalBeds.toString()),
                    ),
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
