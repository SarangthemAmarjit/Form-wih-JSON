import 'package:flutter/material.dart';

class Page2 extends StatefulWidget {
  String? post;
  String? name;
  String? email;
  String? password;
  String? phone_number;
  String? address;
  String? qualification;
  String? gen;
  Page2(
      {Key? key,
      required this.post,
      required this.name,
      required this.email,
      required this.password,
      required this.phone_number,
      required this.address,
      required this.qualification,
      required this.gen})
      : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Preview Form")),
      body: Column(
        children: [
          SizedBox(
            height: 300.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("POST: " + (widget.post ?? ''),
                    style: TextStyle(fontSize: 16)),
                Text("NAME: " + (widget.name ?? ''),
                    style: TextStyle(fontSize: 16)),
                Text("EMAIL: " + (widget.email ?? ''),
                    style: TextStyle(fontSize: 16)),
                Text("PASSWORD: " + (widget.password ?? ''),
                    style: TextStyle(fontSize: 16)),
                Text("PHONE NUMBER: " + (widget.phone_number ?? ''),
                    style: TextStyle(fontSize: 16)),
                Text("ADDRESS: " + (widget.address ?? ''),
                    style: TextStyle(fontSize: 16)),
                Text("QUALIFICATION: " + (widget.qualification ?? ''),
                    style: TextStyle(fontSize: 16)),
                Text("GENDER: " + (widget.gen ?? ''),
                    style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
