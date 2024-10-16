import 'package:acadsys/features/batches/day_selector.dart';
import 'package:acadsys/utils/custom_textfield.dart';
import 'package:acadsys/utils/full_space_button.dart';
import 'package:acadsys/utils/time_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NewBatch extends StatefulWidget {
  const NewBatch({super.key});

  @override
  State<NewBatch> createState() => _NewBatchState();
}

class _NewBatchState extends State<NewBatch> {
  TextEditingController batchNameController = TextEditingController();
  TextEditingController batchLocationController = TextEditingController();
  TextEditingController batchTeacherController = TextEditingController();
  TextEditingController batchTimeController = TextEditingController();
  TextEditingController batchMaximumSlotsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('New Batch'),
          leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
                title: 'Batch Name', controller: batchNameController),
            CustomTextField(
                title: 'Batch Location', controller: batchLocationController),
            CustomTextField(
                title: 'Batch Teacher', controller: batchTeacherController),
            const CustomTimePicker(),
            const SizedBox(height: 10),
            const Text(
              'Batch Days',
              textScaler: TextScaler.linear(1.5),
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Spacer(),
                SelectDayCard(day: 'Sun'),
                Spacer(),
                Spacer(),
                SelectDayCard(day: 'Mon'),
                Spacer(),
                Spacer(),
                SelectDayCard(day: 'Tue'),
                Spacer(),
                Spacer(),
                SelectDayCard(day: 'Wed'),
                Spacer(),
                Spacer(),
                SelectDayCard(day: 'Thu'),
                Spacer(),
                Spacer(),
                SelectDayCard(day: 'Fri'),
                Spacer(),
                Spacer(),
                SelectDayCard(day: 'Sat'),
                Spacer(),
              ],
            ),
            const SizedBox(height: 20),
            CustomTextField(
                title: 'Batch Maximum Slots',
                controller: batchMaximumSlotsController),
            const Spacer(),
            FullSpaceButton(
              onPressed: () {},
              label: 'Save Batch',
            ),
          ],
        ),
      ),
    );
  }
}
