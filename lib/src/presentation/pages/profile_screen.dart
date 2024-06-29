import 'package:flutter/material.dart';
import 'package:healthcare_app/src/models/userModel.dart';
import 'package:healthcare_app/src/services/userService.dart';
import 'package:intl/intl.dart';
import 'package:healthcare_app/src/router/router.dart';
import 'package:hexcolor/hexcolor.dart';

class ProfilePage extends StatefulWidget {
  User? userData;
  ProfilePage({super.key, this.userData});
  @override
  State<StatefulWidget> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  final UserService userService = UserService();
  TextEditingController _fullname = TextEditingController();
  TextEditingController _gender = TextEditingController();
  bool? _gendervalue = false;
  TextEditingController _phone = TextEditingController();
  TextEditingController _career = TextEditingController();
  TextEditingController _idnum = TextEditingController();
  TextEditingController _bloodtype = TextEditingController();
  static DateTime? _parseDate(String dateStr) {
    try {
      // First try to parse as ISO 8601
      return DateTime.parse(dateStr);
    } catch (e) {
      // If it fails, try to parse as 'dd/MM/yyyy'
      try {
        final DateFormat format = DateFormat('dd/MM/yyyy');
        return format.parse(dateStr);
      } catch (e) {
        print('Error parsing date: $e');
        return null;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fullname.text = widget.userData?.fullname ?? "";
    _gendervalue = widget.userData?.gender;
    _phone.text = widget.userData?.phone ?? "";
    _career.text = widget.userData?.career ?? "";
    _idnum.text = widget.userData?.cccd ?? "";
    _bloodtype.text = widget.userData?.blood_type ?? "";
    final DateFormat format = DateFormat('dd/MM/yyyy');
    _dateController.text = widget.userData?.birthday != null
        ? DateFormat('dd/MM/yyyy').format(widget.userData!.birthday!)
        : "";
  }

  Future<User?> _updateUserData(newData) async {
    final user = await userService.updateUserData(newData);
    if (user != null) {
      setState(() {
        widget.userData = user;
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          height: double.infinity,
          color: const Color(0xfffbedec),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (RouterCustom.router.canPop()) {
                            RouterCustom.router.pop();
                          }
                        },
                        child: Image.asset('res/images/go-back.png'),
                      ),
                      Text(
                        "PROFILE",
                        style: TextStyle(
                          color: HexColor("474672"),
                          fontFamily: "SourceSans3",
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Image.asset("res/images/noti.png"),
                    ],
                  ),
                ),
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 26, bottom: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Container(
                                width: 102,
                                height: 102,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage("res/images/avatar.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Change Avatar",
                                style: TextStyle(
                                  fontFamily: "SourceSans3",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: HexColor("FBAE9E"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        _buildInfoRow(
                            "Full Name", widget.userData?.fullname ?? ""),
                        const SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: Colors.black.withOpacity(0.1),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildInfoRow(
                            "Birthday",
                            widget.userData?.birthday != null
                                ? DateFormat('dd/MM/yyyy')
                                    .format(widget.userData!.birthday!)
                                : ""),
                        const SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: Colors.black.withOpacity(0.1),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildInfoRow(
                            "Gender",
                            widget.userData?.gender == true
                                ? "Female"
                                : (widget.userData?.gender == false
                                    ? "Male"
                                    : "Unknown")),
                        const SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: Colors.black.withOpacity(0.1),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildInfoRow("Phone", widget.userData?.phone ?? ""),
                        Divider(
                          color: Colors.black.withOpacity(0.1),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildInfoRow("Career", widget.userData?.career ?? ""),
                        const SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: Colors.black.withOpacity(0.1),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildInfoRow("ID Number", widget.userData?.cccd ?? ""),
                        const SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: Colors.black.withOpacity(0.1),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildInfoRow(
                            "Blood Type", widget.userData?.blood_type ?? ""),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 110),
                  child: ElevatedButton(
                    onPressed: () {
                      _showUpdatePopup(context);
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(248, 56),
                        backgroundColor: HexColor("474672")),
                    child: const Text(
                      "CHANGE INFORMATION",
                      style: TextStyle(
                        fontFamily: "SourceSans3",
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontFamily: "SourceSans3",
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontFamily: "SourceSans3",
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  void _showUpdatePopup(BuildContext context) {
    _fullname.text = widget.userData?.fullname ?? '';
    _phone.text = widget.userData?.phone ?? '';
    _career.text = widget.userData?.career ?? '';
    _idnum.text = widget.userData?.cccd ?? '';
    _bloodtype.text = widget.userData?.blood_type ?? '';
    _gendervalue = widget.userData?.gender;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: const Text(
              'Update Information',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "SourceSans3",
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _fullname,
                    decoration: const InputDecoration(
                        labelText: 'Full Name',
                        labelStyle: TextStyle(
                          fontFamily: "SourceSans3",
                          fontSize: 18,
                        )),
                  ),
                  TextField(
                    controller: _dateController,
                    readOnly: true,
                    onTap: () => _showDatePicker(context),
                    decoration: const InputDecoration(
                        labelText: 'Birthday',
                        labelStyle: TextStyle(
                          fontFamily: "SourceSans3",
                          fontSize: 18,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          "Gender:",
                          style: TextStyle(
                            fontFamily: "SourceSans3",
                            fontSize: 18,
                          ),
                        ),
                        Column(
                          children: [
                            Radio<bool?>(
                              value: true,
                              groupValue: _gendervalue,
                              onChanged: (bool? value) {
                                setState(() {
                                  _gendervalue = value;
                                });
                              },
                            ),
                            Text('Female'),
                          ],
                        ),
                        Column(
                          children: [
                            Radio<bool>(
                              value: false,
                              groupValue: _gendervalue,
                              onChanged: (bool? value) {
                                setState(() {
                                  _gendervalue = value;
                                });
                              },
                            ),
                            Text('Male'),
                          ],
                        )
                      ],
                    ),
                  ),
                  TextField(
                    controller: _phone,
                    decoration: const InputDecoration(
                        labelText: 'Phone',
                        labelStyle: TextStyle(
                          fontFamily: "SourceSans3",
                          fontSize: 18,
                        )),
                  ),
                  TextField(
                    controller: _career,
                    decoration: const InputDecoration(
                        labelText: 'Career',
                        labelStyle: TextStyle(
                          fontFamily: "SourceSans3",
                          fontSize: 18,
                        )),
                  ),
                  TextField(
                    controller: _idnum,
                    decoration: const InputDecoration(
                        labelText: 'ID Number',
                        labelStyle: TextStyle(
                          fontFamily: "SourceSans3",
                          fontSize: 18,
                        )),
                  ),
                  TextField(
                    controller: _bloodtype,
                    decoration: const InputDecoration(
                        labelText: 'Blood Type',
                        labelStyle: TextStyle(
                          fontFamily: "SourceSans3",
                          fontSize: 18,
                        )),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  // Close the popup
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  User newData = User(
                      phone: _phone.text,
                      fullname: _fullname.text,
                      gender: _gendervalue,
                      career: _career.text,
                      birthday: _parseDate(_dateController.text),
                      cccd: _idnum.text,
                      blood_type: _bloodtype.text);
                  // print(newData.birthday);
                  _updateUserData(newData);
                },
                child: const Text('Update'),
              ),
            ],
          );
        });
      },
    );
  }

  final TextEditingController _dateController = TextEditingController();
  void _showDatePicker(BuildContext context) async {
    _dateController.text = widget.userData?.birthday != null
        ? DateFormat('dd/MM/yyyy').format(widget.userData!.birthday!)
        : "";
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('dd/MM/yyyy')
            .format(picked); // Set the picked date to the TextField
      });
    }
  }
}
