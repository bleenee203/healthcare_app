import 'package:flutter/material.dart';

class DiagnosisPage extends StatefulWidget {
  const DiagnosisPage({super.key});

  @override
  State<StatefulWidget> createState() => _DiagnosisPage();
}

class _DiagnosisPage extends State<DiagnosisPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Diagnosis Page',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
