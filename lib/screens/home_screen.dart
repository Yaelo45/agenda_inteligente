import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:appagenda/screens/add_reminder_screen.dart';
import 'package:appagenda/widgets/reminders_list.dart';
import 'package:appagenda/models/reminder.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Reminder> _reminders = [];
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Agenda')),
      body: Row(
        children: [
          SizedBox(
            width: 300, // Ancho para el calendario
            child: TableCalendar(
              calendarFormat: CalendarFormat.month,
              focusedDay: _selectedDay,
              firstDay: DateTime(2000),
              lastDay: DateTime(2050),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                });
              },
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Agendados',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: RemindersList(_reminders),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddReminderDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  // Función para mostrar el cuadro de diálogo
  Future<void> _showAddReminderDialog(BuildContext context) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Agregar Recordatorio'),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.6, // Ajusta el ancho del contenido
            child: AddReminderScreen(),
          ),
        );
      },
    );

    if (result != null && result is Reminder) {
      setState(() {
        _reminders.add(result);
      });
    }
  }
}

