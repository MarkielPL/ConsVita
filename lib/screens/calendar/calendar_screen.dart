import 'package:consvita/core/global_imports.dart';
import 'package:consvita/screens/calendar/widgets/calendar_body.dart';
import 'package:easy_localization/easy_localization.dart';

/// Kalendarz z listy zadań (ToDo)
class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('calendar'.tr()),
        centerTitle: true,
      ),
      body: CalendarBody(), // kalendarz i TodoList
    );
  }
}
