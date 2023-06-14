import 'package:flutter/material.dart';
import 'package:projectsystem/screens/adminFeatures/adminNLscreen/Admin.dart';

class addScreen extends StatefulWidget {
  @override
  _addScreenState createState() => _addScreenState();
}

class _addScreenState extends State<addScreen> {
  late DateTime selectedDate = DateTime.now();
  late TimeOfDay selectedTime = TimeOfDay.now();
  late String appointmentTitle;
  late String appointmentReason;

  List<Appointment> appointments = [];

  void submitAppointment(BuildContext context) {
    Appointment newAppointment = Appointment(
      date: selectedDate,
      time: selectedTime.format(context),
      title: appointmentTitle,
      reason: appointmentReason,
    );

    appointments.add(newAppointment);

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => AdminScreen(
        appointments: appointments,
        onAppointmentAction: (appointment) {
          setState(() {
            appointment.approved = !appointment.approved;
          });
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                padding: EdgeInsets.zero,
                width: MediaQuery.of(context).size.width,
                height: 60,
                decoration: BoxDecoration(
                  color: Color(0x00000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.zero,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xff000000),
                          size: 24,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Text(
                      "CREATE APPOINTMENT",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 10,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.blueGrey.shade100,
                height: 20,
                thickness: 1,
                indent: 0,
                endIndent: 0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Choose Date",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 20,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.zero,
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.blueAccent.shade100,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: InkWell(
                  onTap: () async {
                    final selected = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 365)),
                    );
                    if (selected != null) {
                      setState(() {
                        selectedDate = selected;
                      });
                    }
                  },
                  child: Center(
                    child: Text(
                      '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Choose Time",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 20,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.zero,
                width: 250,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.tealAccent.shade400,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: InkWell(
                  onTap: () async {
                    final selected = await showTimePicker(
                      context: context,
                      initialTime: selectedTime,
                    );
                    if (selected != null) {
                      setState(() {
                        selectedTime = selected;
                      });
                    }
                  },
                  child: Center(
                    child: Text(
                      selectedTime.format(context),
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Appointment Title",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 20,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.zero,
                width: 250,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      appointmentTitle = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Appointment Reason",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 20,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.zero,
                width: 250,
                height: 100,
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      appointmentReason = value;
                    });
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () => submitAppointment(context),
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getTimeFromIndex(int index) {
    return '${index.toString().padLeft(2, '0')}:00';
  }
}

class Appointment {
  final DateTime date;
  final String time;
  final String title;
  final String reason;
  bool approved;

  Appointment({
    required this.date,
    required this.time,
    required this.title,
    required this.reason,
    this.approved = false,
  });
}

//import 'package:flutter/material.dart';
//
// class AddScreen extends StatefulWidget {
//   @override
//   _AddScreenState createState() => _AddScreenState();
// }
//
// class _AddScreenState extends State<AddScreen> {
//   late DateTime selectedDate = DateTime.now();
//   late TimeOfDay selectedTime = TimeOfDay.now();
//   late String appointmentTitle;
//   late String appointmentReason;
//
//   List<Appointment> appointments = [];
//
//   void submitAppointment(BuildContext context) {
//     Appointment newAppointment = Appointment(
//       date: selectedDate,
//       time: selectedTime.format(context),
//       title: appointmentTitle,
//       reason: appointmentReason,
//       approved: false, // Set the initial approval status to false
//     );
//
//     setState(() {
//       appointments.add(newAppointment);
//     });
//
//     // Show a success message or navigate to a confirmation screen
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               // ...existing code...
//               ElevatedButton(
//                 onPressed: () => submitAppointment(context),
//                 child: Text('Submit'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   String getTimeFromIndex(int index) {
//     return '${index.toString().padLeft(2, '0')}:00';
//   }
// }
//
// class Appointment {
//   final DateTime date;
//   final String time;
//   final String title;
//   final String reason;
//   bool approved;
//
//   Appointment({
//     required this.date,
//     required this.time,
//     required this.title,
//     required this.reason,
//     this.approved = false,
//   });
// }
