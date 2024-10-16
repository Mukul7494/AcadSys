import 'package:acadsys/utils/custom_textfield.dart';
import 'package:flutter/material.dart';

class CustomTimePicker extends StatefulWidget {
  const CustomTimePicker({super.key});

  @override
  State<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  TextEditingController timeController = TextEditingController();

  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
        timeController.text = _selectedTime.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectTime(context),
      child: CustomTextField(
        title: 'Batch Time',
        controller: timeController,
        isDisabled: true,
      ),
    );
    // Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Time Picker Demo'),
    //   ),
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         Text(
    //           'Selected Time: ${_selectedTime.format(context)}',
    //           style: const TextStyle(fontSize: 24),
    //         ),
    //         const SizedBox(height: 20),
    //         ElevatedButton(
    //           onPressed: () => _selectTime(context),
    //           child: const Text('Select Time'),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
