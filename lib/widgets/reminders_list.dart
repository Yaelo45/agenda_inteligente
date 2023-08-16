import 'package:flutter/material.dart';
import 'package:appagenda/models/reminder.dart';

class RemindersList extends StatefulWidget {
  final List<Reminder> reminders;

  RemindersList(this.reminders);

  @override
  _RemindersListState createState() => _RemindersListState();
}

class _RemindersListState extends State<RemindersList> {
  void _showReminderDetails(BuildContext context, Reminder reminder) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detalles del Recordatorio'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Descripción: ${reminder.description}'),
              SizedBox(height: 8),
              Text('Fecha de inicio: ${reminder.startDate.toString()}'),
              Text('Fecha de fin: ${reminder.endDate.toString()}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.reminders.length,
      itemBuilder: (context, index) {
        final reminder = widget.reminders[index];
        return ListTile(
          onTap: () => _showReminderDetails(context, reminder),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _deleteReminder(index),
          ),
          title: Text('Descripción: ${reminder.description}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Fecha de inicio: ${reminder.startDate.toString()}'),
              Text('Fecha de fin: ${reminder.endDate.toString()}'),
            ],
          ),
        );
      },
    );
  }

  void _deleteReminder(int index) {
    setState(() {
      widget.reminders.removeAt(index);
    });
  }
}
