// TODO  CONTROLLER DE FECHA y HORA CITA
import 'package:flutter/material.dart';

class DateController extends ChangeNotifier {
  TimeOfDay _timePicker = const TimeOfDay(hour: 8, minute: 0);
  DateController({required this.context});
  DateTime _initialDate = DateTime.now();
  BuildContext context;

  //? SELECT TIME
  void pickTime() async {
    TimeOfDay? timePicker = await showTimePicker(
      initialTime: const TimeOfDay(hour: 8, minute: 0),
      onEntryModeChanged: null,
      context: context,
    );

    _timePicker = timePicker!;
    notifyListeners();
  }

  //? SELECT DATE
  void selectDate() async {
    final DateTime? selectedDate = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.input,
      initialDate: DateTime.now(),
      lastDate: DateTime(9999),
      firstDate: DateTime(1),
      context: context,
    );

    _initialDate = selectedDate!;
    notifyListeners();
  }

  //? SET DATE
  set dateChange(DateTime date) {
    _initialDate = date;
    notifyListeners();
  }

  //? GET DATE & TIME
  DateTime get initialDate => _initialDate;
  TimeOfDay get timePicker => _timePicker;
}
