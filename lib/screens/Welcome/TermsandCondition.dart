import 'package:flutter/material.dart';
import 'package:projectsystem/screens/Welcome/Login/loginScreen.dart';

class TermsAndConditionsPage extends StatefulWidget {
  @override
  _TermsAndConditionsPageState createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  bool _isChecked = false;

  void navigateToDashboard() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Center(
              child: Image.asset(
                'assets/images/fdsap.png', // Replace with your image path
                width: 200,
                height: 200,
              ),
            ),
            Center(
              child: Text(
                "Terms and Conditions",
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xff800000),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Please read these terms and conditions carefully before using the app.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              "1. Acceptance of Terms\n\nBy using this app, you agree to comply with and be bound by these terms and conditions. If you do not agree to these terms, please do not use the app.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              "2. User Obligations\n\nYou agree to use the app in a manner consistent with all applicable laws and regulations. You are solely responsible for any content you post or share through the app.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              "3. Intellectual Property\n\nAll intellectual property rights in the app, including but not limited to copyrights, trademarks, and patents, are owned by the app developer.",
              style: TextStyle(fontSize: 16),
            ),
            // Add more sections of terms and conditions as needed
            SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (value) {
                    setState(() {
                      _isChecked = value!;
                    });
                  },
                ),
                Text(
                  'I agree with the terms and conditions',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xff800000), // Change the button color here
              ),
              onPressed: () {
                if (_isChecked) {
                  navigateToDashboard();
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Agreement Required"),
                        content: Text(
                            "Please agree to the terms and conditions before proceeding."),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }
}
