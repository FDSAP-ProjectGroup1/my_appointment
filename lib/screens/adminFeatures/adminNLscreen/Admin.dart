import 'package:flutter/material.dart';
import 'package:projectsystem/screens/Dashboard/Appointment/addScreen.dart';

class AdminScreen extends StatelessWidget {
  final List<Appointment> appointments;
  final Function(Appointment) onAppointmentAction;

  AdminScreen({
    required this.appointments,
    required this.onAppointmentAction,
  });

  bool isAppointmentConflict(Appointment newAppointment) {
    for (var appointment in appointments) {
      if (appointment.date == newAppointment.date &&
          appointment.time == newAppointment.time) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade900,
        title: Text('Admin Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => addScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];

          return ListTile(
            title: Text(appointment.title),
            subtitle:
                Text(appointment.reason + "\n" + appointment.date.toString()),
            leading: Text(appointment.time),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    onAppointmentAction(appointment);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    onAppointmentAction(appointment);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
