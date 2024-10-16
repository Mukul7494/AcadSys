import 'package:flutter/material.dart';

class BatchesCard extends StatelessWidget {
  const BatchesCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 2)
        ],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: ListTile(
        contentPadding: const EdgeInsets.all(5),
        leading: const Icon(
          Icons.group_outlined,
          size: 50,
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Batch Name',
            ),
            Row(
              children: [
                Text(
                  'Batch timing',
                ),
                Spacer(),
                Text(
                  'Active',
                ),
                Spacer(),
              ],
            )
          ],
        ),
        trailing: IconButton(
            onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios)),
      ),
    );
  }
}
