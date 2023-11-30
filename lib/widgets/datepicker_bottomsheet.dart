import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatePickerBottomSheet extends StatefulWidget {
  final Function(DateTime) onConfirm;

  const DatePickerBottomSheet({super.key, required this.onConfirm});

  @override
  DatePickerBottomSheetState createState() => DatePickerBottomSheetState();
}

class DatePickerBottomSheetState extends State<DatePickerBottomSheet> {
  DateTime selectedDate = DateTime.now();
  bool dateSelected = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: DateTime(2020, 1, 1),
                onDateTimeChanged: (DateTime newDate) {
                  selectedDate = newDate;
                  dateSelected = true;
                },
                minimumYear: 2000,
                maximumYear: 2025,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 16,
            ),
            child: ElevatedButton(
              child: const Text('Confirm'),
              onPressed: () {
                if (!dateSelected) {
                  selectedDate = DateTime.now();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Date Selection'),
                        content: const Text('Please select a date.'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  widget.onConfirm(selectedDate);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
