import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:healthcare_app/src/router/router.dart';
import 'package:hexcolor/hexcolor.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<StatefulWidget> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
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
                        _buildInfoRow("Full Name", "Bích Ly"),
                        const SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: Colors.black.withOpacity(0.1),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildInfoRow("Birthday", "24/10/2003"),
                        const SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: Colors.black.withOpacity(0.1),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildInfoRow("Gender", "Nữ"),
                        const SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: Colors.black.withOpacity(0.1),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildInfoRow("Phone", "0819713627"),
                        Divider(
                          color: Colors.black.withOpacity(0.1),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildInfoRow("Career", "Sinh viên"),
                        const SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: Colors.black.withOpacity(0.1),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildInfoRow("ID Number", "054303000163"),
                        const SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: Colors.black.withOpacity(0.1),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildInfoRow("Blood Type", "B"),
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
                const TextField(
                  decoration: InputDecoration(
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
                const TextField(
                  decoration: InputDecoration(
                      labelText: 'Gender',
                      labelStyle: TextStyle(
                        fontFamily: "SourceSans3",
                        fontSize: 18,
                      )),
                ),
                const TextField(
                  decoration: InputDecoration(
                      labelText: 'Phone',
                      labelStyle: TextStyle(
                        fontFamily: "SourceSans3",
                        fontSize: 18,
                      )),
                ),
                const TextField(
                  decoration: InputDecoration(
                      labelText: 'Career',
                      labelStyle: TextStyle(
                        fontFamily: "SourceSans3",
                        fontSize: 18,
                      )),
                ),
                const TextField(
                  decoration: InputDecoration(
                      labelText: 'ID Number',
                      labelStyle: TextStyle(
                        fontFamily: "SourceSans3",
                        fontSize: 18,
                      )),
                ),
                const TextField(
                  decoration: InputDecoration(
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
                // Handle update logic here
                // You can access the input field values and update the user information
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  final TextEditingController _dateController = TextEditingController();
  void _showDatePicker(BuildContext context) async {
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
