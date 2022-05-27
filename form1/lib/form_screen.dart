import 'package:flutter/material.dart';
import 'package:form1/preferences_services.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'personal.dart';
import 'package:marquee/marquee.dart';
import 'doc1.dart';
import 'doc2.dart';
import 'doc3.dart';
import 'doc4.dart';
import 'page2.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> with TickerProviderStateMixin {
  SharedPref sharedPref = SharedPref();

  User? userSave;
  User? userLoad;

  loadSharedPrefs() async {
    try {
      User user = User.fromJson(await sharedPref.read("user") ?? '');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: new Text("Loaded!"),
          duration: const Duration(milliseconds: 500)));
      setState(() {
        userLoad = user;
      });
    } catch (Excepetion) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: new Text("Nothing found!"),
          duration: const Duration(milliseconds: 500)));
    }
  }

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _numberController = TextEditingController();
  final _addressController = TextEditingController();
/*
  @override
  void initState() {
    super.initState();
    _popularfield();
  }

  void _popularfield() async {
    final Savedata = await _preferencesService.getSavedata();
    setState(() {
      itemvalue = Savedata.post;
      _usernameController.text = Savedata.username;
      _emailController.text = Savedata.email;
      _passwordController.text = Savedata.password;
      _numberController.text = Savedata.phonenumber;
      _addressController.text = Savedata.address;
      itemvalue2 = Savedata.qualification;
      _character = Savedata.gen;
    });
  }

  void _savenew() {
    final newSave = Savedata(
      post: itemvalue ?? '',
      username: _usernameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      phonenumber: _numberController.text,
      address: _addressController.text,
      qualification: itemvalue2 ?? '',
      gen: _character,
    );

    print(newSave);
    _preferencesService.finalsave(newSave);
  }*/

  gender _character = gender.Male;
  List<String> listitem = [
    'App Developer',
    'Website developer',
    'Graphic Designer',
    'Video Editing',
    'Other'
  ];
  String? itemvalue;
  String? itemvalue2;
  List<String> listitem2 = [
    'BCA',
    'B.TECH',
    'MCA',
    'MSC IT',
    'M.TECH',
    'OTHER'
  ];

  var format = DateFormat("yyyy-MM-dd");

  DateTime? birthDate;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  Widget _buildNameField() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: TextFormField(
          controller: _usernameController,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              labelText: 'Name',
              labelStyle: TextStyle(color: Colors.black),
              icon: Icon(
                Icons.person,
                color: Colors.blue,
              )),
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Name is required';
            }
            if (!RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$")
                .hasMatch(value)) {
              return "Please Enter a Valid Name";
            }
          },
          onSaved: (value) {}),
    );
  }

  Widget _buildEmail() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              labelText: 'Email',
              labelStyle: TextStyle(color: Colors.black),
              icon: Icon(
                Icons.mail,
                color: Colors.red,
              )),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Email is required';
            }
            if (!RegExp(
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                .hasMatch(value)) {
              return "Please Enter a Valid Email Address";
            }
          },
          onSaved: (value) {}),
    );
  }

  Widget _buildPassword() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              labelText: 'Password',
              labelStyle: TextStyle(color: Colors.black),
              icon: Icon(
                Icons.lock,
                color: Colors.black,
              )),
          keyboardType: TextInputType.visiblePassword,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password is required';
            }
          },
          onSaved: (value) {}),
    );
  }

  Widget _buildPhoneNumber() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
          controller: _numberController,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              labelText: 'Phone Number',
              labelStyle: TextStyle(color: Colors.black),
              icon: Icon(
                Icons.phone,
                color: Colors.green,
              )),
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Phone number is required';
            }
            if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(value)) {
              return "Please Enter a Valid Phone Number";
            }
          },
          onSaved: (value) {}),
    );
  }

  Widget _buildAddress() {
    return TextFormField(
        controller: _addressController,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            labelText: 'Address',
            labelStyle: TextStyle(color: Colors.black),
            icon: Icon(
              Icons.place,
              color: Colors.pink[900],
            )),
        keyboardType: TextInputType.streetAddress,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Address is required';
          }
        },
        onSaved: (value) {});
  }

  Widget _buildQualification() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Icon(
            Icons.cast_for_education_outlined,
            color: Colors.blueAccent,
          ),
        ),
        Text(
          "Qualification",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        DropdownButtonHideUnderline(
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: DropdownButton<String>(
              value: itemvalue2,
              hint: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("Select"),
              ),
              items: listitem2.map((item2) {
                return DropdownMenuItem<String>(
                  value: item2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(item2),
                  ),
                );
              }).toList(),
              onChanged: (String? newchange1) {
                setState(() {
                  itemvalue2 = newchange1!;
                });
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _buildAge() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_month_rounded,
                  color: Colors.deepPurpleAccent,
                  size: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text("Date of Birth ",
                      style: TextStyle(color: Colors.black, fontSize: 16)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 42, bottom: 10),
            child: DateTimeField(
              format: format,
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                    context: context,
                    initialDate: currentValue ?? DateTime.now(),
                    firstDate: DateTime(2010),
                    lastDate: DateTime(2025),
                    helpText: "SELECT DATE OF BIRTH",
                    cancelText: "CANCEL",
                    confirmText: "OK",
                    fieldHintText: "DATE/MONTH/YEAR",
                    fieldLabelText: "ENTER YOUR DATE OF BIRTH",
                    errorFormatText: "Enter a Valid Date",
                    errorInvalidText: "Date Out of Range");
              },
            ),
          ),
        ]);
  }

  Widget _buildGender() {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.male_sharp,
              color: Colors.deepOrange,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 17),
              child: Text(
                "Gender",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ],
        ),
        RadioListTile(
            toggleable: true,
            title: Text("Male"),
            value: gender.Male,
            groupValue: _character,
            onChanged: (value) {
              setState(() {
                _character = value as gender;
              });
            }),
        RadioListTile(
            title: Text("Female"),
            value: gender.Female,
            groupValue: _character,
            onChanged: (value) {
              setState(() {
                _character = value as gender;
              });
            }),
        RadioListTile(
            title: Text("Other"),
            value: gender.Other,
            groupValue: _character,
            onChanged: (value) {
              setState(() {
                _character = value as gender;
              });
            }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabcontroller = TabController(length: 3, vsync: this);
    return Scaffold(
        appBar: AppBar(
          title: Text("Form"),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Marquee(
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),

                    blankSpace: 200,

                    velocity: 150,
                    textScaleFactor: 1.06,
                    pauseAfterRound: Duration(seconds: 1),
                    showFadingOnlyWhenScrolling: true,
                    //fadingEdgeStartFraction: 0.1,
                    //fadingEdgeEndFraction: 0.1,
                    startPadding: 10,
                    accelerationDuration: Duration(seconds: 1),
                    accelerationCurve: Curves.linear,
                    decelerationDuration: Duration(milliseconds: 600),
                    decelerationCurve: Curves.easeOut,

                    text: 'Last date of Registration is 25th May 2022',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Text(
                  "APPLICATION FORM",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("POST APPLIED FOR :",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  Container(
                      height: 40,
                      width: 200,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 0.5),
                          borderRadius: BorderRadius.circular(5)),
                      margin: EdgeInsets.all(16),
                      child: DropdownButtonHideUnderline(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: DropdownButton<String>(
                            value: itemvalue,
                            hint: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text("Select Your Post"),
                            ),
                            items: listitem.map((item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(item),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newchange) {
                              setState(() {
                                itemvalue = newchange!;
                              });
                            },
                          ),
                        ),
                      ))
                ],
              ),
              Container(
                child: TabBar(
                    unselectedLabelColor: Colors.grey,
                    labelColor: Colors.black87,
                    controller: _tabcontroller,
                    tabs: [
                      Tab(
                        text: "Personal Detail",
                      ),
                      Tab(
                        text: "Doc upload",
                      ),
                      Tab(
                        text: "Preview Form",
                      )
                    ]),
              ),
              Container(
                width: double.maxFinite,
                height: 1000,
                child: TabBarView(controller: _tabcontroller, children: [
                  Container(
                    margin: EdgeInsets.all(24),
                    child: Form(
                        key: _formkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _buildNameField(),
                            _buildEmail(),
                            _buildPassword(),
                            _buildPhoneNumber(),
                            _buildAddress(),
                            _buildQualification(),
                            _buildAge(),
                            _buildGender(),
                            SizedBox(
                              height: 100,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 70,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: [Colors.blue, Colors.red])),
                                ),
                                ElevatedButton(
                                    onPressed: () => {
                                          if (_formkey.currentState!.validate())
                                            {
                                              sharedPref.save("user", userSave),
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content:
                                                          new Text("Saved!"),
                                                      duration: const Duration(
                                                          milliseconds: 500)))
                                            }
                                          else
                                            print("Form Hanghangano")
                                        },
                                    child: Text(
                                      'Save',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    )),
                                ElevatedButton(
                                  onPressed: () {
                                    loadSharedPrefs();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Page2(
                                              post: userLoad!.post,
                                              name: userLoad!.name,
                                              email: userLoad!.email,
                                              password: userLoad!.password,
                                              phone_number:
                                                  userLoad!.phone_number,
                                              address: userLoad!.address,
                                              qualification:
                                                  userLoad!.qualification,
                                              gen: userLoad!.gen!.name),
                                        ));
                                  },
                                  child: Text('Next',
                                      style: TextStyle(fontSize: 20)),
                                ),
                                /*
                                ElevatedButton(
                                  onPressed: () {
                                    sharedPref.remove("user");
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: new Text("Cleared!"),
                                            duration: const Duration(
                                                milliseconds: 500)));
                                    setState(() {
                                      userLoad = User();
                                    });
                                  },
                                  child: Text('Clear',
                                      style: TextStyle(fontSize: 20)),
                                ),*/
                              ],
                            ),
                          ],
                        )),
                  ),
                  //2ND TAB BAR
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 30),
                        child: Text(
                          " UPLOAD REQUIRED DOCUMENTS",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                      Document1(),
                      Document2(),
                      Document3(),
                      Document4()
                    ],
                  ),
                  Center(
                    child: Text(
                      "PREVIEW DATA",
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ]),
              ),
            ],
          ),
        ));
  }
}
