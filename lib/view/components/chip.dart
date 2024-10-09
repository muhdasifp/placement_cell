import 'package:flutter/material.dart';

class SimpleChip extends StatelessWidget {
  final String data;

  const SimpleChip({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 1),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey.shade400)),
      child: Text(data),
    );
  }
}
