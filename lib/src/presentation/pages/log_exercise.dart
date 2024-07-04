import 'package:flutter/material.dart';
import 'package:healthcare_app/src/router/router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

String formatDate(DateTime d) {
  return d.toString().substring(0, 19);
}

class LogExersise extends StatefulWidget {
  const LogExersise({super.key});

  @override
  State<StatefulWidget> createState() => _LogExersiseState();
}

class _LogExersiseState extends State<LogExersise> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _actiController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _startTimeController = TextEditingController();
  TextEditingController _durationController = TextEditingController();
  TextEditingController _distanceController = TextEditingController();
  TextEditingController _energyController = TextEditingController();

  late DateTime datetime = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: datetime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null) {
      setState(() {
          datetime = DateTime(pickedDate.year, pickedDate.month,
              pickedDate.day, datetime.hour, datetime.minute);
          _dateController.text = DateFormat('EEE, MMM d, yyyy').format(datetime);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(datetime),
    );
    if (pickedTime != null) {
      setState(() {
          datetime = DateTime(datetime.year, datetime.month,
              datetime.day, pickedTime.hour, pickedTime.minute);
          _startTimeController.text = "${datetime.hour.toString().padLeft(2, '0')}:${datetime.minute.toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            color: const Color(0xfffbedec),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 16,
                        bottom: 20,
                      ),
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
                            "walking".toUpperCase(),
                            style: TextStyle(
                              color: HexColor("474672"),
                              fontFamily: "SourceSans3",
                              fontSize: 36,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: TextButton(
                                onPressed: () {
                                  print("heheh");
                                },
                                child: const Text(
                                  "SAVE",
                                  style: TextStyle(
                                    fontFamily: "SourceSans3",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFFBAE9E), width: 1),
                          ),
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: TextFormField(
                            style: const TextStyle(
                              fontFamily: 'SourceSans3',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              errorMaxLines: 2,
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 10, 20, 0),
                              // prefixIcon: Image.asset('res/images/user-icon.png'),
                              hintText: "Activity",
                              labelText: "Activity",
                              labelStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: "SourceSans3",
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              hintStyle: const TextStyle(
                                fontFamily: 'SourceSans3',
                                fontSize: 14,
                                color: Color(0x80000000),
                                fontWeight: FontWeight.w400,
                              ),
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            controller: _actiController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter your Activity";
                              }
                              return null; // Email hợp lệ
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 34,
                        ),
                        Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFFBAE9E), width: 1),
                          ),
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: TextFormField(
                            onTap: () async {
                              await _selectDate(context);
                              print(DateFormat('EEE, MMM d, yyyy').format(datetime));
                            },
                            readOnly: true,

                            style: const TextStyle(
                              fontFamily: 'SourceSans3',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              errorMaxLines: 2,
                              contentPadding:
                              const EdgeInsets.fromLTRB(10, 10, 20, 0),
                              prefixIcon: Image.asset('res/images/calendar.png'),
                              hintText: "Date",
                              labelText: "Date",
                              labelStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: "SourceSans3",
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              hintStyle: const TextStyle(
                                fontFamily: 'SourceSans3',
                                fontSize: 14,
                                color: Color(0x80000000),
                                fontWeight: FontWeight.w400,
                              ),
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            controller: _dateController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter your Activity";
                              }
                              return null; // Email hợp lệ
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 34,
                        ),
                        Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFFBAE9E), width: 1),
                          ),
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: TextFormField(
                            onTap: () async {
                              await _selectTime(context);
                              print(DateFormat('EEE, MMM d, yyyy').format(datetime));
                            },
                            readOnly: true,

                            style: const TextStyle(
                              fontFamily: 'SourceSans3',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              errorMaxLines: 2,
                              contentPadding:
                              const EdgeInsets.fromLTRB(10, 10, 20, 0),
                              prefixIcon: Image.asset('res/images/clock.png'),
                              hintText: "Start Time",
                              labelText: "Start Time",
                              labelStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: "SourceSans3",
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              hintStyle: const TextStyle(
                                fontFamily: 'SourceSans3',
                                fontSize: 14,
                                color: Color(0x80000000),
                                fontWeight: FontWeight.w400,
                              ),
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            controller: _startTimeController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter your Activity";
                              }
                              return null; // Email hợp lệ
                            },
                          ),
                        ),
                        const SizedBox(height: 34,),
                        Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFFBAE9E), width: 1),
                          ),
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: TextFormField(
                            style: const TextStyle(
                              fontFamily: 'SourceSans3',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              errorMaxLines: 2,
                              contentPadding:
                              const EdgeInsets.fromLTRB(10, 10, 20, 0),
                              // prefixIcon: Image.asset('res/images/clock.png'),
                              hintText: "Minutes",
                              labelText: "Duration-min*",
                              labelStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: "SourceSans3",
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              hintStyle: const TextStyle(
                                fontFamily: 'SourceSans3',
                                fontSize: 14,
                                color: Color(0x80000000),
                                fontWeight: FontWeight.w400,
                              ),
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.number,
                            controller: _durationController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter duration ";
                              }
                              return null; // Email hợp lệ
                            },
                          ),
                        ),
                        const SizedBox(height: 34,),
                        Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFFBAE9E), width: 1),
                          ),
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: TextFormField(
                            style: const TextStyle(
                              fontFamily: 'SourceSans3',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              errorMaxLines: 2,
                              contentPadding:
                              const EdgeInsets.fromLTRB(10, 10, 20, 0),
                              // prefixIcon: Image.asset('res/images/clock.png'),
                              hintText: "Meters",
                              labelText: "Distance-meters*",
                              labelStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: "SourceSans3",
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              hintStyle: const TextStyle(
                                fontFamily: 'SourceSans3',
                                fontSize: 14,
                                color: Color(0x80000000),
                                fontWeight: FontWeight.w400,
                              ),
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.number,
                            controller: _distanceController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter distance";
                              }
                              return null; // Email hợp lệ
                            },
                          ),
                        ),
                        const SizedBox(height: 34,),
                        Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFFBAE9E), width: 1),
                          ),
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: TextFormField(
                            style: const TextStyle(
                              fontFamily: 'SourceSans3',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              errorMaxLines: 2,
                              contentPadding:
                              const EdgeInsets.fromLTRB(10, 10, 20, 0),
                              // prefixIcon: Image.asset('res/images/clock.png'),
                              hintText: "Calo",
                              labelText: "Energy-burned - calories*",
                              labelStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: "SourceSans3",
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              hintStyle: const TextStyle(
                                fontFamily: 'SourceSans3',
                                fontSize: 14,
                                color: Color(0x80000000),
                                fontWeight: FontWeight.w400,
                              ),
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.number,
                            controller: _energyController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter calo";
                              }
                              return null; // Email hợp lệ
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
