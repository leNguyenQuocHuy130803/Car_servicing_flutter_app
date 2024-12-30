import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePickerCustom extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  DateTimePickerCustom({required this.onDateSelected});

  @override
  _DateTimePickerCustomState createState() => _DateTimePickerCustomState();
}

class _DateTimePickerCustomState extends State<DateTimePickerCustom> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime? selectedDateTime;

  bool _decideWhichDayToEnable(DateTime day) {
    return day.isAfter(DateTime.now().subtract(const Duration(days: 1))) &&
           day.isBefore(DateTime.now().add(const Duration(days: 90)));
  }

  bool _isTimeWithinRange(TimeOfDay time) {
    final int timeInMinutes = time.hour * 60 + time.minute;
    const int startTimeInMinutes = 8 * 60; // 08:00 AM
    const int endTimeInMinutes = 17 * 60; // 05:00 PM
    return timeInMinutes >= startTimeInMinutes && timeInMinutes <= endTimeInMinutes;
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      selectableDayPredicate: _decideWhichDayToEnable,
      builder: (context, child) => Theme(data: ThemeData.light(), child: child ?? const SizedBox.shrink()),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (context, child) => Theme(data: ThemeData.light(), child: child ?? const SizedBox.shrink()),
      );

      if (pickedTime != null) {
        if (_isTimeWithinRange(pickedTime)) {
          setState(() {
            selectedDate = pickedDate;
            selectedTime = pickedTime;
            selectedDateTime = DateTime(
              selectedDate.year,
              selectedDate.month,
              selectedDate.day,
              selectedTime.hour,
              selectedTime.minute,
            );
          });
          widget.onDateSelected(selectedDateTime!);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please select a time between 08:00 AM and 05:00 PM.'),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (selectedDateTime != null)
          Text(
            DateFormat('yyyy-MM-dd HH:mm').format(selectedDateTime!),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        const SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () => selectDate(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
          child: const Text(
            'Select',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
