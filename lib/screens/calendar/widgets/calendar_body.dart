import 'package:consvita/core/global_imports.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:consvita/screens/calendar/widgets/todo_list.dart';

/// Główny ekran kalendarza
class CalendarBody extends StatefulWidget {
  const CalendarBody({super.key});

  @override
  State<CalendarBody> createState() => _CalendarBodyState();
}

class _CalendarBodyState extends State<CalendarBody> {
  /// Aktualnie widoczna data
  DateTime _focusedDay = DateTime.now();

  /// Aktualnie wybrany dzień
  DateTime _selectedDay = DateTime.now();

  /// Aktualny format kalendarza (np. miesiąc, tydzień)
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime.utc(2010, 01, 01),
          lastDay: DateTime.utc(2030, 01, 01),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
          locale: context.locale.toString(),
          calendarFormat: _calendarFormat,
          startingDayOfWeek: StartingDayOfWeek.monday,
          onFormatChanged: (format) {
            setState(() {
              _calendarFormat = format;
            });
          },
          onDaySelected: (selected, focused) {
            setState(() {
              _selectedDay = selected;
              _focusedDay = focused;
            });
          },
          calendarStyle: const CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Colors.blueAccent,
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: Colors.deepPurple,
              shape: BoxShape.circle,
            ),
            weekendTextStyle: TextStyle(color: Colors.red),
            outsideDaysVisible: false, // tylko dni z aktualnego miesiąca
          ),
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) {
              if (day.weekday == DateTime.saturday) {
                return Center(
                  child: Text(
                    '${day.day}',
                    style: const TextStyle(color: Colors.yellow),
                  ),
                );
              } else if (day.weekday == DateTime.sunday) {
                return Center(
                  child: Text(
                    '${day.day}',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }
              return null;
            },
            dowBuilder: (context, day) {
              final text = DateFormat.E(context.locale.toString()).format(day);
              final isSaturday = day.weekday == DateTime.saturday;
              final isSunday = day.weekday == DateTime.sunday;

              return Center(
                child: Text(
                  text,
                  style: TextStyle(
                    color: isSunday
                        ? Colors.red
                        : isSaturday
                            ? Colors.yellow[700]
                            : null,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(child: TodoList(selectedDate: _selectedDay)),
      ],
    );
  }
}