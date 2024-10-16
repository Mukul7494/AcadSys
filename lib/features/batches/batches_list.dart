import 'package:acadsys/core/constants/router.dart';
import 'package:acadsys/features/batches/batch_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BatchesList extends StatefulWidget {
  const BatchesList({super.key});

  @override
  State<BatchesList> createState() => _BatchesListState();
}

class _BatchesListState extends State<BatchesList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(225, 255, 255, 255),
        appBar: AppBar(
          leading:
              IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
          title: const Text('Batches'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
              iconSize: 35,
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please Tab on Add Button to Add New Batchs',
              style: TextStyle(),
              textScaler: TextScaler.linear(1.3),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  return const BatchesCard();
                },
              ),
            ),
          ],
        ),
        floatingActionButton: Transform.scale(
          //this is to scale the button if want to
          scale: 1,
          child: FloatingActionButton(
            materialTapTargetSize: MaterialTapTargetSize.padded,
            shape: const CircleBorder(),
            onPressed: () {
              context.push(Routes.newBatch.path);
            },
            child: const Icon(
              Icons.add,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }
}
